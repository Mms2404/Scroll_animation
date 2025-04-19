import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weaves/widgets/card.dart';
import 'package:weaves/widgets/models.dart';

class Silk extends StatefulWidget {
  const Silk({super.key});

  @override
  State<Silk> createState() => _SilkState();
}

class _SilkState extends State<Silk> {
  late ScrollController _scrollController;
  double scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          scrollPosition = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


 @override
Widget build(BuildContext context) {

  final List<ItemCardModel> silkList = [
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/34/c0/ef/34c0efed536b6de636aec70583a656fe.jpg',
    title: 'Kanchipuram Silk',
    details: 'Majestic patterns, golden zari, and heritage woven into elegance.'
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/66/52/12/665212a90071691bf79c11da929c879c.jpg',
    title: 'Mysure Silk',
    details: 'Smooth as moonlight with a natural shimmer — understated royalty.',

  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/474x/81/6f/ac/816faca83a68b2783b268426bafe2088.jpg',
    title: 'Tussar Silk',
    details: 'Rustic, raw texture with earthy hues — a lover of wild grace.',
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/fb/16/f2/fb16f2ee292dda071fbbd1baba738f8e.jpg',
    title: 'Banarasi Silk',
    details:  'Regal and radiant, crafted for grandeur and celebration.',
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/35/76/ea/3576ea18559cc4714e366d216945fe22.jpg',
    title: 'Chanderi Silk',
    details: 'Sheer, light, and subtle — whispering timeless elegance.',
  ),
  
];


  return Scaffold(
    body: CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 100,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "SILK WEAVES",
              style: GoogleFonts.alegreyaSc(fontSize: 35),
            ),
          ),
          centerTitle: false,
        ),

        SliverList(
  delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {
      final card = silkList[index];
      double spacing = 900;
      double relativeOffset = (scrollPosition - index * spacing) / spacing;

      double clampedOffset = relativeOffset.clamp(0.2, 1);
      double curvedOffset = Curves.easeInOut.transform(clampedOffset);

      double opacity = (1 - relativeOffset.abs()).clamp(0.8, 1.0);
      double curveAmount = 600;
      double angle = curvedOffset * pi / 4;

      double translateX = sin(angle) * curveAmount;
      double translateY = -cos(angle) * curveAmount + curveAmount;
      double flip = angle / 2;

      Matrix4 flipTransform = Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..translate(translateX, translateY)
        ..rotateX(flip);

      return Opacity(
        opacity: opacity,
        child: Transform(
          alignment: Alignment.center,
          transform: flipTransform,
          child: Pic_Card(
            height: 900,
            imagePath: card.imagePath,
            imageAlignment: Alignment.centerLeft,
            titleOverlay: Text(card.title, style:TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.white,), ),
            detailsOverlay: SlideInUp(
              duration: Duration(milliseconds: 400),
              from: 30, 
              child: Text(
                card.details,
                style: GoogleFonts.lora(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  height: 1.7,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.white,
                      offset: Offset(1.5, 1.5),
                   ),
                  ],
                ),
              ),
            ),

          ),
        ),
      );
    },
    childCount: silkList.length,
  ),
),


      ],
    ),
  );
}
}





