import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_web_scrapper/helper/flutter_web_scrapper_helper.dart';

class FlutterWebScrapperPage extends StatefulWidget {
  const FlutterWebScrapperPage({Key? key}) : super(key: key);

  @override
  State<FlutterWebScrapperPage> createState() => _FlutterWebScrapperPageState();
}

class _FlutterWebScrapperPageState extends State<FlutterWebScrapperPage> {
  final FlutterWebScrapperHelper _scrapperHelper = FlutterWebScrapperHelper.instance;

  List<Map<String, dynamic>> list = [];

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrapperHelper.getPizzaHouseMainScreenCategoriesName();
    fetchData();
  }

  void fetchData() async {
    list = await _scrapperHelper.getSomonTj();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter web scrapper page"),
      ),
      body: ListView(
        children: [
          if (loading)
            const Center(child: CircularProgressIndicator())
          else
            ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      if ((list[index]['images'] ?? []).isNotEmpty ||
                          (list[index]['images'] ?? []).first != null)
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            list[index]['images'].first ?? "",
                            errorBuilder: (context, ob, st) => const Text("Error"),
                          ),
                        )
                      else
                        const SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(child: Text("Image")),
                        ),
                      const SizedBox(width: 10),
                      Expanded(child: Text("${list[index]['name']}")),
                    ],
                  );
                })
        ],
      ),
    );
  }
}
