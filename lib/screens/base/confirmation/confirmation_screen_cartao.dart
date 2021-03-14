import 'package:flutter/material.dart';
import 'package:lojinha_virtual/common/custom_drawer/order/order_product_tile.dart';
import 'package:lojinha_virtual/models/order.dart';


class ConfirmationScreenCartao extends StatelessWidget {

  const ConfirmationScreenCartao(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView(
          children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Olá, o seu pedido foi finalizado!',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
              ),
            ),]),
            Card(
              margin: const EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          order.formattedId,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          'R\$ ${order.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: order.items.map((e){
                      return OrderProductTile(e);
                    }).toList(),
                  )
                ],
              ),
            ),]
      ),
    );
  }
}