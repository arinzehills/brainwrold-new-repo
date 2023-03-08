// import 'package:jitsi_meet/feature_flag/feature_flag.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet_v1/jitsi_meet.dart';

class JitsiMeetMethods {
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String? username,
  }) async {
    try {
      // FeatureFlag featureFlag = FeatureFlag();
      // FeatureFlag.isWelcomePageEnabled = false;
      // featureFlag.welcomePageEnabled = false;
      // featureFlag.resolution = FeatureFlagVideoResolution
      //     .MD_RESOLUTION; // Limit video resolution to 360p

      String name;
      if (username == null) {
        // final userdata = _authMethods.userDetails;
        // print(userdata);
        // name = _authMethods.user.displayName!;
        name = 'Brainworld';
      } else {
        name = username;
      }
      // var options = JitsiMeetingOptions(room: roomName)
      //   ..subject = 'Bible Study'
      //   ..userDisplayName = name
      //   ..userEmail = _authMethods.user.email
      //   ..userAvatarURL = _authMethods.user.photoURL
      //   ..audioMuted = isAudioMuted
      //   ..videoMuted = isVideoMuted;

      var options = JitsiMeetingOptions(
          // roomNameOrUrl: roomName,
          // subject: 'Bible Study',
          // userDisplayName: name,
          // userEmail: _authMethods.user.email,
          // userAvatarUrl: _authMethods.user.photoURL,
          // isAudioMuted: isAudioMuted,
          // isVideoMuted: isVideoMuted,
          room: roomName);

      // _firestoreMethods.addToMeetingHistory(roomName);
      // await JitsiMeet.joinMeeting(options);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
