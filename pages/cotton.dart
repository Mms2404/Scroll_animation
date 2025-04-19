import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weaves/widgets/card.dart';
import 'package:weaves/widgets/models.dart';

class Cotton extends StatefulWidget {
  const Cotton({super.key});

  @override
  State<Cotton> createState() => _CottonState();
}

class _CottonState extends State<Cotton> {
  // Scroll controls
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

  Matrix4 _getTransform(double relativeOffset, int index) {
    double curveAmount = -100;
    double angle = relativeOffset * pi / 3;

    double translateX = sin(angle + index * 0.1) * curveAmount;
    double translateY = -cos(angle + index * 0.1) * curveAmount + curveAmount;

    
    double scale = (6 - relativeOffset.abs() * 0.2).clamp(0.5, 1.1);
    double depth = ( 1- relativeOffset.abs()) * 200;


    return Matrix4.identity()
      ..translate(translateX, translateY, depth)
      ..rotateY(angle / 2)
      ..scale(scale);
  }

  @override
  Widget build(BuildContext context) {

  final List<ItemCardModel> cottonList = [
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/c1/f3/fd/c1f3fd29b91aea1f604637f1dc8ba0f4.jpg',
    title: 'Kodampaakam Cotton',
    details: "Handwoven for comfort and elegance, they are perfect for both casual and festive occasions. Supporting local artisans, these sarees embody sustainable fashion and cultural pride."
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/ab/aa/58/abaa58fd5224f402f03fda7d66c3b3c2.jpg',
    title: 'Pure Cotton',
     details: "With a variety of vibrant colors and intricate patterns, they blend tradition with modern style. These sarees not only celebrate craftsmanship but also promote sustainable fashion by supporting local weavers."
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/4c/1a/9f/4c1a9f9a9c48554941de85408488bd25.jpg',
    title: 'Chettinad Cotton',
     details: " Often adorned with traditional patterns such as stripes and checks, along with unique temple borders, they reflect the rich cultural legacy of South India."
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/40/cd/e3/40cde3fcffde6aabbfde40b2a1e54eec.jpg',
    title: 'Kora Cotton',
     details: " Their versatility allows them to be styled for both casual and festive occasions, celebrating the beauty of traditional craftsmanship."
  ),
  ItemCardModel(
    imagePath: 'https://i.pinimg.com/736x/03/18/2a/03182aac05ba274276f7189706681392.jpg',
    title: 'Silk Cotton',
     details: "Their lightweight nature and graceful drape make them a popular choice for those seeking style without compromising comfort."
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
                "COTTON WEAVES",
                style: GoogleFonts.alegreyaSc(fontSize: 35),
              ),
            ),
            centerTitle: false,
          ),
          
          SliverList(
  delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {
      final card = cottonList[index];
      double spacing = 800.0; 
      double relativeOffset = (scrollPosition - index * spacing) / spacing;
      double opacity = (1.5 - relativeOffset.abs()).clamp(0.5, 1.0);

      return Opacity(
        opacity: opacity,
        child: Transform(
          alignment: Alignment.center,
          transform: _getTransform(relativeOffset, index),
          child: Pic_Card(
            height: 800,
            imagePath: card.imagePath,
            imageAlignment: Alignment.center,
            titleOverlay: Text(card.title, style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,), ),
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
        )
      );
    },
    childCount: cottonList.length
  ),
),

        ],
      ),
    );
  }
}