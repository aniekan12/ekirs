class DemandFields {
  static final List<String> values = [
    id,
    image,
  ];

  static final String id = 'id';
  static final String propertyId = 'property_id';
  static final String image = 'image';
}

class DemandNoticeModel {
  final int id;
  final String propertyId;
  final String image;

  const DemandNoticeModel({
    this.id,
    this.propertyId,
    this.image,
  });

  DemandNoticeModel copy({
    int id,
    String propertyId,
    String image,
  }) =>
      DemandNoticeModel(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        image: image ?? this.image,
      );

  static DemandNoticeModel fromJson(Map<String, Object> json) =>
      DemandNoticeModel(
        id: json[DemandFields.id] as int,
        propertyId: json[DemandFields.propertyId] as String,
        image: json[DemandFields.image] as String,
      );

  Map<String, Object> toJson() => {
        DemandFields.id: id,
        DemandFields.propertyId: propertyId,
        DemandFields.image: image
      };
}
