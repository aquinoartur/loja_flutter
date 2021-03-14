import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/home_manager.dart';
import 'package:lojinha_virtual/models/section.dart';
import 'package:lojinha_virtual/screens/base/home/components/section_header.dart';
import 'package:provider/provider.dart';
import 'add_tile_widget.dart';
import 'item_tile_oval.dart';
import 'package:lojinha_virtual/models/product.dart';

class ProductPrice extends StatelessWidget {


  const ProductPrice(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Text(product.name),
    );
  }

}


class SectionListOval extends StatelessWidget {

  const SectionListOval(this.section);

  final Section section;



  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return ChangeNotifierProvider.value(
      value: section,
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionHeader(),
              SizedBox(
                height: 115,
                child: Consumer<Section>(
                  builder: (_, section, __){
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index){
                        if(index < section.items.length)
                          return ItemTileOval(section.items[index]);
                        else
                          return AddTileWidget();
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 4,),
                      itemCount: homeManager.editing
                          ? section.items.length + 1
                          : section.items.length,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}