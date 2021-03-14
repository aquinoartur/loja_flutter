import 'package:flutter/material.dart';
import 'package:lojinha_virtual/common/custom_drawer/order/order_product_tile.dart';
import 'package:lojinha_virtual/models/order.dart';
import 'package:url_launcher/url_launcher.dart';

abrirUrl() async {
  //String url = 'https://mywhats.net/geekstore';
  String url = 'https://api.whatsapp.com/send?phone=5584999587787';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ConfirmationScreen extends StatelessWidget {

  const ConfirmationScreen(this.order);

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
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Entraremos em contato pelo seu WhatsApp assim que possível. Caso prefira, entre em contato conosco através do nosso WhatsApp.',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                ),

              ]
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FlatButton(
                onPressed: (){
                  abrirUrl();
                },
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call, color: Colors.green[700]),
                    Text ('  WhatsApp Geek Store',
                      style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold),)
                  ],
                ),

              ),
            ),
          SizedBox(height: 10),

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