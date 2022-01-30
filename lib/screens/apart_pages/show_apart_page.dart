import 'package:flutter/material.dart';

class ShowApartPage extends StatefulWidget {
  const ShowApartPage({Key? key}) : super(key: key);

  @override
  _ShowApartPageState createState() => _ShowApartPageState();
}

class _ShowApartPageState extends State<ShowApartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("apart gösterme"),
      ),
      body: Center(
        child: Text("apart gösterme"),
      ),
    );
  }
}
