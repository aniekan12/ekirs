// ignore_for_file: non_constant_identifier_names

class EnumerationFields {
  static final List<String> values = [
    /// Add all fields
    id,
    title,
    firstname,
    middlename,
    lastname,
    gender,
    email,
    phoneNumber,
    occupation,
    propertyId,
    houseNumber,
    street,
    area,
    landmark,
    propertyName,
    propertyType,
    areaSize,
    buildingType,
    buildingPurpose,
    category,
    areaClass,
    lga,
    zone,
    agentId,
    macAddress,
    latitude,
    longitude,
    image
  ];

  static final String id = 'id';
  static final String title = 'title';
  static final String firstname = 'first_name';
  static final String middlename = 'middle_name';
  static final String lastname = 'last_name';
  static final String gender = 'gender';
  static final String email = 'email';
  static final String phoneNumber = 'phone_number';
  static final String occupation = 'occupation';
  static final String propertyId = 'property_id';
  static final String houseNumber = 'house_number';
  static final String street = 'street';
  static final String area = 'area';
  static final String landmark = 'landmark';
  static final String propertyName = 'property_name';
  static final String propertyType = 'property_type';
  static final String areaSize = 'area_size';
  static final String buildingType = 'building_type';
  static final String buildingPurpose = 'building_purpose';
  static final String category = 'category';
  static final String areaClass = 'area_class';
  static final String lga = 'lga';
  static final String zone = 'zone';
  static final String agentId = 'agent_Id';
  static final String macAddress = 'mac_Address';
  static final String latitude = 'latitude';
  static final String longitude = 'longitude';
  static final String image = 'image';
}

class EnumerationModel {
  final int id;
  final String title;
  final String firstname;
  final String middlename;
  final String lastname;
  final String gender;
  final String email;
  final String phone_number;
  final String occupation;
  final String property_id;
  final String house_number;
  final String street;
  final String area;
  final String landmark;
  final String property_name;
  final String property_type;
  final String area_size;
  final String building_type;
  final String building_purpose;
  final String category;
  final String area_class;
  final String lga;
  final String zone;
  final String agent_id;
  final String mac_address;
  final String latitude;
  final String longitude;
  final String image;

  const EnumerationModel(
      {this.id,
      this.title,
      this.firstname,
      this.middlename,
      this.lastname,
      this.gender,
      this.email,
      this.phone_number,
      this.occupation,
      this.property_id,
      this.house_number,
      this.street,
      this.area,
      this.landmark,
      this.property_name,
      this.property_type,
      this.area_size,
      this.building_type,
      this.building_purpose,
      this.category,
      this.area_class,
      this.lga,
      this.zone,
      this.agent_id,
      this.mac_address,
      this.latitude,
      this.longitude,
      this.image});

  EnumerationModel copy({
    final int id,
    final String title,
    final String firstname,
    final String middlename,
    final String lastname,
    final String gender,
    final String email,
    final String phone_number,
    final String occupation,
    final String property_id,
    final String house_number,
    final String street,
    final String area,
    final String landmark,
    final String property_name,
    final String property_type,
    final String area_size,
    final String building_type,
    final String building_purpose,
    final String category,
    final String area_class,
    final String lga,
    final String zone,
    final String agent_id,
    final String mac_address,
    final String latitude,
    final String longitude,
    final String image,
  }) =>
      EnumerationModel(
        id: id ?? id,
        title: title ?? title,
        firstname: firstname ?? firstname,
        middlename: middlename ?? middlename,
        lastname: lastname ?? lastname,
        gender: gender ?? gender,
        email: email ?? email,
        phone_number: phone_number ?? phone_number,
        occupation: occupation ?? occupation,
        property_id: property_id ?? property_id,
        house_number: house_number ?? house_number,
        street: street ?? street,
        area: area ?? area,
        landmark: landmark ?? landmark,
        property_name: property_name ?? property_name,
        property_type: property_type ?? property_type,
        area_size: area_size ?? area_size,
        building_type: building_type ?? building_type,
        building_purpose: building_purpose ?? building_purpose,
        category: category ?? category,
        area_class: area_class ?? area_class,
        lga: lga ?? lga,
        zone: zone ?? zone,
        agent_id: agent_id ?? agent_id,
        mac_address: mac_address ?? mac_address,
        latitude: latitude ?? latitude,
        longitude: longitude ?? longitude,
        image: image ?? image,
      );
  static EnumerationModel fromJson(Map<String, Object> json) =>
      EnumerationModel(
          id: json[EnumerationFields.id] as int,
          title: json[EnumerationFields.title] as String,
          firstname: json[EnumerationFields.firstname] as String,
          middlename: json[EnumerationFields.middlename],
          lastname: json[EnumerationFields.lastname] as String,
          gender: json[EnumerationFields.gender] as String,
          email: json[EnumerationFields.email] as String,
          phone_number: json[EnumerationFields.phoneNumber] as String,
          occupation: json[EnumerationFields.occupation] as String,
          property_id: json[EnumerationFields.propertyId] as String,
          house_number: json[EnumerationFields.houseNumber] as String,
          street: json[EnumerationFields.street] as String,
          area: json[EnumerationFields.area] as String,
          landmark: json[EnumerationFields.landmark] as String,
          property_name: json[EnumerationFields.propertyName] as String,
          property_type: json[EnumerationFields.propertyType] as String,
          area_size: json[EnumerationFields.areaSize] as String,
          building_type: json[EnumerationFields.buildingType] as String,
          building_purpose: json[EnumerationFields.buildingPurpose] as String,
          category: json[EnumerationFields.category] as String,
          area_class: json[EnumerationFields.areaClass] as String,
          lga: json[EnumerationFields.lga] as String,
          zone: json[EnumerationFields.zone] as String,
          agent_id: json[EnumerationFields.agentId] as String,
          mac_address: json[EnumerationFields.macAddress] as String,
          latitude: json[EnumerationFields.latitude] as String,
          longitude: json[EnumerationFields.longitude] as String,
          image: json[EnumerationFields.image]);

  Map<String, Object> toJson() => {
        EnumerationFields.id: id,
        EnumerationFields.title: title,
        EnumerationFields.firstname: firstname,
        EnumerationFields.middlename: middlename,
        EnumerationFields.lastname: lastname,
        EnumerationFields.gender: gender,
        EnumerationFields.email: email,
        EnumerationFields.phoneNumber: phone_number,
        EnumerationFields.occupation: occupation,
        EnumerationFields.propertyId: property_id,
        EnumerationFields.houseNumber: house_number,
        EnumerationFields.street: street,
        EnumerationFields.area: area,
        EnumerationFields.landmark: landmark,
        EnumerationFields.propertyName: property_name,
        EnumerationFields.propertyType: property_type,
        EnumerationFields.areaSize: area_size,
        EnumerationFields.buildingType: building_type,
        EnumerationFields.buildingPurpose: building_purpose,
        EnumerationFields.category: category,
        EnumerationFields.areaClass: area_class,
        EnumerationFields.lga: lga,
        EnumerationFields.zone: zone,
        EnumerationFields.agentId: agent_id,
        EnumerationFields.macAddress: mac_address,
        EnumerationFields.latitude: latitude,
        EnumerationFields.longitude: longitude,
        EnumerationFields.image: image,
      };
}
