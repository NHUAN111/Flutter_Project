import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_specialized_1/model/slider_model.dart';
import 'package:project_specialized_1/view_model/slider_view_model.dart';
import 'package:provider/provider.dart';

class SliderView extends StatefulWidget {
  const SliderView({Key? key}) : super(key: key);

  @override
  _SliderViewState createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  int _currentIndex = 0;
  late Future<List<SliderModel>> futureSliders;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<SliderViewModel>(context, listen: false);
    futureSliders = viewModel.fetchSliders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SliderModel>>(
      future: futureSliders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<SliderModel> sliders = snapshot.data!;
          return Column(
            children: [
              const SizedBox(
                height: 5, // Set your desired top margin here
              ),
              CarouselSlider(
                items: sliders.map((slider) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(slider.sliderImg),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
