import 'package:bitirme5/models/apart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApartDetailPage extends StatefulWidget {
  final Apart apart;
  const ApartDetailPage({Key? key, required this.apart}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApartDetailPageState();
}

class _ApartDetailPageState extends State<ApartDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apart Detay")),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    height: 250.0,
                    child: Center(
                      child: Center(
                        child: Image.network(widget.apart.imageUrl!),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Center(
                    child: Text(
                      widget.apart.apartName!,
                      style: TextStyle(fontSize: 30.0, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),

                    child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          widget.apart.isSecure != false
                          ? Text("Güvenlik var." , style: TextStyle(fontSize: 16.0, color: Colors.black))
                          : Text("Güvenlik yok.", style: TextStyle(fontSize: 16.0, color: Colors.black)),
                          SizedBox(
                            width: 8.0,
                          ),
                          widget.apart.isCamera != false
                              ? Text("Kamera Sistemi var." , style: TextStyle(fontSize: 16.0, color: Colors.black))
                              : Text("Kamera Sistemi  yok.", style: TextStyle(fontSize: 16.0, color: Colors.black)),
                          SizedBox(
                            width: 8.0,
                          ),
                          widget.apart.haveBalcony != false
                              ? Text("Balkonlu oda var." , style: TextStyle(fontSize: 16.0, color: Colors.black))
                              : Text("Balkonlu oda yok.", style: TextStyle(fontSize: 16.0, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 12.0,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    )
                  ],
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Açıklama",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26.0, color: Colors.black),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        widget.apart.apartDesc!,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("İletişim için : " +
                        widget.apart.apartContact!,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
