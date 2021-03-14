import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/home_manager.dart';
import 'package:provider/provider.dart';
import 'components/section_staggered.dart';

class Home1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 138, 43, 226);
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              color:  primaryColor,
              /* gradient: LinearGradient(
                    colors: const [
                      Color.fromARGB(255, 70, 0, 100),
                      Color.fromARGB(255, 130, 20, 160),
                      Color.fromARGB(255, 150, 43, 226),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )*/
            ),

          ),
          CustomScrollView(

            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Camisetas'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              )
              ,
              Consumer<HomeManager>(
                builder: (_, homeManager, __){
                  final List<Widget> children = homeManager.sections.map<Widget>(
                          (section) {

                        switch(section.type){
                          case 'Staggered':
                            return SectionStaggered(section);
                          default:
                            return Container();
                        }
                      }
                  ).toList();

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