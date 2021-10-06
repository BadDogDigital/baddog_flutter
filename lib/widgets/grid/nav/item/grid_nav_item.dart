import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

//Hover/hold for basic info
//tap to go to

//The real question sems to be how do we have swipe functionality
//for individual Grid Items
//but ALSO swipe gestures to move on to the next gridItem
//Like FlickBoard we can animate individual jazz
//i.e. flick a youtube video away and onto the next one

//Select and interact this side
//but use an actual 'item' flick at the boundaries
//Fully transparent just a control

class GridNavItem extends StatelessWidget {
  GridNavItem({
    Key? key,
    this.color = Colors.red,
    required this.index,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final int index;
  final Function? onTap;

//Understand widts and heights and fills please
//I think a basic color with opacity
//Outlined and with an icon (article, media, twitter, etc) similar color & more opaque
//and the basicest of info
  @override
  Widget build(BuildContext context) {
    return Expanded(
      //Each needs to be a class widget
      //icon, id, selected - click for more info
      child: InkWell(
        //InkWell is gesture detector with stuff
        child: Container(
          color: this.color,
          child: Icon(Zocial.twitter),
          width: double.infinity,
        ),
        onTap: () => {
          //if(this.onTap != null)
          this.onTap!(this.index),
        },
      ),
    );
  }
}
