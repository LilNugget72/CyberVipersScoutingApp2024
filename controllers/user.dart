import 'dart:convert';
import 'dart:core';

class UserFields {
  static const String teamNum = 'TEAM #';
  static const String teamName = 'TEAM NAME';
  static const String matchNum = 'MATCH #';

  static const String posAmp = 'ROBOT AMP POSITION';
  static const String posCenter = 'ROBOT CENTER POSITION';
  static const String posBetween = 'ROBOT BETWEEN POSITION';
  static const String posSource = 'ROBOT SOURCE POSITION';

  static const String note1 = 'NOTE 1'; //note closest to the amp
  static const String note2 = 'NOTE 2';
  static const String note3 = 'NOTE 3'; //note farthest to the amp

  static const String note4 = 'NOTE 4'; //note closest to the amp on the bottom
  static const String note5 = 'NOTE 5';
  static const String note6 = 'NOTE 6';
  static const String note7 = 'NOTE 7';
  static const String note8 = 'NOTE 8'; //note farthest to the amp bottom

  static const String leave = 'LEAVE';
  static const String autoAmp = 'AUTO AMP NOTES';
  static const String autoSpeker = 'AUTO SPEAKER NOTES';

  static const String teleopAmp = 'TELEOP AMP NOTES';
  static const String teleopAmpMissed = 'TELEOP AMP MISSED';
  static const String teleopSpeaker = 'TELEOP SPEAKER NOTES';
  static const String teleopSpeakerMissed = 'TELEOP SPEAKER MISSED';
  static const String trap = 'NOTES IN TRAP';
  static const String trapMissed = 'MISSED TRAP';

  static const String leftStage = 'LEFT STAGE';
  static const String centerStage = 'CENTER STAGE';
  static const String rightStage = 'RIGHT STAGE';

  static const String dNone = 'NONE';
  static const String dModest = 'MODEST';
  static const String dGenerous = 'GENEROUS';
  static const String dPlenty = 'PLENTY';
  static const String dExclusively = 'EXCLUSIVELY';

  static const String onstage = 'ONSTAGE';
  static const String park = 'PARK';
  static const String harmony = 'HARMONY';

  static const String comments = 'COMMENTS';
  static const String scoutersName = 'SCOUTER\'S NAME';

  static List<String> getFields() => [
        teamNum,
        teamName,
        matchNum,
        posAmp,
        posCenter,
        posBetween,
        posSource,
        note1,
        note2,
        note3,
        note4,
        note5,
        note6,
        note7,
        note8,
        leave,
        autoAmp,
        autoSpeker,
        teleopAmp,
        teleopAmpMissed,
        teleopSpeaker,
        teleopSpeakerMissed,
        trap,
        trapMissed,
        leftStage,
        centerStage,
        rightStage,
        dNone,
        dModest,
        dGenerous,
        dPlenty,
        dExclusively,
        onstage,
        park,
        harmony,
        comments,
        scoutersName,
      ];
}

class User {
  int? teamNum;
  String? teamName;
  int? matchNum;
  bool? posAmp;
  bool? posCenter;
  bool? posBetween;
  bool? posSource;
  bool? note1;
  bool? note2;
  bool? note3;
  bool? note4;
  bool? note5;
  bool? note6;
  bool? note7;
  bool? note8;
  bool? leave;
  int? autoAmp;
  int? autoSpeaker;
  int? teleopAmp;
  int? teleopAmpMissed;
  int? teleopSpeaker;
  int? teleopSpeakerMissed;
  int? trap;
  int? trapMissed;
  bool? leftStage;
  bool? centerStage;
  bool? rightStage;
  bool? park;
  bool? harmony;
  String? comments;
  String? scoutersName;

  User({
    this.teamNum,
    this.teamName,
    this.matchNum,
    this.posAmp,
    this.posCenter,
    this.posBetween,
    this.posSource,
    this.note1,
    this.note2,
    this.note3,
    this.note4,
    this.note5,
    this.note6,
    this.note7,
    this.note8,
    this.leave,
    this.autoAmp,
    this.autoSpeaker,
    this.teleopAmp,
    this.teleopAmpMissed,
    this.teleopSpeaker,
    this.teleopSpeakerMissed,
    this.trap,
    this.trapMissed,
    this.leftStage,
    this.centerStage,
    this.rightStage,
    this.park,
    this.harmony,
    this.comments,
    this.scoutersName,
  });

