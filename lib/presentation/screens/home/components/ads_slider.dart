import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

class ADsSlider extends StatelessWidget {
  final List<String> adsUrls;
  const ADsSlider(this.adsUrls, {super.key});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: adsUrls.length,
      itemBuilder: (context, index, realIndex) => adWidget(adsUrls[index]),
      options: CarouselOptions(
        autoPlay: true,
        // initialPage: (adsUrls.length / 2).floor(),
        viewportFraction: 1,
        height: AppSizes.s130,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  Widget adWidget(String imgUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.medium),
      child: ClipRRect(
          borderRadius:
              BorderRadius.circular(AppValues.cardPageContainerRadius),
          child: Image.asset(imgUrl)),
    );
  }
}
