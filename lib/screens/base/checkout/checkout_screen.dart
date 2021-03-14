
import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/cart_manager.dart';
import 'package:lojinha_virtual/models/checkout_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
      checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
            builder: (_, checkoutManager, __){
              if(checkoutManager.loading){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        'Processando seu pagamento...',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                );
              }
              return Form(
                  key: formKey,
                  child: ListView(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Olá!',
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Selecione a modalidade desejada para realizar o pagamento do seu pedido.',
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                            ),
                          ),SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Após finalizar, acompanhe o andamento do seu pedido através do menu "Meus Pedidos".',
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                            ),
                          ),


                        ]
                    ), Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text ('Pagar com Cartão'),
                            onPressed: (){
                              Navigator.of(context).pushNamed('/checkout1');
                            },
                          ),
                        ),Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text ('Pagar por Transferência ou Pix'),
                            onPressed: (){
                              Navigator.of(context).pushNamed('/checkout2');
                            },
                          ),
                        ),Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text ('Pagar Presencialmente'),
                            onPressed: (){
                              Navigator.of(context).pushNamed('/checkout3');
                            },
                          ),
                        ),
                  ],
                  ),
              );
            }
        ),
      ),
    );
  }
}