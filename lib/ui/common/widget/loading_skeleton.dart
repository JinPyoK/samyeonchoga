import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(itemCount, (_) => const _RenderBone()),
      ),
    );
  }
}

class _RenderBone extends StatelessWidget {
  const _RenderBone();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.black12,
          highlightColor: whiteColor,
        ),
        ignoreContainers: true,
        enabled: true,
        child: Card(
          child: ListTile(
            title: Bone.text(width: 80),
            subtitle: Bone.text(width: 180),
            leading: Bone.icon(size: 64),
          ),
        ),
      ),
    );
  }
}
