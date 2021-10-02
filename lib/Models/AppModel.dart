import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:installed_apps/app_info.dart';

class Application {
  String appName;
  String appVersion;
  Uint8List appIcon;
  Application({
    @required this.appName,
    @required this.appVersion,
    @required this.appIcon,
  });

  Application copyWith({
    String appName,
    String appVersion,
    Uint8List appIcon,
  }) {
    return Application(
      appName: appName ?? this.appName,
      appVersion: appVersion ?? this.appVersion,
      appIcon: appIcon ?? this.appIcon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appName': appName,
      'appVersion': appVersion,
      'appIcon': String.fromCharCodes(appIcon),
    };
  }

  fromAppJason(AppInfo appData) {
    return {
      'appName': appData.name,
      'appVersion': appData.versionCode.toString(),
      'appIcon': String.fromCharCodes(appData.icon),
    };
  }

  factory Application.fromMap(Map<String, dynamic> map) {
    return Application(
      appName: map['appName'],
      appVersion: map['appVersion'],
      appIcon: Uint8List.fromList(map['appIcon']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Application.fromJson(String source) =>
      Application.fromMap(json.decode(source));

  @override
  String toString() =>
      'Application(appName: $appName, appVersion: $appVersion, appIcon: $appIcon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Application &&
        other.appName == appName &&
        other.appVersion == appVersion &&
        other.appIcon == appIcon;
  }

  @override
  int get hashCode => appName.hashCode ^ appVersion.hashCode ^ appIcon.hashCode;

  Application toList() {}
}
