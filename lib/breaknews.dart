import 'package:alnahda/widget/break_news_widget.dart';
import 'package:flutter/material.dart';

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
