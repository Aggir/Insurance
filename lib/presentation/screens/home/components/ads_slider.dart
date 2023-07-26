import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        aspectRatio: MediaQuery.of(context).size.width.r / 130.h,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  Widget adWidget(String imgUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.medium.r),
      child: ClipRRect(
          borderRadius:
              BorderRadius.circular(AppValues.cardPageContainerRadius.r),
          child: Image.asset(
            imgUrl,
            fit: BoxFit.fitHeight,
          )),
    );
  }
}
