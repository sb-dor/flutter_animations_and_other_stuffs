import 'package:flutter/material.dart';
import 'package:flutter_animations_2/getit/domain/models/meme_model.dart';
import 'package:flutter_animations_2/getit/locator.dart';
import 'package:flutter_animations_2/getit/presentation/meme_repository.dart';

class GetItPage extends StatefulWidget {
  const GetItPage({super.key});

  @override
  State<GetItPage> createState() => _GetItPageState();
}

class _GetItPageState extends State<GetItPage> {
  MemeModel? memeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNextMeme();
  }

  void getNextMeme() async {
    memeModel = null;
    setState(() {});
    // getting the registered singleton
    memeModel = await locator.get<MemeRepository>().getMeme();

    // also you can get the registered singleton like this:
    // memeModel = await locator<MemeRepository>().getMeme();
    setState(() {});
  }

  // checking get it registration
  bool checkRegistration() {
    return locator.isRegistered<MemeRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => getNextMeme(),
        child: const Icon(Icons.skip_next),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (memeModel == null)
                  const CircularProgressIndicator()
                else
                  Column(
                    children: [Image.network(memeModel?.image ?? '')],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
