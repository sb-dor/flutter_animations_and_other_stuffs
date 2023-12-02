import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bloc_learning/streams/stream/simple_stream_bloc.dart';

class SimpleBlocPageWithStream extends StatefulWidget {
  const SimpleBlocPageWithStream({Key? key}) : super(key: key);

  @override
  State<SimpleBlocPageWithStream> createState() => _SimpleBlocPageWithStreamState();
}

class _SimpleBlocPageWithStreamState extends State<SimpleBlocPageWithStream> {
  late SimpleStreamBloc simpleStreamBloc;

  @override
  void initState() {
    super.initState();
    simpleStreamBloc = SimpleStreamBloc.instance;
    simpleStreamBloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bloc with stream")),
      body: SizedBox(
          width: double.maxFinite,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<SimpleStreamBlocData>(
                    //set initialData otherwise it shows "null" after first run
                    initialData: SimpleStreamBlocData(),
                    stream: simpleStreamBloc.streamListener,
                    builder: (context, stream) {
                      if (stream.data == null) {
                        return Container();
                      }
                      return TextButton(
                          onPressed: () => simpleStreamBloc.increment(),
                          child: Text("${stream.data?.counter}"));
                    })
              ])),
    );
  }
}
