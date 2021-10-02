import 'dart:convert';

class Child {
  String name;
  String age;
  String parentID;
  Child({
    this.name,
    this.age,
    this.parentID,
  });

  Child copyWith({
    String name,
    String age,
    String parentID,
  }) {
    return Child(
      name: name ?? this.name,
      age: age ?? this.age,
      parentID: parentID ?? this.parentID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'parentID': parentID,
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      name: map['name'],
      age: map['age'],
      parentID: map['parentID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Child.fromJson(String source) => Child.fromMap(json.decode(source));

  @override
  String toString() => 'Child(name: $name, age: $age, parentID: $parentID)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Child &&
        other.name == name &&
        other.age == age &&
        other.parentID == parentID;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ parentID.hashCode;
}
