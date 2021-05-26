import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Package {
  String PackageId;
  String PackageName;
  String LocAdd;
  String AttName;

  Package({
    this.PackageId,
    this.PackageName,
    this.LocAdd,
    this.AttName,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDataToJson(this);
}

@JsonSerializable()
class PackageList {
  List<Package> package;

  PackageList({this.package});
  factory PackageList.fromJson(List<dynamic> json) {
    return PackageList(
        package: json
            .map((e) => Package.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

Package _$PackageDataFromJson(Map<String, dynamic> json) {
  return Package(
    PackageId: json['PackageId'].toString() as String,
    PackageName: json['PackageName'] as String,
    LocAdd: json['LocAdd'] as String,
    AttName: json['AttName'] as String,
  );
}

Map<String, dynamic> _$PackageDataToJson(Package instance) => <String, dynamic>{
      'PackageId': instance.PackageId,
      'PackageName': instance.PackageName,
    };
