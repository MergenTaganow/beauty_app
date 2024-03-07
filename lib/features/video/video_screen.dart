import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tashli/features/video/widgets/video_player.dart';
import 'package:tashli/features/welcome/widgets/main_app_bar.dart';

class VideoScreen extends StatefulWidget {
  final String videoFolder;
  final int videoCount;
  final List<String> pocedures;
  final List<String> pocedureCosts;
  const VideoScreen(
      {Key? key,
      required this.videoFolder,
      required this.videoCount,
      required this.pocedures,
      required this.pocedureCosts})
      : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<String> videoPaths = [];

  @override
  void initState() {
    videoPaths = List<String>.generate(widget.videoCount,
        (index) => 'assets/videos/${widget.videoFolder}/${index + 1}.MOV');
    // print(videoPaths);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mainAppBar(context, true),
        body: Stack(
          alignment: orientation == Orientation.portrait
              ? Alignment.topCenter
              : Alignment.centerLeft,
          children: [
            Image.asset(
              'assets/images/fon.jpg',
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: videoPaths.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 100.0),
                            child: SizedBox(
                              height: 300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (index % 2 != 0)
                                    procedureName(
                                        text: widget.pocedures[index],
                                        cost: widget.pocedureCosts[index]),
                                  Padding(
                                    padding: index % 2 == 0
                                        ? const EdgeInsets.only(left: 40.0)
                                        : const EdgeInsets.only(right: 40),
                                    child: VideoListItem(
                                        videoUrl: videoPaths[index]),
                                  ),
                                  if (index % 2 == 0)
                                    procedureName(
                                        text: widget.pocedures[index],
                                        cost: widget.pocedureCosts[index]),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Expanded procedureName({required String text, required String cost}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Renk.textColor,
            ),
          ),
          Text(
            cost,
            style: const TextStyle(fontSize: 22, color: Colors.orangeAccent),
          )
        ],
      ),
    );
  }
}
