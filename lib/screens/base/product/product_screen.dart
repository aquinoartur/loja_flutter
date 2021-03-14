import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/cart_manager.dart';
import 'package:lojinha_virtual/models/product.dart';
import 'package:provider/provider.dart';
import 'components/size_widget.dart';
import 'package:lojinha_virtual/models/user_manager.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),

            elevation:50,
            backgroundColor: primaryColor,
            //iconTheme: Icons.arrow_back,
            //title: Text(product.name),
            title: Text(product.name, style: TextStyle(color: Colors.white, fontSize: 17),),
            centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnabled && !product.deleted){
                  return IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(
                          '/edit_product',
                          arguments: product
                      );
                    },
                  );
                } else {
                  return IconButton(icon: Icon(Icons.home), color: Colors.white, onPressed: (){
                    Navigator.of(context).pushNamed('/base');
                  },);
                }
              },
            ),
            IconButton(icon: Icon(Icons.shopping_cart), color: Colors.white, onPressed: (){
              Navigator.of(context).pushNamed('/cart');
            },),

          ],
            leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white, onPressed: (){
              Navigator.pop(context);
            },),
        ),
        body: ListView(
          //padding: EdgeInsets.zero,
            children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Carousel(
                      images: product.images.map((url){
                        return NetworkImage(url);
                      }).toList(),
                      dotSize: 4,
                      dotSpacing: 15,
                      dotBgColor: Colors.transparent,
                      dotColor: primaryColor,
                      autoplay: false,
                    ),
                  ),
                ),
                Container(
                  //color: Colors.black54,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          product.name,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          )
                        ),
                      ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top:12, bottom: 3),
                        child: Text('A partir de:', style: TextStyle(color: Colors.grey[700], fontSize: 16),),
                    ),
                    Text('R\$ ${product.basePrice.toStringAsFixed(2)}',style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black

                        ),
                      ),
                    ),
                   Text(
                        product.description,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                        ),
                      ),
                    Divider(),
                      if(product.deleted)
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Text(
                            'Este produto não está mais disponível',
                            style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                                color: Colors.red
                        ),
                          )
                        ) else
                            ...[
                        Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(
                                'Tamanhos',
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                                ),
                                ),
                                ),
                          Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: product.sizes.map((s){
                          return SizeWidget(size: s);
                          }).toList(),
                          ),
                          ],
                    const SizedBox(height: 20,),
                    if(product.hasStock)
                      Consumer2<UserManager, Product>(
                        builder: (_, userManager, product, __){
                          return Container(

                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                            height: 45,
                            child: RaisedButton(
                              onPressed: product.selectedSize != null ? (){
                                if(userManager.isLoggedIn){
                                  context.read<CartManager>().addToCart(product);
                                  Navigator.of(context).pushNamed('/cart');
                                } else {
                                  Navigator.of(context).pushNamed('/login');
                                }
                              } : null,
                              color: primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              textColor: Colors.white,
                              child: Text(
                                userManager.isLoggedIn
                                    ? 'Adicionar ao Carrinho'
                                    : 'Entre para Comprar',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15,),

                  ],
                ),
              ),
            ],
          ),

      ),
    );
  }
}
