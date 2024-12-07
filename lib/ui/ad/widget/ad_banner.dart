import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10 * hu),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          children: [
            SizedBox(height: 80 * hu),
          ],
        ),
      ),
    );
  }
}
