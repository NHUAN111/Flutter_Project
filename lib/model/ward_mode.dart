class WardModel {
  late String nameXaphuong;

  WardModel({
    required this.nameXaphuong,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) {
    return WardModel(
      nameXaphuong: json['name_xaphuong'],
    );
  }
}