  User copy({
    int? teamNum,
    String? teamName,
    int? matchNum,
    bool? posAmp,
    bool? posCenter,
    bool? posBetween,
    bool? posSource,
    bool? note1,
    bool? note2,
    bool? note3,
    bool? note4,
    bool? note5,
    bool? note6,
    bool? note7,
    bool? note8,
    bool? leave,
    int? autoAmp,
    int? autoSpeaker,
    int? teleopAmp,
    int? teleopAmpMissed,
    int? teleopSpeaker,
    int? teleopSpeakerMissed,
    int? trap,
    int? trapMissed,
    bool? leftStage,
    bool? centerStage,
    bool? rightStage,
    bool? park,
    bool? harmony,
    String? comments,
    String? scoutersName,
  }) =>
      User(
          teamNum: teamNum ?? this.teamNum,
          teamName: teamName ?? this.teamName,
          matchNum: matchNum ?? this.matchNum,
          posAmp: posAmp ?? this.posAmp,
          posCenter: posCenter ?? this.posCenter,
          posBetween: posBetween ?? this.posBetween,
          posSource: posSource ?? this.posSource,
          note1: note1 ?? this.note1,
          note2: note2 ?? this.note2,
          note3: note3 ?? this.note3,
          note4: note4 ?? this.note4,
          note5: note5 ?? this.note5,
          note6: note6 ?? this.note6,
          note7: note7 ?? this.note7,
          note8: note8 ?? this.note8,
          leave: leave ?? this.leave,
          autoAmp: autoAmp ?? this.autoAmp,
          autoSpeaker: autoSpeaker ?? this.autoSpeaker,
          teleopAmp: teleopAmp ?? this.teleopAmp,
          teleopAmpMissed: teleopAmpMissed ?? this.teleopAmpMissed,
          teleopSpeaker: teleopSpeaker ?? this.teleopSpeaker,
          teleopSpeakerMissed: teleopSpeakerMissed ?? this.teleopSpeakerMissed,
          trap: trap ?? this.trap,
          trapMissed: trapMissed ?? this.trapMissed,
          leftStage: leftStage ?? this.leftStage,
          centerStage: centerStage ?? this.centerStage,
          rightStage: rightStage ?? this.rightStage,
          park: park ?? this.park,
          harmony: harmony ?? this.harmony,
          comments: comments ?? this.comments,
          scoutersName: scoutersName ?? this.scoutersName);

  static User fromJson(Map<String, dynamic> json) => User(
        teamNum: jsonDecode(json[UserFields.teamNum]),
        teamName: json[UserFields.teamName],
        matchNum: jsonDecode(json[UserFields.matchNum]),
        posAmp: jsonDecode(json[UserFields.posAmp]),
        posCenter: jsonDecode(json[UserFields.posCenter]),
        posBetween: jsonDecode(json[UserFields.posBetween]),
        posSource: jsonDecode(json[UserFields.posSource]),
        note1: jsonDecode(json[UserFields.note1]),
        note2: jsonDecode(json[UserFields.note2]),
        note3: jsonDecode(json[UserFields.note3]),
        note4: jsonDecode(json[UserFields.note4]),
        note5: jsonDecode(json[UserFields.note5]),
        note6: jsonDecode(json[UserFields.note6]),
        note7: jsonDecode(json[UserFields.note7]),
        note8: jsonDecode(json[UserFields.note8]),
        leave: jsonDecode(json[UserFields.leave]),
        autoAmp: jsonDecode(json[UserFields.autoAmp]),
        autoSpeaker: jsonDecode(json[UserFields.autoSpeker]),
        teleopAmp: jsonDecode(json[UserFields.teleopAmp]),
        teleopAmpMissed: jsonDecode(json[UserFields.teleopAmpMissed]),
        teleopSpeaker: jsonDecode(json[UserFields.teleopSpeaker]),
        teleopSpeakerMissed: jsonDecode(json[UserFields.teleopSpeakerMissed]),
        trap: jsonDecode(json[UserFields.trap]),
        trapMissed: jsonDecode(json[UserFields.trapMissed]),
        leftStage: jsonDecode(json[UserFields.leftStage]),
        centerStage: jsonDecode(json[UserFields.centerStage]),
        rightStage: jsonDecode(json[UserFields.rightStage]),
        park: jsonDecode(json[UserFields.park]),
        harmony: jsonDecode(json[UserFields.harmony]),
        comments: json[UserFields.comments],
        scoutersName: json[UserFields.scoutersName],
      );

  Map<String, dynamic> toJson() => {
        UserFields.teamNum: teamNum,
        UserFields.teamName: teamName,
        UserFields.matchNum: matchNum,
        UserFields.posAmp: posAmp,
        UserFields.posCenter: posCenter,
        UserFields.posBetween: posBetween,
        UserFields.posSource: posSource,
        UserFields.note1: note1,
        UserFields.note2: note2,
        UserFields.note3: note3,
        UserFields.note4: note4,
        UserFields.note5: note5,
        UserFields.note6: note6,
        UserFields.note7: note7,
        UserFields.note8: note8,
        UserFields.leave: leave,
        UserFields.autoAmp: autoAmp,
        UserFields.autoSpeker: autoSpeaker,
        UserFields.teleopAmp: teleopAmp,
        UserFields.teleopAmpMissed: teleopAmpMissed,
        UserFields.teleopSpeaker: teleopSpeaker,
        UserFields.teleopSpeakerMissed: teleopSpeakerMissed,
        UserFields.trap: trap,
        UserFields.trapMissed: trapMissed,
        UserFields.leftStage: leftStage,
        UserFields.centerStage: centerStage,
        UserFields.rightStage: rightStage,
        UserFields.park: park,
        UserFields.harmony: harmony,
        UserFields.comments: comments,
        UserFields.scoutersName: scoutersName,
      };
}
