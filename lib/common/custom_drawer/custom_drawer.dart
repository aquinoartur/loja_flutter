import 'package:flutter/material.dart';
import 'package:lojinha_virtual/common/custom_drawer/drawer_tile.dart';
import 'package:lojinha_virtual/models/page_manager.dart';
import 'package:lojinha_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 138, 43, 226);
    return Consumer <UserManager>(
      builder: (_, userManager, __){
        return Drawer(
          child: ListView(
            children: [
              CustomDrawerHeader(),
              Divider(
              ),
              DrawerTile(iconData: Icons.home, title: 'Início', page: 0),
              DrawerTile(iconData: Icons.shopping_bag_rounded, title: 'Produtos', page: 1),
              DrawerTile(iconData: Icons.playlist_add_check, title: 'Meus Pedidos', page: 2),
              DrawerTile(iconData: Icons.location_on, title: 'Loja', page: 3),
              Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.isLoggedIn){
                    return Column(
                      children: <Widget>[
                        DrawerTile(
                          iconData: Icons.edit,
                          title: 'Meus Dados',
                          page: 4,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.adminEnabled){
                    return Column(
                      children: <Widget>[
                        const Divider(),
                        DrawerTile(
                          iconData: Icons.person_search,
                          title: 'Usuários',
                          page: 5,
                        ),
                        DrawerTile(
                          iconData: Icons.list
                          ,
                          title: 'Pedidos',
                          page: 6,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 22, right: 22),
                //decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  leading: userManager.isLoggedIn
                      ?  Icon(Icons.logout, size: 30,
                     color: Colors.red)
                      : Icon(Icons.login,
                      color: primaryColor),
                  title: Text(
                    userManager.isLoggedIn
                        ? 'Sair'
                        : 'Entre ou Cadastre-se',
                    style: TextStyle(
                      color: userManager.isLoggedIn
                          ? Colors.red
                      : primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  onTap: (){
                    if (userManager.isLoggedIn){
                      context.read<PageManager>().setPage(0);
                      userManager.SignOut();
                    } else {
                      Navigator.of(context).pushNamed('/login');
                    }

                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
