import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class RoomModel {
  final String startTime;
  final String endTime;
  final String joinCode;
  final int duration;

  RoomModel({this.startTime, this.endTime, this.joinCode, this.duration});
  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  RoomModel copyWith(
      {String startTime, String endTime, String joinCode, int duration}) {
    return RoomModel(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      joinCode: joinCode ?? this.joinCode,
      duration: duration ?? this.duration,
    );
  }

  /// Constructs a new [DateTime] instance based on [startTime]
  DateTime get startTimeObj => DateTime.tryParse(startTime);

  /// Constructs a new [DateTime] instance based on [endTime]
  DateTime get endTimeObj => DateTime.parse(endTime);

  bool get hasGameStarted =>
      startTimeObj != null && startTimeObj.isBefore(DateTime.now());

  bool get hasGameEnded =>
      hasGameStarted && endTimeObj.isBefore(DateTime.now());

  bool get isJoinable => startTime == '' && endTime == '';
}
