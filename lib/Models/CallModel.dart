class CallModel {
  dynamic CallType;
  dynamic duration;
  dynamic name;
  dynamic number;
  dynamic timestamp;
  DateTime date;
  CallModel(
      {this.CallType, this.duration, this.name, this.number, this.timestamp});

  factory CallModel.fromJson(Map<String, dynamic> json) => new CallModel(
        CallType: json["CallType"],
        duration: json["duration"],
        name: json["duration"],
        number: json["duration"],
        timestamp: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "CallType": CallType,
        "name": name,
        "duration": duration,
        "number": number,
        "timestamp": timestamp,
      };
}
