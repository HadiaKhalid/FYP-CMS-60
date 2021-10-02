class LocationModel {
  dynamic lat;
  dynamic lng;

  LocationModel({
    this.lat,
    this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      new LocationModel(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
