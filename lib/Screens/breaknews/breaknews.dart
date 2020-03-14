import 'package:flutter/material.dart';

import 'break_news_widget.dart';

class BreakNews extends StatelessWidget {
  const BreakNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('عاجل'),
        ),
        body:BreakNewsWidget(),
       
        );
  }
}
