import 'package:flutter/material.dart';
import 'package:lojinha_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';
class DrawerTile extends StatelessWidget {
  DrawerTile({this.iconData, this.title, this.page});
  final IconData iconData;
  final String title;
  final int page;
  @override
  Widget build(BuildContext context) {

    final int curPage = context.watch<PageManager>().page; //monitorando o valor da página
    final Color primaryColor = const Color.fromARGB(255, 138, 43, 226);
    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);

      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: curPage == page ? primaryColor : Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }
}
