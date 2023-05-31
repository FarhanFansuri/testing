import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi/get_api.dart';

class DetailMakanan extends StatefulWidget {
  dynamic value;
  DetailMakanan({super.key, required this.value});

  @override
  State<DetailMakanan> createState() => _DetailMakananState(value: this.value);
}

class _DetailMakananState extends State<DetailMakanan> {
  dynamic value;
  _DetailMakananState({required this.value});
  List<Widget> CatCard = [];
  @override
  Widget build(BuildContext context) {
    int nilaiid = int.parse(value);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Meal Detail"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: GetApi().getHttp(
              'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$nilaiid'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("waiting");
            } else if (snapshot.connectionState == ConnectionState.done) {
              // ignore: avoid_print
              String data = jsonEncode(snapshot.data!);
              var hasil = jsonDecode(data);
              return Container(
                margin: const EdgeInsets.all(10.0),
                child: ListView(children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(child: Text('${hasil['meals'][0]['strMeal']}')),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: Image(
                    image: NetworkImage(
                      '${hasil['meals'][0]['strMealThumb']}',
                    ),
                    height: 200.0,
                  )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text('Id meal :  ${hasil['meals'][0]['idMeal']}'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text('Tags : ${hasil['meals'][0]['strTags']}'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text('Tags : ${hasil['meals'][0]['strInstructions']}'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _launchUrl(
                            Uri.parse('${hasil['meals'][0]['strYoutube']}'));
                      },
                      child: Text("Youtube"))
                ]),
              );
            } else {
              return const Text("Error");
            }
          }),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
