// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as rtcLocal;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtcRemote;
// import 'package:flutter/material.dart';
// import 'package:flutter_animations_2/agora_rtc_engine/utils/agora_settings.dart';
//
// class CallPage extends StatefulWidget {
//   final String? channelName;
//   final ClientRoleType? role;
//
//   const CallPage({
//     super.key,
//     this.channelName,
//     this.role,
//   });
//
//   @override
//   State<CallPage> createState() => _CallPageState();
// }
//
// class _CallPageState extends State<CallPage> {
//   final _users = <int>[];
//   final _infoStrings = <String>[];
//   bool muted = false;
//   bool viewPanel = false;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initialize();
//   }
//
//   @override
//   void dispose() {
//     _users.clear();
//     _engine.destroy();
//     super.dispose();
//   }
//
//   Future<void> initialize() async {
//     if (appId.isEmpty) {
//       setState(() {
//         _infoStrings.add("APP_ID is missing, please proivide your APP_ID in settings.dart");
//         _infoStrings.add("Agora engine is not starting");
//       });
//       return;
//     }
//     _engine = await RtcEngine.create(appId);
//     await _engine.enableVideo();
//     await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     await _engine.setClientRole(widget.role!);
//     _addAgoraEventHandler();
//     VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
//     configuration.dimensions = const VideoDimensions(width: 1920, height: 1080);
//     await _engine.setVideoEncoderConfiguration(configuration);
//     await _engine.joinChannel(token, widget.channelName!, null, 0);
//   }
//
//   void _addAgoraEventHandler() {
//     _engine.setEventHandler(
//       RtcEngineEventHandler(
//         error: (code) {
//           setState(() {
//             final info = "Error: $code";
//             _infoStrings.add(info);
//           });
//         },
//         joinChannelSuccess: (channel, uid, elapsed) {
//           setState(() {
//             final info = "Join channel: $channel, uid: $uid";
//             _infoStrings.add(info);
//           });
//         },
//         leaveChannel: (stats) {
//           setState(() {
//             _infoStrings.add("Leave channel");
//             _users.clear();
//           });
//         },
//         userJoined: (uid, elapse) {
//           setState(() {
//             final info = 'User joined: $uid';
//             _infoStrings.add(info);
//             _users.add(uid);
//           });
//         },
//         userOffline: (uid, elapsed) {
//           setState(() {
//             final info = 'User offline: $uid';
//             _infoStrings.add(info);
//             _users.removeWhere((element) => element == uid);
//           });
//         },
//         firstRemoteVideoFrame: (uid, width, height, elapsed) {
//           setState(() {
//             final info = 'First remote video: $uid ${width}x $height';
//             _infoStrings.add(info);
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _viewRows() {
//     final List<StatefulWidget> list = [];
//     if (widget.role == ClientRole.Broadcaster) {
//       list.add(const rtcLocal.SurfaceView());
//     }
//     for (final uid in _users) {
//       list.add(rtcRemote.SurfaceView(
//         uid: uid,
//         channelId: widget.channelName!,
//       ));
//     }
//     final views = list;
//     return Column(
//       children: views.map((widget) => Expanded(child: widget)).toList(),
//     );
//   }
//
//   Widget _toolBar() {
//     if (widget.role == ClientRole.Audience) return const SizedBox();
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           RawMaterialButton(
//             onPressed: () {
//               setState(() {
//                 muted = !muted;
//               });
//               _engine.muteLocalAudioStream(muted);
//             },
//             shape: const CircleBorder(),
//             fillColor: muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12),
//             child: Icon(
//               muted ? Icons.mic_off : Icons.mic,
//               color: muted ? Colors.white : Colors.blueAccent,
//               size: 20,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () => Navigator.pop(context),
//             elevation: 2,
//             shape: const CircleBorder(),
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15),
//             child: const Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               _engine.switchCamera();
//             },
//             shape: const CircleBorder(),
//             fillColor: Colors.white,
//             padding: const EdgeInsets.all(12),
//             child: const Icon(
//               Icons.switch_camera,
//               color: Colors.blueAccent,
//               size: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _panel() {
//     return Visibility(
//       visible: viewPanel,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 48),
//         alignment: Alignment.bottomCenter,
//         child: FractionallySizedBox(
//           heightFactor: 0.5,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 48),
//             child: ListView.builder(
//                 reverse: true,
//                 itemCount: _infoStrings.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(7),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Flexible(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 2,
//                               horizontal: 5,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Text(
//                               _infoStrings[index],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Agora"),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         actions: [
//           IconButton(
//             onPressed: () => setState(
//               () {
//                 viewPanel = !viewPanel;
//               },
//             ),
//             icon: const Icon(Icons.info_outline),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Stack(
//           children: [
//             _viewRows(),
//             _panel(),
//             _toolBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }
