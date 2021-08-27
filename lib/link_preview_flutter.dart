library link_preview_flutter;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:link_preview_flutter/environment.dart';

///Main package class
class LinkPreviewFlutter {
  ///Component background color
  static Color _background = Colors.white;
  ///Component font color
  static Color _fontColor = Colors.black;
  ///Default component background color
  static Color _defaultBackground = Colors.white;
  ///Default component font color
  static Color _defaultFontColor = Colors.black;
  ///Default component type
  static String _type = 'rectangle-image-left';
  ///Default component size
  static double _size = 300;
  ///Init component height
  static double _height = 0;
  ///Init component width
  static double _width = 0;
  ///Init component image height
  static double _heightImg = 0;
  ///Init component image width
  static double _widthImg = 0;
  ///Init component font size h2
  static double _fontSizeH2 = 0;
  ///Init component font size h3
  static double _fontSizeH3 = 0;
  ///Init component font size h4
  static double _fontSizeH4 = 0;
  ///Init component font size h5
  static double _fontSizeH5 = 0;
  ///Init component row width
  static double _widthRow = 0;
  ///Create component channel
  static const MethodChannel _channel = const MethodChannel('link_preview');

  ///Create component method
  static Future<Widget> create(String url,
      {String type, double size, Color background, Color fontColor}) async {
    LinkPreviewFlutter._setParams(type, size, background, fontColor);
    final response = await http.get(
      Uri.parse(Environment.API_URL + url),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': Environment.API_TOKEN,
      },
    );
    final responseJson = jsonDecode(response.body);
    OpengraphInterface op = OpengraphInterface.fromJson(responseJson);
    switch (type) {
      case 'rectangle-image-left':
        return LinkPreviewFlutter.rectangleImageLeft(op);
      case 'rectangle-image-right':
        return LinkPreviewFlutter.rectangleImageRight(op);
      case 'square-image-center':
        return LinkPreviewFlutter.squareImageCenter(op);
      case 'square-image-down':
        return LinkPreviewFlutter.squareImageDown(op);
      case 'square-image-up':
        return LinkPreviewFlutter.squareImageUp(op);
      default:
        return LinkPreviewFlutter.rectangleImageLeft(op);
    }
  }
  ///Config rectangle-image-left type
  static Future<Widget> rectangleImageLeft(OpengraphInterface op) async {
    return Container(
      width: LinkPreviewFlutter._width,
      height: LinkPreviewFlutter._height,
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: LinkPreviewFlutter._background),
      child: Row(
        children: [
          Image.network(op.image,
              width: LinkPreviewFlutter._widthImg,
              height: LinkPreviewFlutter._heightImg,
              fit: BoxFit.cover),
          Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Container(
                width: LinkPreviewFlutter._widthRow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LinkPreviewFlutter._cutText(
                          op.site_name,
                          LinkPreviewFlutter._fontSizeH2,
                          LinkPreviewFlutter._widthRow,
                          2),
                      style: TextStyle(
                          fontSize: LinkPreviewFlutter._fontSizeH2,
                          fontWeight: FontWeight.bold,
                          color: LinkPreviewFlutter._fontColor),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LinkPreviewFlutter._cutText(
                                op.title,
                                LinkPreviewFlutter._fontSizeH3,
                                LinkPreviewFlutter._widthRow,
                                2),
                            style: TextStyle(
                                fontSize: LinkPreviewFlutter._fontSizeH3,
                                color: LinkPreviewFlutter._fontColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                              LinkPreviewFlutter._cutText(
                                  LinkPreviewFlutter._cutUrl(op.url),
                                  LinkPreviewFlutter._fontSizeH5,
                                  LinkPreviewFlutter._widthRow,
                                  2),
                              style: TextStyle(
                                  fontSize: LinkPreviewFlutter._fontSizeH5,
                                  color: Colors.lightBlue)),
                        ],
                      ),
                    ),
                    Text(
                      LinkPreviewFlutter._cutText(
                          op.description,
                          LinkPreviewFlutter._fontSizeH4,
                          LinkPreviewFlutter._widthRow,
                          4),
                      style: TextStyle(
                          fontSize: LinkPreviewFlutter._fontSizeH4,
                          fontFamily: 'Roboto',
                          color: LinkPreviewFlutter._fontColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
  ///Config rectangle-image-right type
  static Future<Widget> rectangleImageRight(OpengraphInterface op) async {
    return Container(
      width: LinkPreviewFlutter._width,
      height: LinkPreviewFlutter._height,
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: LinkPreviewFlutter._background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Container(
                width: LinkPreviewFlutter._widthRow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LinkPreviewFlutter._cutText(
                          op.site_name,
                          LinkPreviewFlutter._fontSizeH2,
                          LinkPreviewFlutter._widthRow,
                          2),
                      style: TextStyle(
                          fontSize: LinkPreviewFlutter._fontSizeH2,
                          fontWeight: FontWeight.bold,
                          color: LinkPreviewFlutter._fontColor),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LinkPreviewFlutter._cutText(
                                op.title,
                                LinkPreviewFlutter._fontSizeH3,
                                LinkPreviewFlutter._widthRow,
                                2),
                            style: TextStyle(
                                fontSize: LinkPreviewFlutter._fontSizeH3,
                                color: LinkPreviewFlutter._fontColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                              LinkPreviewFlutter._cutText(
                                  LinkPreviewFlutter._cutUrl(op.url),
                                  LinkPreviewFlutter._fontSizeH5,
                                  LinkPreviewFlutter._widthRow,
                                  2),
                              style: TextStyle(
                                  fontSize: LinkPreviewFlutter._fontSizeH5,
                                  color: Colors.lightBlue)),
                        ],
                      ),
                    ),
                    Text(
                      LinkPreviewFlutter._cutText(
                          op.description,
                          LinkPreviewFlutter._fontSizeH4,
                          LinkPreviewFlutter._widthRow,
                          4),
                      style: TextStyle(
                          fontSize: LinkPreviewFlutter._fontSizeH4,
                          fontFamily: 'Roboto',
                          color: LinkPreviewFlutter._fontColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )),
          Image.network(op.image,
              width: LinkPreviewFlutter._widthImg,
              height: LinkPreviewFlutter._heightImg,
              fit: BoxFit.cover),
        ],
      ),
    );
  }
  ///Config square-image-up type
  static Future<Widget> squareImageUp(OpengraphInterface op) async {
    return Container(
      width: LinkPreviewFlutter._width,
      height: LinkPreviewFlutter._height,
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: LinkPreviewFlutter._background),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(op.image,
              width: LinkPreviewFlutter._widthImg, fit: BoxFit.fill),
          Text(
            LinkPreviewFlutter._cutText(
                op.site_name,
                LinkPreviewFlutter._fontSizeH2,
                LinkPreviewFlutter._widthRow,
                2),
            style: TextStyle(
                fontSize: LinkPreviewFlutter._fontSizeH2,
                fontWeight: FontWeight.bold,
                color: LinkPreviewFlutter._fontColor),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LinkPreviewFlutter._cutText(
                      op.title,
                      LinkPreviewFlutter._fontSizeH3,
                      LinkPreviewFlutter._widthRow,
                      2),
                  style: TextStyle(
                      fontSize: LinkPreviewFlutter._fontSizeH3,
                      color: LinkPreviewFlutter._fontColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    LinkPreviewFlutter._cutText(
                        LinkPreviewFlutter._cutUrl(op.url),
                        LinkPreviewFlutter._fontSizeH5,
                        LinkPreviewFlutter._widthRow,
                        2),
                    style: TextStyle(
                        fontSize: LinkPreviewFlutter._fontSizeH5,
                        color: Colors.lightBlue)),
              ],
            ),
          ),
          Text(
            LinkPreviewFlutter._cutText(
                op.description,
                LinkPreviewFlutter._fontSizeH4,
                LinkPreviewFlutter._widthRow,
                4),
            style: TextStyle(
                fontSize: LinkPreviewFlutter._fontSizeH4,
                fontFamily: 'Roboto',
                color: LinkPreviewFlutter._fontColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  ///Config square-image-center type
  static Future<Widget> squareImageCenter(OpengraphInterface op) async {
    return Container(
      width: LinkPreviewFlutter._width,
      height: LinkPreviewFlutter._height,
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: LinkPreviewFlutter._background),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LinkPreviewFlutter._cutText(
                op.site_name,
                LinkPreviewFlutter._fontSizeH2,
                LinkPreviewFlutter._widthRow,
                2),
            style: TextStyle(
                fontSize: LinkPreviewFlutter._fontSizeH2,
                fontWeight: FontWeight.bold,
                color: LinkPreviewFlutter._fontColor),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LinkPreviewFlutter._cutText(
                      op.title,
                      LinkPreviewFlutter._fontSizeH3,
                      LinkPreviewFlutter._widthRow,
                      2),
                  style: TextStyle(
                      fontSize: LinkPreviewFlutter._fontSizeH3,
                      color: LinkPreviewFlutter._fontColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    LinkPreviewFlutter._cutText(
                        LinkPreviewFlutter._cutUrl(op.url),
                        LinkPreviewFlutter._fontSizeH5,
                        LinkPreviewFlutter._widthRow,
                        2),
                    style: TextStyle(
                        fontSize: LinkPreviewFlutter._fontSizeH5,
                        color: Colors.lightBlue)),
              ],
            ),
          ),
          Image.network(op.image,
              width: LinkPreviewFlutter._widthImg, fit: BoxFit.fill),
          Text(
            LinkPreviewFlutter._cutText(
                op.description,
                LinkPreviewFlutter._fontSizeH4,
                LinkPreviewFlutter._widthRow,
                4),
            style: TextStyle(
                fontSize: LinkPreviewFlutter._fontSizeH4,
                fontFamily: 'Roboto',
                color: LinkPreviewFlutter._fontColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  ///Config square-image-down type
  static Future<Widget> squareImageDown(OpengraphInterface op) async {
    return Container(
      width: LinkPreviewFlutter._width,
      height: LinkPreviewFlutter._height,
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: LinkPreviewFlutter._background),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LinkPreviewFlutter._cutText(
                op.site_name,
                LinkPreviewFlutter._fontSizeH2,
                LinkPreviewFlutter._widthRow,
                2),
            style: TextStyle(
                fontSize: LinkPreviewFlutter._fontSizeH2,
                fontWeight: FontWeight.bold,
                color: LinkPreviewFlutter._fontColor),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LinkPreviewFlutter._cutText(
                      op.title,
                      LinkPreviewFlutter._fontSizeH3,
                      LinkPreviewFlutter._widthRow,
                      2),
                  style: TextStyle(
                      fontSize: LinkPreviewFlutter._fontSizeH3,
                      color: LinkPreviewFlutter._fontColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    LinkPreviewFlutter._cutText(
                        LinkPreviewFlutter._cutUrl(op.url),
                        LinkPreviewFlutter._fontSizeH5,
                        LinkPreviewFlutter._widthRow,
                        2),
                    style: TextStyle(
                        fontSize: LinkPreviewFlutter._fontSizeH5,
                        color: Colors.lightBlue)),
              ],
            ),
          ),
          Text(
            LinkPreviewFlutter._cutText(
                op.description,
                LinkPreviewFlutter._fontSizeH4,
                LinkPreviewFlutter._widthRow,
                4),
            style: TextStyle(
                fontSize: LinkPreviewFlutter._fontSizeH4,
                fontFamily: 'Roboto',
                color: LinkPreviewFlutter._fontColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Image.network(op.image,
              width: LinkPreviewFlutter._widthImg, fit: BoxFit.fill),
        ],
      ),
    );
  }
  ///Setting component params
  static _setParams(
      [String type, double size, Color background, Color fontColor]) {
    type = type != null ? type : LinkPreviewFlutter._type;
    size = size != null ? size : LinkPreviewFlutter._size;
    LinkPreviewFlutter._background =
        background != null ? background : LinkPreviewFlutter._defaultBackground;
    LinkPreviewFlutter._fontColor =
        fontColor != null ? fontColor : LinkPreviewFlutter._defaultFontColor;
    if (type.contains('rectangle')) {
      LinkPreviewFlutter._height = size / 3;
      LinkPreviewFlutter._width = LinkPreviewFlutter._height + size;
      LinkPreviewFlutter._heightImg = LinkPreviewFlutter._height;
      LinkPreviewFlutter._widthImg = LinkPreviewFlutter._height;
      LinkPreviewFlutter._widthRow = size - 10;
      double fontSize = size - LinkPreviewFlutter._widthImg;
      LinkPreviewFlutter._fontSizeH2 = fontSize * 0.1;
      LinkPreviewFlutter._fontSizeH3 = fontSize * 0.08;
      LinkPreviewFlutter._fontSizeH4 = fontSize * 0.06;
      LinkPreviewFlutter._fontSizeH5 = fontSize * 0.04;
    } else {
      LinkPreviewFlutter._width = size;
      LinkPreviewFlutter._height = size * 1.3;
      LinkPreviewFlutter._heightImg = LinkPreviewFlutter._width;
      LinkPreviewFlutter._widthImg = LinkPreviewFlutter._width;
      LinkPreviewFlutter._widthRow = LinkPreviewFlutter._width;
      LinkPreviewFlutter._fontSizeH2 = LinkPreviewFlutter._widthRow * 0.1;
      LinkPreviewFlutter._fontSizeH3 = LinkPreviewFlutter._widthRow * 0.08;
      LinkPreviewFlutter._fontSizeH4 = LinkPreviewFlutter._widthRow * 0.06;
      LinkPreviewFlutter._fontSizeH5 = LinkPreviewFlutter._widthRow * 0.04;
    }
  }
  ///Cut overflow text
  static _cutText(text, double sizeText, double sizeRow, int colums) {
    int length = (sizeRow / sizeText).round() * colums;
    return text.length > length ? text.substring(0, length) + '...' : text;
  }
  ///Cut url
  static _cutUrl(String url) {
    url = url.contains('https')
        ? url.replaceFirst('https://', '')
        : url.replaceFirst('http://', '');
    int index = url.indexOf('/') > 0 ? url.indexOf('/') : url.length;
    url = url.substring(0, index);
    return url;
  }
}

class OpengraphInterface {
  final String title;
  final String description;
  final String image;
  final String url;
  final String site_name;

  OpengraphInterface(
      {this.title, this.description, this.image, this.url, this.site_name});

  factory OpengraphInterface.fromJson(Map<String, dynamic> json) {
    return OpengraphInterface(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      url: json['url'],
      site_name: json['site_name'],
    );
  }
}
