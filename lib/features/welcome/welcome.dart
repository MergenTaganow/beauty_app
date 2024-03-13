import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tashli/features/video/video_screen.dart';
import 'package:tashli/features/welcome/manicure_page.dart';
import 'package:tashli/features/welcome/widgets/main_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> categoryVideo = [
    "FACE_MASSAGE",
    "CLEANING",
    "DIAGNOSTICS",
    "ADDITIONAL_FACIAL_PROCEDURES",
    "BODY_MASSAGE",
    "SPA_HAIR",
    "MANICURE"
  ];
  List<int> videoCount = [6, 9, 1, 11, 5, 7];
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

    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mainAppBar(context),
        body: Stack(
          alignment: orientation == Orientation.portrait
              ? Alignment.topCenter
              : Alignment.centerLeft,
          children: [
            Image.asset(
              'assets/images/fon.jpg',
              fit: orientation == Orientation.portrait
                  ? BoxFit.cover
                  : BoxFit.fill,
              width: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width / 3.5 + 130,
              height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height / 3.5 + 120
                  : MediaQuery.of(context).size.height,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height / 3.5 + 75
                    : 0,
                left: orientation == Orientation.portrait
                    ? 0
                    : MediaQuery.of(context).size.width / 3.5 + 130,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: orientation == Orientation.portrait
                    ? BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                        color: Renk.backColor,
                      )
                    : BoxDecoration(
                        color: Renk.backColor,
                      ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/images/logo.png',
                        //   width: 50,
                        //   height: 50,
                        // ),
                        Text(
                          AppLocalizations.of(context)!.salonName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              color: Renk.textColor,
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
                              if (index != categories.length - 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoScreen(
                                              videoFolder: categoryVideo[index],
                                              videoCount: videoCount[index],
                                              pocedures: procedures[index],
                                              pocedureCosts:
                                                  procedureCosts[index],
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManicureScreen()));
                              }
                            },
                            child: SizedBox(
                              height: 50,
                              child: Card(
                                color: Renk.cardColor,
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Renk.textColor),
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
    });
  }
}
