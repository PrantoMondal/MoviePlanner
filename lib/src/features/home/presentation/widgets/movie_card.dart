import 'package:flutter/material.dart';
import 'package:movie_planner/src/core/base/base_widget_mixin.dart';

class MovieCard extends StatelessWidget with BaseWidgetMixin {

  final Function onTap;

  MovieCard({super.key, required this.onTap});

  @override
  Widget body(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap;
      },
      child: Container(

        // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
        )
      )
    );
  }
}