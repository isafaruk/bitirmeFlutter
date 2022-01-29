import 'package:flutter/material.dart';

class NewApartPage extends StatefulWidget {
  const NewApartPage({Key? key}) : super(key: key);

  @override
  _NewApartPageState createState() => _NewApartPageState();
}

class _NewApartPageState extends State<NewApartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("yeni apart"),
      ),
      body: Center(
        child: Text("yeni apart"),
      ),
    );
  }
}
