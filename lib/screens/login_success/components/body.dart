import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:e_commerce_app/screens/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _loggedUser = context.watch<AuthenticationProvider>().loggedUser;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Image.asset(
                  "assets/images/success.png",
                  height: SizeConfig.screenHeight * 0.5,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),

                /// Hello user
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: mSecondaryColor,
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: "Hello, "),
                      TextSpan(
                          text: "${_loggedUser.name} !",
                          style: TextStyle(color: mPrimaryColor))
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),

                /// Back to home button
                SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  child: DefaultButton(
                    text: "Back to home",
                    handleOnPress: () {
                      context.read<CartProvider>().getCart();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.routeName,
                        (_) => false,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
