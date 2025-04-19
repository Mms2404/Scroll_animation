
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weaves/widgets/card.dart';
import 'package:weaves/widgets/models.dart';

class Trendy extends StatefulWidget {
  const Trendy({super.key});

  @override
  State<Trendy> createState() => _TrendyState();
}

class _TrendyState extends State<Trendy> {

  // scroll controls
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

  final List<ItemCardModel> trendyList = [
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/fc/c3/53/fcc353a1dd958f02111959291f16d784.jpg',
    title: 'Linen',
    details: "Linen sarees offer a distinctive blend of rustic charm and sophistication, showcasing a textured finish that effortlessly elevates any ensemble."
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/91/fa/5b/91fa5b917b363648ec45b0786913fc4f.jpg',
    title: 'Georgette',
     details: "Georgette sarees are celebrated for their flowing, lightweight fabric and graceful drape, often adorned with vibrant prints and embellishments that add a touch of modern elegance to traditional attire."
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/16/6b/7c/166b7cf0f06b1356f418a311d1368613.jpg',
    title: 'Organza',
     details: "Organza sarees are known for their sheer, crisp texture and ethereal quality, often featuring delicate embellishments that create a stunningly elegant look for formal events."
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/01/96/4a/01964ac749000d0bd6b55bf71065a2e4.jpg',
    title: 'Embroidary',
     details: "Embroidered sarees showcase intricate needlework and embellishments, adding a touch of opulence and artistry to traditional attire for special occasions"
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/9e/55/6b/9e556b9504a51383818ab7affb170fef.jpg',
    title: 'Suit',
     details: "Suit sarees, also known as saree suits, combine the elegance of a saree with the convenience of a pre-stitched design"
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
              "TRENDY WEAVES",
              style: GoogleFonts.alegreyaSc(fontSize: 35),
            ),
          ),
          centerTitle: false,
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final card = trendyList[index];
              double spacing = 900;
              double relativeOffset = (scrollPosition - index * spacing) / spacing;

              double opacity = (1.5 - relativeOffset.abs()).clamp(0.5, 1.0);
              double curveAmount = 400;
              double angle = relativeOffset * pi / 8;

              double translateX = sin(angle + index * 0.05) * curveAmount;
              double translateY = -cos(angle + index * 0.05) * curveAmount + curveAmount;
              double perspectiveAngle = angle / 5;

              Matrix4 perspective = Matrix4.identity()
                ..setEntry(1, 0, 0.15)
                ..translate(translateX, translateY)
                ..rotateY(perspectiveAngle);

              return Opacity(
                opacity: opacity,
                child: Transform(
                  alignment: Alignment.center,
                  transform: perspective,
                  child: Pic_Card(
            height: 800,
            imagePath: card.imagePath,
            imageAlignment: Alignment.center,
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
        )
                ),
              );
            },
            childCount: trendyList.length,
          ),
        ),
      ],
    ),
  );
}

}