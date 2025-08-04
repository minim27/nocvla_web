import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/core/base_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraController extends BaseController {
  late RtcEngine engine;

  var user = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await initAgora();
  }

  // Set up the Agora RTC engine instance
  Future<void> _initializeAgoraVoiceSDK() async {
    // 2. Create & initialize engine
    engine = createAgoraRtcEngine();
    await engine.initialize(
      RtcEngineContext(
        appId: "b34bdda2edd9404b98ef907cdfa063ab",
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  // Join a channel
  Future<void> _joinChannel() async {
    await engine.joinChannel(
      token:
          "007eJxTYPg0N/3NzrcJTC/yRQ5nVyT2nZZbPjPmkJh/RvREvQ0B+YkKDEnGJkkpKYlGqSkpliYGJkmWFqlplgbmySlpiQZmxolJk1Z3ZDQEMjJ4mzUxMjJAIIjPy+DoHero4ujj6OHh6uHKwAAA1kkiUQ==",
      channelId: "AKUADALAHHEHE",
      uid: 0,
      options: const ChannelMediaOptions(
        autoSubscribeAudio:
            true, // Automatically subscribe to all audio streams
        publishMicrophoneTrack: true, // Publish microphone-captured audio
        // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  // Register an event handler for Agora RTC
  void _setupEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
          var a = await Permission.microphone.request();
          Get.snackbar("title", a.toString());
          debugPrint("Local user ${connection.localUid} joined");
          user.value = "${connection.localUid}";
        },
        onUserJoined:
            (RtcConnection connection, int remoteUidVal, int elapsed) {
              debugPrint("Remote user $remoteUidVal joined");
            },
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUidVal,
              UserOfflineReasonType reason,
            ) async {
              debugPrint("Remote user $remoteUidVal left");
            },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[Agora] Token will expire soon.');
        },
      ),
    );
  }

  // Requests microphone permission
  Future<void> _requestPermissions() async {
    await [Permission.microphone].request();
  }

  Future<void> initAgora() async {
    await _requestPermissions();
    await _initializeAgoraVoiceSDK();
    _setupEventHandlers();
    await _joinChannel();
  }
}
