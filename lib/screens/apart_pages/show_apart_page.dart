import 'package:bitirme5/models/apart.dart';
import 'package:bitirme5/models/users.dart';
import 'package:bitirme5/screens/apart_pages/apart_details_page.dart';
import 'package:bitirme5/screens/apart_pages/new_apart_page.dart';
import 'package:bitirme5/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowApartPage extends StatefulWidget {
  final Users users;
  ShowApartPage({Key? key, required this.users}) : super(key: key);

  @override
  _ShowApartPageState createState() => _ShowApartPageState();
}

class _ShowApartPageState extends State<ShowApartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apartlar"),
      ),
      body: StreamBuilder<List<Apart>>(
          stream: DatabaseService().aparts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var aparts = snapshot.data!;
              return ListView.builder(
                  itemCount: aparts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.cyan[50],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Text(
                          aparts[index].apartName!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          aparts[index].apartDesc!,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ApartDetailPage(apart: aparts[index]),)
                          );
                        },
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: Visibility(
        visible: widget.users.isAdmin == true ? true : false,
        child: FloatingActionButton(
          tooltip: "Yeni Apart",
          onPressed: () {
            Navigator.push((context),
                MaterialPageRoute(builder: (context) => NewApartPage()));
          },
          child: Icon(Icons.note_add),
        ),
      ),
    );
  }
}
