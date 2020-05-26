import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/temp/product_item.dart';
import 'package:flutterapp/widgets/app_bar.dart';

class TouchMe extends StatefulWidget {
  final List<String> products;

  TouchMe({Key key, this.products});

  @override
  State createState() => _TouchCount();
}

class _TouchCount extends State<TouchMe> {
  Set<String> _shoppingCart = new Set<String>();

  void _handleCartChanged(String product, bool inCart) {
    setState(() {
      // When user changes what is in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.
      if (inCart) {
        _shoppingCart.add(product);
      } else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new MyAppBar(
        title: 'Shopping List',
      ),
      body: new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: widget.products.map((String product) {
            return ShoppingListItem(
              inCart: _shoppingCart.contains(product),
              product: product,
              onCartChanged: _handleCartChanged,
            );
          }).toList()),
    );
  }
}
