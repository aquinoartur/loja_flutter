import 'package:flutter/material.dart';
import 'package:lojinha_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojinha_virtual/models/page_manager.dart';
import 'package:lojinha_virtual/models/user_manager.dart';
import 'package:lojinha_virtual/screens/base/products/products_screen.dart';
import 'package:provider/provider.dart';
import 'admin_orders/admin_orders_screen.dart';
import 'admin_users/admin_users_screen.dart';
import 'home/home_screen.dart';
import 'meus_dados/meus_dados.dart';
import 'orders/orders_screen.dart';
import 'package:flutter/services.dart';

class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              OrdersScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home4'),
                ),
              ),
              if(userManager.isLoggedIn)
                ...[
                  MeuDadosScreen(),
                ]
                ,
              if(userManager.adminEnabled)
                ...[
                  AdminUsersScreen(),
                  AdminOrdersScreen(),
                ]
            ],
          );
        },
      )
    );
  }
}
