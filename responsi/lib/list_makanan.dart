import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/detail_makanan.dart';
import 'package:responsi/get_api.dart';

class ListMakanan extends StatefulWidget {
  dynamic value;
  ListMakanan({super.key, required this.value});

  @override
  State<ListMakanan> createState() => _ListMakananState(value: this.value);
}

class _ListMakananState extends State<ListMakanan> {
  dynamic value;
  _ListMakananState({required this.value});
  List<Widget> CatCard = [];
  @override
  Widget build(BuildContext context) {
    print(value);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Dessert Meal"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: GetApi().getHttp(
              'https://www.themealdb.com/api/json/v1/1/filter.php?c=$value'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("waiting");
            } else if (snapshot.connectionState == ConnectionState.done) {
              // ignore: avoid_print
              String data = jsonEncode(snapshot.data!);
              var hasil = jsonDecode(data);

              for (var index = 0; index < hasil['meals'].length; index++) {
                CatCard.add(Container(
                  margin: const EdgeInsets.all(10.0),
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailMakanan(
                                value: hasil['meals'][index]['idMeal'])));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              Image(
                                  image: NetworkImage(
                                      hasil['meals'][index]['strMealThumb'])),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                hasil['meals'][index]['strMeal'],
                                softWrap: false,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      )),
                ));
              }
              return ListView(
                children: CatCard,
              );
            } else {
              return const Text("Error");
            }
          }),
    );
  }
}
