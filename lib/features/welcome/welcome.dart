import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tashli/features/video/video_screen.dart';
import 'package:tashli/features/welcome/widgets/main_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> categoryVideo = [
    "FACE_MASSAGE",
    "FACIAL_CLEANING",
    "ADDITIONAL_FACIAL_PROCEDURES",
    "SPA_HAIR",
    "ADDITIONAL_HAIR_PROCEDURES",
    "DIAGNOSTICS",
    "REJUVENATION_MASSAGE",
    "BODY_MASSAGE",
    "MANICURE"
  ];
  List<int> videoCount = [4, 2, 3, 1, 4, 1, 2, 2, 2];
  List<List<String>> procedures = [];
  List<List<String>> procedureCosts = [];

  @override
  Widget build(BuildContext context) {
    String categoriesJson = AppLocalizations.of(context)!.categories;
    List<String> categories = List<String>.from(json.decode(categoriesJson));
    print(categories);

    String jsontextprocedur = AppLocalizations.of(context)!.procedures;
    procedures = List<List<String>>.from(
        json.decode(jsontextprocedur).map((list) => List<String>.from(list)));
    print(procedures);

    String jsontextcost = AppLocalizations.of(context)!.procedureCosts;
    procedureCosts = List<List<String>>.from(
        json.decode(jsontextcost).map((list) => List<String>.from(list)));
    print(procedureCosts);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(context),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/images/background.jpg',
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3.5 + 80),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                color: Color(0xFFF7DED0),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        AppLocalizations.of(context)!.salonName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Color(0xFF944E63),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoScreen(
                                          videoFolder: categoryVideo[index],
                                          videoCount: videoCount[index],
                                          pocedures: procedures[index],
                                          pocedureCosts: procedureCosts[index],
                                        )));
                          },
                          child: SizedBox(
                            height: 50,
                            child: Card(
                              color: const Color(0xFFF9B38D),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2,
                        crossAxisCount: 2,
                      ),
                    ),
                  ),
                ],
              ),
              // ListView.builder(
              //   itemBuilder: (context, index) {
              //     return Card();
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
