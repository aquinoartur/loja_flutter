import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojinha_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojinha_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class MeuDadosScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  get onPressed => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(),
      body: Consumer<UserManager>(
        builder: (_, userManager, __){
          return Form(
              key: formkey,
              child: ListView(
                  children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Cidade',

                    ),
                    validator: (cidade){
                      if (cidade.isEmpty){
                        return 'Inserir o nome da cidade';
                      }
                      return null;
                    },
                    onSaved: (cidade){
                      Firestore.instance
                          .collection('users')
                          .document(userManager.user.id)
                          .updateData({'cidade': cidade});
                    },
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.white,
                    onPressed: (){
                      if(formkey.currentState.validate()){
                        formkey.currentState.save();
                      }

                    },
                  )
                  ],
                  ) ,
          );
      }
      )
    );
  }
}
