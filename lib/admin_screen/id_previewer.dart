import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kurdbid/public_packages.dart';

class IdPreview extends StatelessWidget {
  const IdPreview({super.key, required this.frontSide, required this.backSide});

  final String frontSide;
  final String backSide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black45,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.network(frontSide),
            ),
            Flexible(
              child: Image.network(
                backSide,
              ),
            )
          ],
        ),
      ),
    );
  }
}
