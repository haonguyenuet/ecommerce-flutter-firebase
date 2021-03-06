import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/feedback_provider.dart';
import 'package:e_commerce_app/screens/feedback/feedback_screen.dart';
import 'package:e_commerce_app/screens/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class CustomAppBar extends PreferredSize {
  final Product product;

  CustomAppBar({@required this.product});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            // Back home button
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Color(0xFFF5F6F9),
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  HomeScreen.routeName,
                ),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 16,
                ),
              ),
            ),
            Spacer(),

            /// Rating
            GestureDetector(
              onTap: () {
                context.read<FeedbackProvider>()
                  ..setProductId(product.id)
                  ..getFeedbacks();
                Navigator.pushNamed(context, FeedbackScreen.routeName);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "${product.rating}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
