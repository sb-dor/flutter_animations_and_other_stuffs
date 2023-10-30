import 'package:flutter/material.dart';
import 'package:flutter_animations_2/design_templates/mvvm/viewmodel_mvvm.dart';
import 'package:provider/provider.dart';

class ViewMVVM extends StatelessWidget {
  const ViewMVVM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModelMVVM = Provider.of<ViewModelMVVM>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("MVVM")),
      body: SizedBox(
          width: double.maxFinite,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${viewModelMVVM.modelMVVM.counter}"),
                TextButton(
                    onPressed: () => viewModelMVVM.increment(),
                    child: const Text("Text Button Increment"))
              ])),
    );
  }
}
