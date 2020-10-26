import 'package:json_annotation/json_annotation.dart';
import 'player_model.dart';
part 'room_model.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class RoomModel {

  final String startTime;
  final String endTime;
  final int duration;

  RoomModel(
      {
      this.startTime,
      this.endTime,
      this.duration});
  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  RoomModel copyWith(
      {
      String startTime,
      String endTime,
      int duration}) {
    return RoomModel(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
    );
  }
}
