class Player {
  final String nickname;
  final String socketID;
  final double points;
  final String playerType;
  Player({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketId': socketID,
      'score': points,
      'xoro': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['name'] ?? '',
      socketID: map['socketId'] ?? '',
      points: map['score']?.toDouble() ?? 0.0,
      playerType: map['xoro'] ?? '',
    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerType,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
