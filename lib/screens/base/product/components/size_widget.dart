import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/item_size.dart';
import 'package:lojinha_virtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {

  const SizeWidget({this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color;

    if(!size.hasStock)
      color = Colors.red.withAlpha(50);
    else if (selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(8),
          color: color,
          border: Border.all(
              color: color,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              //color: !size.hasStock ? Colors.red.withAlpha(50) : Color.fromARGB(255, 138, 43, 226),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                size.name,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Container(

              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                'R\$ ${size.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}