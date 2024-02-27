import 'package:flutter/material.dart';
import 'package:tashli/my_app.dart';

AppBar mainAppBar(BuildContext context, [bool withPop = false]) {
  Locale _locale = MyApp.currentLocale(context) ?? const Locale('en');
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: withPop
        ? Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 35,
                )),
          )
        : null,
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 15.0, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    MyApp.setLocale(context, const Locale('ru'));
                  },
                  child: const Text(
                    'Ru',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      MyApp.setLocale(context, const Locale('en'));
                    },
                    child: const Text(
                      'En',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              margin: _locale == const Locale('en')
                  ? const EdgeInsets.only(left: 42)
                  : EdgeInsets.zero,
              height: 3,
              width: 23,
              color: const Color(0xFFF33F3F),
              duration: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    ],
  );
}
