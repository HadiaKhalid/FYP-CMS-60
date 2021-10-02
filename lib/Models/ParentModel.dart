class ParentModel {
  dynamic name;
  dynamic email;

  ParentModel({
    this.name,
    this.email,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) => new ParentModel(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}
