import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/product.dart';
import 'package:lojinha_virtual/models/product_manager.dart';
import 'package:lojinha_virtual/models/user_manager.dart';
import 'package:lojinha_virtual/screens/base/base_screen.dart';
import 'package:lojinha_virtual/screens/base/cart/cart_screen.dart';
import 'package:lojinha_virtual/screens/base/checkout/checkout_screen.dart';
import 'package:lojinha_virtual/screens/base/checkout/checkout_screen_pix.dart';
import 'package:lojinha_virtual/screens/base/checkout/checkout_screen_cartao.dart';
import 'package:lojinha_virtual/screens/base/checkout/checkout_screen_presencial.dart';
import 'package:lojinha_virtual/screens/base/confirmation/confirmation_screen.dart';
import 'package:lojinha_virtual/screens/base/confirmation/confirmation_screen_cartao.dart';
import 'package:lojinha_virtual/screens/base/edit_product/edit_product_screen.dart';
import 'package:lojinha_virtual/screens/base/home/home_1.dart';
import 'package:lojinha_virtual/screens/base/home/home_2.dart';
import 'package:lojinha_virtual/screens/base/home/home_3.dart';
import 'package:lojinha_virtual/screens/base/login/login_screen.dart';
import 'package:lojinha_virtual/screens/base/product/product_screen.dart';
import 'package:lojinha_virtual/screens/base/select_product/select_product_screen.dart';
import 'package:lojinha_virtual/screens/base/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'models/admin_orders_manager.dart';
import 'models/admin_users_manager.dart';
import 'models/cart_manager.dart';
import 'models/home_manager.dart';
import 'models/order.dart';
import 'models/orders_manager.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
          adminUsersManager..updateUser(userManager),
        ),
            ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
            create: (_) => AdminOrdersManager(),
            lazy: false,
            update: (_, userManager, adminOrdersManager) =>
            adminOrdersManager..updateAdmin(
            adminEnabled: userManager.adminEnabled
            ),)

      ],
      child: MaterialApp(
        title: 'Serra Store',
        theme: ThemeData(

            primaryIconTheme: IconThemeData(color: Colors.white),
            accentIconTheme: IconThemeData(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
          primaryColor: const Color.fromARGB(255, 138, 43, 226),
          scaffoldBackgroundColor: const Color.fromARGB(255, 138, 43, 226),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: const Color.fromARGB(255, 138, 43, 226),
          )
        ),
        home: SplashScreenView(
          home: BaseScreen(),
          duration: 5000,
          imageSrc: "assets/logomarca.png",
          imageSize: 50,
          text: "Deeply Geek",
          textType: TextType.TyperAnimatedText,
          backgroundColor: const Color.fromARGB(255, 138, 43, 226),
          textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20
          ),
        ),
        onGenerateRoute: (settings){
          switch(settings.name){

            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
              case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(),
                  settings: settings
              );
            case '/home1':
              return MaterialPageRoute(
                  builder: (_) => Home1()
              );
            case '/home2':
              return MaterialPageRoute(
                  builder: (_) => Home2()
              );
            case '/home3':
              return MaterialPageRoute(
                  builder: (_) => Home3()
              );
            case '/checkout':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreen()
              );
            case '/checkout1':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreenCartao()
              );
            case '/checkout2':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreenPIX()
              );
            case '/checkout3':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreenPresencial()
              );
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) => EditProductScreen(
                      settings.arguments as Product
                  )
              );
            case '/select_product':
              return MaterialPageRoute(
                  builder: (_) => SelectProductScreen()
              );
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                      settings.arguments as Order
                  )
              );
            case '/confirmationc':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreenCartao(
                      settings.arguments as Order
                  )
              );
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
                  settings: settings
              );
          }
        },
      ),
    );
  }
}
