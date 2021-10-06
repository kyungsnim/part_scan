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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var _yourTeam;
  final teamList = ['aaaaa', 'bbbbb', 'ccccc', 'ddddd'];

  var image1 = '', image2 = '', image3 = '', image4 = '', image5 = '';

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
      debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text(
                  'Part scan',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Builder(builder: (BuildContext context) {
                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '팀',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: Get.height * 0.07,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton(
                                            hint: const Text('팀 선택',
                                                style: TextStyle(
                                                  fontFamily: 'Binggrae',
                                                  fontSize: 18,
                                                )),
                                            value: _yourTeam,
                                            borderRadius: BorderRadius.circular(10),
                                            icon: const Icon(
                                                Icons.arrow_drop_down_outlined),
                                            underline: Container(
                                              height: 0,
                                            ),
                                            items: teamList.map((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value,
                                                    style: const TextStyle(
                                                      fontFamily: 'Binggrae',
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _yourTeam = value;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.02),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '팀',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: Get.height * 0.07,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton(
                                            hint: const Text('팀 선택',
                                                style: TextStyle(
                                                  fontFamily: 'Binggrae',
                                                  fontSize: 18,
                                                )),
                                            value: _yourTeam,
                                            borderRadius: BorderRadius.circular(10),
                                            icon: const Icon(
                                                Icons.arrow_drop_down_outlined),
                                            underline: Container(
                                              height: 0,
                                            ),
                                            items: teamList.map((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value,
                                                    style: const TextStyle(
                                                      fontFamily: 'Binggrae',
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _yourTeam = value;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.02),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '팀',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: Get.height * 0.07,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton(
                                            hint: const Text('팀 선택',
                                                style: TextStyle(
                                                  fontFamily: 'Binggrae',
                                                  fontSize: 18,
                                                )),
                                            value: _yourTeam,
                                            borderRadius: BorderRadius.circular(10),
                                            icon: const Icon(
                                                Icons.arrow_drop_down_outlined),
                                            underline: Container(
                                              height: 0,
                                            ),
                                            items: teamList.map((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value,
                                                    style: const TextStyle(
                                                      fontFamily: 'Binggrae',
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _yourTeam = value;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.02),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '파트번호',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      width: Get.width * 0.5,
                                      height: Get.height * 0.07,
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _scanBarcode,
                                          style: const TextStyle(fontSize: 18, color: Colors.black87),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: Get.height * 0.07,
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                        onPressed: () => scanBarcodeNormal(),
                                        child: const Text('바코드 스캔')),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.02),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '사진',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  needImageBox(),
                                  needImageBox(),
                                  needImageBox(),
                                  needImageBox(),
                                  needImageBox(),
                                ],
                              )
                              // ElevatedButton(
                              //     onPressed: () => Get.to(() =>
                              //         TakePictureScreen(camera: firstCamera)),
                              //     child: const Text('사진 촬영'))
                            ])),
                  ),
                );
              })),
        ));
  }

  needImageBox() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: Colors.grey.withOpacity(0.6),
        width: Get.width * 0.16,
        height: Get.width * 0.16,
        child: const Icon(Icons.camera_enhance, color: Colors.white,),
      ),
    );
  }
}
