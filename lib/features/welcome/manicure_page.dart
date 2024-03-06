import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tashli/features/welcome/widgets/main_app_bar.dart';

class ManicureScreen extends StatelessWidget {
  const ManicureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String manicureJson = AppLocalizations.of(context)!.manicure;
    List<String> manicure = List<String>.from(json.decode(manicureJson));
    print(manicure);

    String manicurePriceJson = AppLocalizations.of(context)!.manicurePrice;
    List<String> manicurePrice =
        List<String>.from(json.decode(manicurePriceJson));
    print(manicurePrice);

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: mainAppBar(context, true),
          body: Stack(
            alignment: orientation == Orientation.portrait
                ? Alignment.topCenter
                : Alignment.centerLeft,
            children: [
              Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
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
                      ? MediaQuery.of(context).size.height / 3.5 + 80
                      : 0,
                  left: orientation == Orientation.portrait
                      ? 0
                      : MediaQuery.of(context).size.width / 3.5 + 130,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  decoration: orientation == Orientation.portrait
                      ? const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                          color: Color(0xFFF7DED0),
                        )
                      : const BoxDecoration(
                          color: Color(0xFFF7DED0),
                        ),
                  child: Column(
                    children: [
                      const SizedBox(
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
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 5),
                              child: Card(
                                color: const Color(0xFFF7DED0),
                                child: ListTile(
                                  title: Text(
                                    manicure[index],
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF944E63),
                                    ),
                                  ),
                                  trailing: Text(
                                    manicurePrice[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.orangeAccent),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: manicure.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
