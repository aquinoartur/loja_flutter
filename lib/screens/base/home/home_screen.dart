import 'package:flutter/material.dart';
import 'package:lojinha_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojinha_virtual/models/home_manager.dart';
import 'package:lojinha_virtual/models/user_manager.dart';
import 'package:lojinha_virtual/screens/base/home/components/section_list_oval.dart';
import 'package:provider/provider.dart';
import 'components/add_section_widget.dart';
import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 138, 43, 226);

    return Scaffold(
      backgroundColor: Colors.white ,
      drawer: CustomDrawer(

      ),
      body: Stack(
        children: <Widget>[

          Container(
            color: Colors.grey.withAlpha(30),

          ),
          CustomScrollView(

            slivers: <Widget>[
              SliverAppBar(
                title: Text('Deeply Store', style:
                TextStyle(fontSize: 18, fontFamily: 'Roboto',color: Colors.white),),
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.white
                ),
                snap: true,
                expandedHeight: 160,
                floating: true,
                pinned: true,
                elevation: 5,
                stretch: true,
                backgroundColor: primaryColor,
                flexibleSpace: ListView(
                  children: [
                    SizedBox(height: 50,),
                    Container(

                      padding: EdgeInsets.only(top:30, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                        children: [

                          Container(

                            // ignore: deprecated_member_use
                            child: RaisedButton(onPressed: (){
                              Navigator.of(context).pushNamed('/home1');
                            },
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                              color: Colors.white,
                              textColor: primaryColor,
                              child: Center(
                                child: const Text('Camisetas', style: TextStyle(fontWeight: FontWeight.bold),),
                              ),),

                          ),Container(
                            // ignore: deprecated_member_use
                            child: RaisedButton(onPressed: (){
                              Navigator.of(context).pushNamed('/home2');
                            },
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                              color: Colors.white,
                              textColor: primaryColor,
                              child: Center(
                                child: const Text('Colecionáveis', style: TextStyle(fontWeight: FontWeight.bold),),
                              ),),
                          ),Container(
                            // ignore: deprecated_member_use
                            child: RaisedButton(onPressed: (){
                              Navigator.of(context).pushNamed('/home3');
                            },
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                color: Colors.white,
                                textColor: primaryColor,
                                child: Center(
                                  child: const Text('Outros', style: TextStyle(fontWeight: FontWeight.bold),),
                                )),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __){
                      if(userManager.adminEnabled && !homeManager.loading) {
                        if(homeManager.editing){
                          return PopupMenuButton(
                            onSelected: (e){
                              if(e == 'Salvar'){
                                homeManager.saveEditing();
                              } else {
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (_){
                              return ['Salvar', 'Descartar'].map((e){
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList();
                            },
                          );
                        } else {
                          return IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: homeManager.enterEditing,
                          );
                        }
                      } else return Container();
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                )
              )
              ,
              Consumer<HomeManager>(
                builder: (_, homeManager, __){
                  if(homeManager.loading){
                    return SliverToBoxAdapter(
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }
                  final List<Widget> children = homeManager.sections.map<Widget>(
                          (section) {

                        switch(section.type){
                          case 'List':
                            return SectionList(section);
                          case 'Oval':
                            return SectionListOval(section);
                          case 'Staggered':
                            return SectionStaggered(section);
                          default:
                            return Container();
                        }
                      }
                  ).toList();

                  if(homeManager.editing)
                    children.add(AddSectionWidget(homeManager));

                  return SliverList(
                    delegate: SliverChildListDelegate(children),

                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}