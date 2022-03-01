import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: 400,
        child: GridView.builder(
        itemBuilder: (context,i){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ShimmerHelper().buildBasicShimmer(
                height: 200.0,
                width: (MediaQuery.of(context).size.width - 32) / 3),
          );
        },
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
            childAspectRatio: 3/2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
          ),
        ),
      ),
    );
  }
}
