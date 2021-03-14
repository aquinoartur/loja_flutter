import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/product.dart';
import 'package:lojinha_virtual/models/product_manager.dart';
import 'package:provider/provider.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {

  EditProductScreen(Product p) :
        editing = p != null,
        product = p != null ? p.clone() : Product();

  final Product product;
  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
          centerTitle: true,
          actions: <Widget>[
            if(editing)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  context.read<ProductManager>().delete(product);
                  Navigator.of(context).pop();
                },
              )
          ],
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ImagesForm(product),
             Padding(
                 padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   TextFormField(
                       initialValue: product.name,
                       decoration: const InputDecoration(
                           hintText: 'Título',
                           border: InputBorder.none
                       ),
                       style: TextStyle(
                           fontSize: 24,
                           fontWeight: FontWeight.w600,
                           color: Colors.black
                       ),
                     validator: (name){
                       if(name.length < 5)
                         return 'Título muito curto';
                       return null;
                     },
                     onSaved: (name) => product.name = name,
                   ),
                   Divider(
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top:12, bottom: 3),
                     child: Text('A partir de:', style: TextStyle(color: Colors.grey[700], fontSize: 16),),
                   ),
                   Text('R\$ ...',style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),),
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
                   TextFormField(
                     initialValue: product.description,
                     style: const TextStyle(
                         fontSize: 16
                     ),
                     decoration: const InputDecoration(
                         hintText: 'Descrição',
                         border: InputBorder.none
                     ),
                     maxLines: null,
                     validator: (desc){
                       if(desc.length < 6)
                         return 'Descrição muito curta';
                       return null;
                     },
                     onSaved: (desc) => product.description = desc,
                   ),
                   Divider(
                   ),
                   SizesForm(product),
                   Divider(
                   ),
                   const SizedBox(height: 20,),
                   Consumer<Product>(
                     builder: (_,product,__){
                       return SizedBox(
                         height: 44,
                         child: RaisedButton(
                           onPressed: !product.loading ? () async {
                             if(formKey.currentState.validate()){
                               formKey.currentState.save();
                               await product.save();

                               context.read<ProductManager>()
                                   .update(product);

                               Navigator.of(context).pop();
                             }
                           } : null,
                           textColor: Colors.white,
                           color: primaryColor,
                           disabledColor: primaryColor.withAlpha(100),
                           child: product.loading
                               ?  CircularProgressIndicator(
                             valueColor: AlwaysStoppedAnimation(Colors.white),
                           ) :
                           const Text(
                             'Salvar',
                             style: TextStyle(fontSize: 18.0),
                           ),
                         ),
                       );
                     }
                   )
                 ],
               ),

             )
            ],
          ),
        ),
      ),
    );
  }
}