import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String image;

  const Background({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          image: AssetImage("assets/images/$image"),
          fit: BoxFit.fill,
        ),
        if (image == "background-home.png")
          Image(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            image: const AssetImage("assets/images/star2.gif"),
            fit: BoxFit.fill,
          ),
        if (image == "background-home.png")
          Image(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            image: const AssetImage("assets/images/star.gif"),
            fit: BoxFit.fill,
          ),
      ],
    );
  }
}
