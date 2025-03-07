import 'package:flutter/material.dart';
import 'package:flutter_animations_2/material3/material_changer_cubit/material_change_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Calendar { day, week, month, year }

class SegmentButtonClass extends StatefulWidget {
  const SegmentButtonClass({super.key});

  @override
  State<SegmentButtonClass> createState() => _SegmentButtonClassState();
}

class _SegmentButtonClassState extends State<SegmentButtonClass> {
  //if you want to use single selection
  Calendar data = Calendar.day;

  //if you want to use multi selection
  Set<Calendar> selection = <Calendar>{Calendar.day, Calendar.week};

  Map<String, dynamic>? dataFromRoute;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dataFromRoute =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      setState(() {});
      debugPrint("data from past page : $dataFromRoute");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Segmented Button",
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () =>
                  context.read<MaterialChangeCubit>().changeToMaterial2(),
              icon: const Icon(Icons.two_k)),
          IconButton(
              onPressed: () =>
                  context.read<MaterialChangeCubit>().changeToMaterial3(),
              icon: const Icon(Icons.three_k))
        ],
      ),
      body: ListView(children: [
        const SizedBox(height: 10),
        SegmentedButton<Calendar>(
          segments: const [
            ButtonSegment<Calendar>(value: Calendar.day, label: Text("Day")),
            ButtonSegment<Calendar>(value: Calendar.week, label: Text("Week")),
            ButtonSegment<Calendar>(
                value: Calendar.month, label: Text("Month")),
            ButtonSegment<Calendar>(value: Calendar.year, label: Text("Year")),
          ],

          //if you want to select only one data use this code
          // selected: <Calendar>{data},
          //otherwise use this one
          selected: selection,
          onSelectionChanged: (v) => setState(
            () {
              //if you want to use multi selection use only this code below
              data = v.first;
              //if you want to use multi selection use only this code below
              selection = v;
            },
          ),
          //if you want to use multi selection turn this to true
          multiSelectionEnabled: true,
        ),
        const SizedBox(height: 20),
        Align(
            alignment: Alignment.centerLeft,
            child: Badge(
                label: const Text("2"),
                isLabelVisible: true,
                child: TextButton(
                    onPressed: () => [],
                    child: const Text("Text Button with Badge"))))
      ]),
    );
  }
}
