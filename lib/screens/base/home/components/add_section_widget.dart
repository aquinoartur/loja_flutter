import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/home_manager.dart';
import 'package:lojinha_virtual/models/section.dart';

class AddSectionWidget extends StatelessWidget {

  const AddSectionWidget(this.homeManager);

  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'List'));
            },
            textColor: primaryColor,
            color: Colors.white,
            child: const Text('Add Lista'),
          ),
        ),
        Container(
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'Staggered'));
            },
            textColor: primaryColor,
            color: Colors.white,
            child: const Text('Add Grade'),
          ),
        ),
        Container(
          // ignore: deprecated_member_use
          child: RaisedButton(
            textColor: primaryColor,
            color: Colors.white,
            onPressed: (){
              homeManager.addSection(Section(type: 'Oval'));
            },
            child: const Text('Add Círculo'),
          ),
        ),
      ],
    );
  }
}