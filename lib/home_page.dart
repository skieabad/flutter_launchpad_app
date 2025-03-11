import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launchpad_app/model/launchpad_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final audioPlayer = AudioPlayer();
  final Map<Color, Color> columnColors = {
    const Color(0xffADCBFC): const Color(0xff067CCB),
    const Color(0xffff2525): const Color(0xffc40050),
    const Color(0xFFC0FFCF): const Color(0xFF00AA25),
    const Color(0xffE247FC): const Color(0xffa23ab7),
  };

  int selectedTileIndex = -1;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        selectedTileIndex = -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Launchpad',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            final columnIndex = index % 4;
            final centerColor = columnColors.keys.toList()[columnIndex];
            final outlineColor = columnColors[centerColor];

            var audioPath = launchPadList[index];

            return InkWell(
              highlightColor: Colors.black,
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              onTap: () {
                setState(() {
                  if (selectedTileIndex == index) {
                    // Same tile is tapped again, deselect it
                    selectedTileIndex = -1;
                  } else {
                    // Different tile is tapped, select it
                    selectedTileIndex = index;
                    log('Selected tile index: $selectedTileIndex');
                  }
                });

                audioPlayer.play(AssetSource(audioPath.audioPath ?? ''));
              },
              child: Card(
                margin: const EdgeInsets.all(2.0),
                elevation: 0.0,
                color: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: selectedTileIndex == index
                          ? [Colors.white, Colors.white]
                          : [centerColor, outlineColor ?? Colors.black],
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: 28,
        ),
      ),
    );
  }
}
