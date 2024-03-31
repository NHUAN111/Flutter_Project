class SliderModel {
  final String sliderImg;

  SliderModel({required this.sliderImg});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(sliderImg: json['slider_img']);
  }
}
