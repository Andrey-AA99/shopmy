import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/layouts/grid_layout.dart';
import 'package:shopmy/common/widgets/shimmers/shimmer.dart';

class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({super.key, this.itemCount = 2});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(mainAxisExtent: 80,itemCount: itemCount, itemBuilder: (_,__) => const TShimmerEffect(width: 300, height: 80));
  }
}
