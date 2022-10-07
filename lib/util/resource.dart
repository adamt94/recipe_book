import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class Resource<T> {
  final String url;
  T Function(Response response)? parse;

  Resource({required this.url, this.parse});
}

class Webservice {
  Future<T> load<T>(Resource<T> resource) async {
    final response = await http.get(Uri.parse(resource.url));
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data! ${response.statusCode}');
    }
  }

  void put<T>(String url, Map<String, dynamic> body) async {
    http.put(
      Uri.parse(url),
      body: json.encode(body),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  static getSignurl(String? filename) async {
    final response = await http.get(Uri.parse(
        "https://0ly1f57a8l.execute-api.eu-west-2.amazonaws.com/uploads?${filename?.replaceAll(' ', '')}"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['uploadURL'];
    } else {
      throw Exception('Failed to load data! ${response.statusCode}');
    }
  }

  static upload(Uint8List imageFile, String imageName, String url) async {
    // open a bytestream
    var stream = http.ByteStream.fromBytes(imageFile);

    // get file length
    var length = await imageFile.length;

    // string to uri
    var uri = Uri.parse(url);

    var response = await http.put(
      uri,
      headers: {
        // insert correct credentials here
        'Content-Type': 'image/jpeg',
      },
      body: imageFile,
    );
  }
}
