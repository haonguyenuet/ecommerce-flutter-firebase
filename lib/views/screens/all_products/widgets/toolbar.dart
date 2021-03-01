import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/all_products/widgets/sort_option_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolBar extends StatefulWidget {
  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      final keyword = _searchController.text;
      if (keyword.isNotEmpty) {
        BlocProvider.of<AllProductsBloc>(context)
            .add(SearchQueryChanged(keyword: keyword));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllProductsBloc, AllProductsState>(
      listenWhen: (prevState, currState) => currState is OpenSortOption,
      listener: (context, state) {
        if (state is OpenSortOption) {
          _openSortOptionsDialog(context, state);
        }
      },
      buildWhen: (prevState, currState) => currState is UpdateToolbarState,
      builder: (context, state) {
        if (state is UpdateToolbarState) {
          return Container(
            height: 50,
            color: mDarkShadeColor,
            child: Row(
              children: <Widget>[
                _buildLeading(context),
                Expanded(child: _buildTitle(state)),
                _buildActions(context, state),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  _buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: mAccentTintColor),
      onPressed: () => Navigator.pop(context),
    );
  }

  _buildActions(BuildContext context, UpdateToolbarState state) {
    return Row(
      children: [
        // Search action
        IconButton(
          icon: Icon(
            state.showSearchField ? Icons.close : Icons.search,
            color: mAccentTintColor,
          ),
          onPressed: () {
            BlocProvider.of<AllProductsBloc>(context).add(
                state.showSearchField ? ClickCloseSearch() : ClickIconSearch());
          },
        ),
        // Sort action
        IconButton(
          icon: Icon(Icons.sort, color: mAccentTintColor),
          onPressed: () {
            BlocProvider.of<AllProductsBloc>(context).add(ClickIconSort());
          },
        ),
      ],
    );
  }

  _buildTitle(UpdateToolbarState state) {
    if (state.showSearchField) {
      _searchController.text = "";
      return Container(
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.only(top: 0),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      );
    } else
      return Text(
        'All Products',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
  }

  _openSortOptionsDialog(BuildContext context, OpenSortOption state) async {
    var response = await showDialog<ProductSortOption>(
      context: context,
      builder: (context) {
        return SortOptionDialog(currSortOption: state.currSortOption);
      },
    );
    if (response is ProductSortOption) {
      BlocProvider.of<AllProductsBloc>(context)
          .add(SortOptionsChanged(response));
    }
  }
}