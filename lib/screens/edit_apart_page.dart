import 'package:flutter/material.dart';

class EditApartPage extends StatefulWidget {
  const EditApartPage({Key? key}) : super(key: key);

  @override
  _EditApartPageState createState() => _EditApartPageState();
}

class _EditApartPageState extends State<EditApartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("edit apart"),
      ),
      body: Center(
        child: Text("edit apart"),
      ),
    );
  }
}
