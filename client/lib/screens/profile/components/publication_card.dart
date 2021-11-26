import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/publication/publication_screen.dart';

class PublicationCard extends StatelessWidget {
  final double imageWidth;
  final int id;
  final String link;

  const PublicationCard({Key? key, required this.imageWidth, required this.id, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: const EdgeInsets.all(0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      height: 0,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PublicationScreen(id),
            ),
          );
        },
        child: SizedBox(
          width: imageWidth,
          height: imageWidth,
          child: Image.network(
            link,
            width: imageWidth,
            height: imageWidth,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
