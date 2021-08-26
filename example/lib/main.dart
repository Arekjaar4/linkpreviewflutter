import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:link_preview_flutter/link_preview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _linkPreview1 = Container();
  Widget _linkPreview2 = Container();
  Widget _linkPreview3 = Container();
  Widget _linkPreview4 = Container();
  Widget _linkPreview5 = Container();
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Widget linkPreview1;
    Widget linkPreview2;
    Widget linkPreview3;
    Widget linkPreview4;
    Widget linkPreview5;
    try {
      linkPreview1 = await LinkPreviewFlutter.create(
        "https://medium.com/todo-sobre-flutter/flutter-sliverappbar-sliverlist-slivergrid-y-sliveranimatedlist-595b205c1abe",
      );
      linkPreview2 = await LinkPreviewFlutter.create(
          "https://freecons.herokuapp.com/",
          type: 'rectangle-image-right',
          size: 200,
          background: Colors.black,
          fontColor: Colors.white);
      linkPreview3 = await LinkPreviewFlutter.create(
          "https://www.npmjs.com/package/@arekjaar/link-preview",
          type: 'square-image-up',
          size: 200,
          background: Colors.black,
          fontColor: Colors.white);
      linkPreview4 = await LinkPreviewFlutter.create(
          "https://www.buymeacoffee.com/martinmul",
          type: 'square-image-center',
          background: Colors.black,
          fontColor: Colors.white);
      linkPreview5 = await LinkPreviewFlutter.create(
          "https://medium.com/todo-sobre-flutter/flutter-sliverappbar-sliverlist-slivergrid-y-sliveranimatedlist-595b205c1abe",
          type: 'square-image-down',
          size: 400,
          background: Colors.black,
          fontColor: Colors.white);
    } on HttpException {
      linkPreview1 = Container();
      linkPreview2 = Container();
      linkPreview3 = Container();
      linkPreview4 = Container();
      linkPreview5 = Container();
    }

    if (!mounted) return;

    setState(() {
      _linkPreview1 = linkPreview1;
      _linkPreview2 = linkPreview2;
      _linkPreview3 = linkPreview3;
      _linkPreview4 = linkPreview4;
      _linkPreview5 = linkPreview5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Link',
                ),
              ),
              TextButton(
                  onPressed: () {
                    LinkPreviewFlutter.create(myController.text,
                            size: 400,
                            background: Colors.black,
                            fontColor: Colors.white)
                        .then((value) => setState(() {
                              _linkPreview1 = value;
                            }));
                  },
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Set link',
                        style: TextStyle(color: Colors.white),
                      )),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green))),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SafeArea(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: _linkPreview1,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: _linkPreview2,
                              ),
                            ],
                          ))),
                  SafeArea(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: _linkPreview3,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: _linkPreview4,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: _linkPreview5,
                              ),
                            ],
                          ))))
                ],
              )))
            ],
          ))),
    );
  }
}
