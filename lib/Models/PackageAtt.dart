import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PackageAtt {
  String RowId;
  String PackageId;
  String AttName;
  String AttRem;

  PackageAtt({
    this.RowId,
    this.PackageId,
    this.AttName,
    this.AttRem,
  });

  factory PackageAtt.fromJson(Map<String, dynamic> json) =>
      _$PackageAttDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackageAttDataToJson(this);
}

@JsonSerializable()
class PackageAttList {
  List<PackageAtt> packageAtt;

  PackageAttList({this.packageAtt});
  factory PackageAttList.fromJson(List<dynamic> json) {
    return PackageAttList(
        packageAtt: json
            .map((e) => PackageAtt.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

PackageAtt _$PackageAttDataFromJson(Map<String, dynamic> json) {
  return PackageAtt(
    RowId: json['RowId'].toString() as String,
    PackageId: json['PackageId'].toString() as String,
    AttName: json['AttName'] as String,
    AttRem: json['AttRem'] as String,
  );
}

Map<String, dynamic> _$PackageAttDataToJson(PackageAtt instance) =>
    <String, dynamic>{
      'RowId': instance.RowId,
      'PackageId': instance.PackageId,
    };
