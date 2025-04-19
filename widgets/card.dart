import 'package:flutter/material.dart';

class Pic_Card extends StatelessWidget {
  final double height;
  final String? imagePath;
  final Alignment imageAlignment;
  final Widget? titleOverlay;
  final Widget? detailsOverlay;

  const Pic_Card({
    required this.height,
    this.imagePath,
    this.imageAlignment = Alignment.center,
    this.titleOverlay,
    this.detailsOverlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (imagePath != null)
            Align(
              alignment: imageAlignment,
              child: Container(
                width: 1000,
                height: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 25,
                      spreadRadius: 2,
                      offset: Offset(5, 10),
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(imagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
              ),
            ),

         
          if (titleOverlay != null)
            Positioned(
              top: 180,
              right: 160,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                  child: titleOverlay!,
                ),
              ),
            ),

          if (detailsOverlay != null)
            Positioned(
              top: 250,
              right: 150,
              child: Container(
                height: 280,
                width: 800,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.5,
                  ),
                  child: detailsOverlay!,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
