class UserFields {
  static const String teamName = 'TEAM NAME';
  static const String teamNum = 'TEAM #';
  static const String leave = 'LEAVE';
  static const String autoAmp = 'AUTO AMP NOTES';
  static const String autoSpeker = 'AUTO SPEAKER NOTES';
  static const String teleopAmp = 'TELEOP AMP NOTES';
  static const String teleopSpeaker = 'TELEOP SPEAKER NOTES';
  static const String onstage = 'ONSTAGE';
  static const String park = 'PARK';
  static const String trap = 'NOTES IN TRAP';
  static const String comments = 'COMMENTS';

  static List<String> getFields() => [
        teamName,
        teamNum,
        leave,
        autoAmp,
        autoSpeker,
        teleopAmp,
        teleopSpeaker,
        onstage,
        park,
        trap,
        comments,
      ];
}
