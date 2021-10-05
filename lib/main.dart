import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:part_scan/take_picture_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = '바코드를 스캔해주세요';
  var firstCamera;

  @override
  void initState() {
    super.initState();
    getCamera();
  }

  getCamera() async {
    // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
    final cameras = await availableCameras();

    // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
    firstCamera = cameras.first;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              color: Colors.yellow,
                              child: Text(
                                'Scan result : $_scanBarcode\n',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  onPressed: () => scanBarcodeNormal(),
                                  child: const Text('바코드 스캔')),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () => Get.to(
                                () => TakePictureScreen(camera: firstCamera)),
                            child: const Text('사진 촬영'))
                      ]));
            })));
  }
}
