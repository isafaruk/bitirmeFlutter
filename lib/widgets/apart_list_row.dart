import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApartListRow extends StatelessWidget {
  String name;
  int price;
  String imageUrl;

  ApartListRow(
      {required this.name, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildApartItemCard(context),
        _buildApartItemCard(context),
      ],
    );
  }

  _buildApartItemCard(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(this.imageUrl),
              height: 250.0,
              width: MediaQuery.of(context).size.width / 2.2,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                children: <Widget>[
                  Text(this.name,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Fiyat"),
                      SizedBox(
                        width: 8.0,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
