class PronviceModel {
  late String nameQuanhuyen;

  PronviceModel({
    required this.nameQuanhuyen,
  });

  factory PronviceModel.fromJson(Map<String, dynamic> json) {
    return PronviceModel(
      nameQuanhuyen: json['name_quanhuyen'],
    );
  }
}
