import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weaves/pages/cotton.dart';
import 'package:weaves/pages/silk.dart';
import 'package:weaves/pages/trendy.dart';
import 'package:weaves/widgets/colorScheme.dart';
import 'package:weaves/widgets/models.dart';

void main() {
  runApp(const Weaves());
}

class Weaves extends StatefulWidget {
  const Weaves({super.key});

  @override
  State<Weaves> createState() => _WeavesState();
}

class _WeavesState extends State<Weaves> {
  late ScrollController _scrollController;
  double scrollPosition = 0;

  late AnimationController _animController;

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

  final List<MainCardModel> mainList = [
    MainCardModel(
      imagePath:
          'https://i.pinimg.com/1200x/84/26/ae/8426ae35130a6409b7cacfa6e3ebc4f0.jpg',
      title: 'COTTON WEAVES',
      quote: 'Simplicity never goes out of style ...',
      page: () => Cotton(),
    ),
    MainCardModel(
      imagePath:
          'https://i.pinimg.com/1200x/a6/2b/8f/a62b8f5a369410abc66868299a1e000a.jpg',
      title: 'SILK WEAVES',
      quote: 'When simplicity meets luxury ...',
      page: () => Silk(),
    ),
    MainCardModel(
      imagePath:
          'https://i.pinimg.com/1200x/06/19/da/0619daf473e941a0aa991ff14ab3e6d5.jpg',
      title: 'TRENDY WEAVES',
      quote: 'A dance of fabic that moves with you ...',
      page: () => Trendy(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: colorScheme),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: FadeIn(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                toolbarHeight: 200,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(left: 20, bottom: 40),
                  title: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Text(
                      "ELEGANT WEAVES",
                      style: GoogleFonts.alegreyaSc(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                expandedHeight: 60,
                toolbarHeight: 10,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 20, bottom: 10),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Drape yourself with the timeless elegance of sarees...",
                        style: GoogleFonts.lora(
                          fontSize: 15,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Icon(Icons.star_border_rounded , size: 20, color: Colors.white70,),
                       )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final card = mainList[index];
                    const double cardHeight = 900;
                    const double spacing = 900;
                    const double curveAmount = 50;

                    double relativeOffset =
                        (scrollPosition - index * spacing) / spacing;
                    double angle = relativeOffset * pi / 3;

                    double translateX = sin(angle) * curveAmount;
                    double translateY =
                        -cos(angle) * curveAmount + curveAmount;

                    double opacity =
                        (1.5 - relativeOffset.abs()).clamp(0.2, 1);

                    return Opacity(
                      opacity: opacity,
                      child: ZoomIn(
                        duration: const Duration(milliseconds: 500),
                        delay: Duration(
                            milliseconds: (relativeOffset.abs() * 200).toInt()),
                        child: FadeInUp(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..translate(translateX, translateY)
                              ..rotateZ(angle / 4),
                            child: Container(
                              height: cardHeight,
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 700,
                                      width: 1000,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(card.imagePath),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 20,
                                            offset: Offset(0, 8),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 120,
                                    right: 300,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Text(
                                        card.title,
                                        style: GoogleFonts.alegreyaSc(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 100,
                                    left: 80,
                                    right: 80,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(12),
                                     ),
                                     child: Pulse(
                                      duration: Duration(milliseconds: 8000),
                                      infinite: true,
                                      child: Text(
                                        card.quote,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.satisfy(
                                          fontSize: 24,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4,
                                              color: Colors.black87,
                                              offset: Offset(1, 1),
                                              )
                                              ],
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),

                                  Positioned(
                                    top: 400,
                                    left: 220,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.6),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.arrow_right_alt,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type:PageTransitionType.fade,
                                              childBuilder: (context) => card.page() ));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: mainList.length,
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void triggerAnimation() {
    _animController.forward(from: 0);
  }
}
