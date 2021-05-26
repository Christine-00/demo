import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BannerImages {
  int RowID;
  String AttName;

  BannerImages({
    this.RowID,
    this.AttName,
  });

  factory BannerImages.fromJson(Map<String, dynamic> json) =>
      _$BannerImagesDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerImagesDataToJson(this);
}

@JsonSerializable()
class BannerImagesList {
  List<BannerImages> bannerImages;

  BannerImagesList({this.bannerImages});
  factory BannerImagesList.fromJson(List<dynamic> json) {
    return BannerImagesList(
        bannerImages: json
            .map((e) => BannerImages.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

BannerImages _$BannerImagesDataFromJson(Map<String, dynamic> json) {
  return BannerImages(
    RowID: json['RowID'] as int,
    AttName: json['AttName'] as String,
  );
}

Map<String, dynamic> _$BannerImagesDataToJson(BannerImages instance) =>
    <String, dynamic>{
      'RowID': instance.RowID,
      'AttName': instance.AttName,
    };
