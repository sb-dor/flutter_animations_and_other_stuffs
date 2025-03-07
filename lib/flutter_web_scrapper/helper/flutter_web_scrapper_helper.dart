import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class FlutterWebScrapperHelper {
  static FlutterWebScrapperHelper? _instance;

  static FlutterWebScrapperHelper get instance => _instance ??= FlutterWebScrapperHelper._();

  FlutterWebScrapperHelper._();

  Future<void> getPizzaHouseMainScreenCategoriesName() async {
    final path = Uri.parse(
        'https://pizzahouse.tj/?gclid=CjwKCAiA7t6sBhAiEiwAsaieYlioJYtyXLgQabCYJA_VmgQWlMbmkIbpAtwC0UWNh23c0a7SxCVBFhoCJKcQAvD_BwE');

    final response = await http.get(path);

    dom.Document doc = dom.Document.html(response.body);

    // log("html response : ${html.body?.}");

    final links =
        doc.querySelectorAll('#menu > div > div > div > div.product-catagory-wrap > div').first;

    for (int i = 0; i < links.children.length; i++) {
      debugPrint("each: ${links.children[i].children[1].innerHtml}");
    }
    List<Map<String, dynamic>> listOfOb = [];

    // listOfOb.addAll(links.children.map((e) => ))
  }

  Future<List<Map<String, dynamic>>> getSomonTj() async {
    final path = Uri.parse('https://somon.tj/kompyuteryi-i-orgtehnika/programmyi-i-igryi/');

    final response = await http.get(path);

    dom.Document doc = dom.Document.html(response.body);

    final data = doc
        .querySelectorAll(
            '#listing > section > div.wrap > div.list-announcement-left.list-announcement-left--nomargin > div.list-announcement-assortiments > ul.list-simple__output.js-list-simple__output')
        .first;

    List<Map<String, dynamic>> names = [];

    for (var each in data.children) {
      final data = each.children[1].children
          .firstWhere((element) => element.className.contains('advert__content'))
          .children
          .firstWhere((element) => element.className.contains('advert__content-title'));

      final dataImage = each.children[0].children[0].children[0];

      List<String?> images = dataImage.children
          .map((e) => _getImageFromAttribute(e.attributes['style'].toString()))
          .toList();

      names.add({"name": data.innerHtml.trim(), 'images': images});
    }
    debugPrint("${names.map((e) => e)}");

    return names;
  }

  String? _getImageFromAttribute(String? data) {
    if (data == null) return null;
    var reg = RegExp('https?:[^)]+.(?:png|jpg|webp)');
    var matches = reg.allMatches(data);
    debugPrint("image $data");
    if (matches.isEmpty) return null;
    String? gettingData = matches.elementAt(0).group(0);

    return gettingData;
  }
}
