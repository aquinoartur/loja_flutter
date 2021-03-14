import 'package:flutter/material.dart';
import 'package:lojinha_virtual/common/custom_drawer/price_card.dart';
import 'package:lojinha_virtual/models/cart_manager.dart';
import 'package:lojinha_virtual/models/checkout_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreenPresencial extends StatelessWidget {

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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('O pagamento presencial poderá ser feito com dinheiro em espécie, transferência, Pix ou pela maquininha...',
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ]
                    ),
                    SizedBox(height: 30,),
                    PriceCard(
                      buttonText: 'Finalizar Pedido',
                      onPressed: (){
                        if(formKey.currentState.validate()){
                          print('enviar');
                          checkoutManager.checkout(
                                      onStockFail: (e){
                                        Navigator.of(context).popUntil(
                                                (route) => route.settings.name == '/cart');
                                      },
                                      onSuccess: (order){
                                        
                                        Navigator.of(context).pushNamed(
                                            '/confirmation',
                                            arguments: order
                                        );
                                      }
                                  );
                        }
                      },
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