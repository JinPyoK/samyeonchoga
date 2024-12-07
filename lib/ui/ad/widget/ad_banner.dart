import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          children: [
            SizedBox(height: 100 * hu),
          ],
        ),
      ),
    );
  }
}
