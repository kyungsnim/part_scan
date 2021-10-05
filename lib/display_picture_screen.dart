import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class DisplayCaptureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayCaptureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _DisplayCaptureScreenState createState() => _DisplayCaptureScreenState();
}

class _DisplayCaptureScreenState extends State<DisplayCaptureScreen> {
  ScreenshotController _screenshotController = ScreenshotController();
  late Uint8List _imageFile;

  @override
  void initState() {
    saveCurrentScreen();
    super.initState();
  }

  saveCurrentScreen() async {
    await _screenshotController
        .capture(delay: const Duration(milliseconds: 1000))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        // final directory = Directory('/storage/emulated/0/DCIM');
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: widget.imagePath != ''
          ? Screenshot(
              controller: _screenshotController,
              child: Stack(
                children: [
                  Image.file(File(widget.imagePath)),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Text(
                        '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                        style: const TextStyle(
                            shadows: [
                              Shadow(
                                  color: Colors.black87,
                                  offset: Offset(1, 1),
                                  blurRadius: 4)
                            ],
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.yellow)),
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
