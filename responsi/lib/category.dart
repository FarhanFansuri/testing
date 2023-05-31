import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/get_api.dart';

import 'list_makanan.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Widget> CatCard = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Meal Category"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: GetApi().getHttp(
              'https://www.themealdb.com/api/json/v1/1/categories.php'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("waiting");
            } else if (snapshot.connectionState == ConnectionState.done) {
              // ignore: avoid_print
              String data = jsonEncode(snapshot.data!);
              var hasil = jsonDecode(data);

              for (var index = 0; index < hasil['categories'].length; index++) {
                CatCard.add(Container(
                  margin: const EdgeInsets.all(10.0),
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ListMakanan(
                                value: hasil['categories'][index]
                                    ['strCategory'])));
                      },
                      child: Card(
                        child: SizedBox(
                          width: 300,
                          height: 100,
                          child: Row(
                            children: [
                              Image(
                                  image: NetworkImage(hasil['categories'][index]
                                      ['strCategoryThumb'])),
                              Text(hasil['categories'][index]['strCategory'])
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
