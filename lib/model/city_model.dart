class CityModel {
  late String nameCity;

  CityModel({
    required this.nameCity,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      nameCity: json['name_city'],
    );
  }
}
