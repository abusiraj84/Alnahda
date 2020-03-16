import 'package:flutter/material.dart';

class ContactUsView extends StatefulWidget {
  ContactUsView({Key key}) : super(key: key);

  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSubject = TextEditingController();
  TextEditingController _controllerContent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تواصل معنا",
        ),
      ),
      backgroundColor: Color(0xffeef4f8),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _controllerName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "الاسم",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "البريد الإلكتروني",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controllerSubject,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "الموضوع",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: TextField(
                    maxLines :6,
                    controller: _controllerContent,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "نص الرسالة",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('ارسال رسالة'),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
