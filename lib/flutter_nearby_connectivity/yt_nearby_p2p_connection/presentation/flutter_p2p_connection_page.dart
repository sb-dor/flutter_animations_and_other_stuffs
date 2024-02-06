import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/cubit/nearby_server_cubit.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/cubit/nearby_server_states.dart';
import 'package:flutter_animations_2/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlutterP2pConnectionPage extends StatefulWidget {
  const FlutterP2pConnectionPage({super.key});

  @override
  State<FlutterP2pConnectionPage> createState() => _FlutterP2pConnectionPageState();
}

class _FlutterP2pConnectionPageState extends State<FlutterP2pConnectionPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter p2p connection"),
      ),
      body: BlocBuilder<NearbyServerCubit, NearbyServerStates>(builder: (context, state) {
        var currentState = state.nearbyServerStateModel;
        return ListView(
          padding: EdgeInsets.only(left: 10, right: 10),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                const TextWidget(
                  text: "Server",
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child:
                        TextWidget(text: (currentState.server?.running ?? false) ? "ON" : "Off")),
                ElevatedButton(
                  onPressed: () => context.read<NearbyServerCubit>().initServer(),
                  child: Text((currentState.server?.running ?? false) ? "Switch off" : "Switch on"),
                )
              ],
            ),
            Row(
              children: [
                const TextWidget(
                  text: "Client: ",
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 10),
                TextWidget(
                    text: (currentState.client?.isConnected ?? false)
                        ? "Connected to the ${currentState.client?.hostName}"
                        : "Off"),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context.read<NearbyServerCubit>().initDevices();
                    showAllDevices();
                  },
                  child: const Text("Connect"),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                    )),
                    child: TextField(
                      controller: currentState.messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (currentState.client != null) {
                      context.read<NearbyServerCubit>().sendClientMessage();
                    } else {
                      context.read<NearbyServerCubit>().sendMessage();
                    }
                  },
                  child: const Text("Send"),
                )
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: currentState.serverComingData.length,
              itemBuilder: (context, index) {
                return TextWidget(text: currentState.serverComingData[index]);
              },
            ),
          ],
        );
      }),
    );
  }

  void showAllDevices() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 300,
            child: BlocBuilder<NearbyServerCubit, NearbyServerStates>(builder: (context, state) {
              var currentState = state.nearbyServerStateModel;
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount: currentState.networkAddress.length,
                itemBuilder: (context, index) {
                  var message = currentState.networkAddress[index];
                  return TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<NearbyServerCubit>()
                            .connectToServer(currentState.networkAddress[index]);
                      },
                      child: Text("${message.ip}"));
                },
              );
            }),
          );
        });
  }
}
