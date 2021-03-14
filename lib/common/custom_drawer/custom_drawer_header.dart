import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/page_manager.dart';
import 'package:lojinha_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 138, 43, 226);
    return Container(
      padding: const EdgeInsets.fromLTRB(32,24,16,8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: Image(image: AssetImage('assets/logomarca2.png'), width: 180,),
              ),
              /*Text('Botique Modas',
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),),*/
              Text('Olá, ${userManager.user?.name ?? ' '}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          );
        }
      ),
    );
  }
}
