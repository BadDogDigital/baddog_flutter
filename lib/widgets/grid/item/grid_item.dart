import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.columnStart,
    required this.columnSpan,
    required this.rowStart,
    required this.rowSpan,
    required this.child,
  }) : super(key: key);

  final int columnStart;
  final int columnSpan;
  final int rowStart;
  final int rowSpan;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GridPlacement(
      columnStart: this.columnStart,
      columnSpan: this.columnSpan,
      rowStart: this.rowStart,
      rowSpan: this.rowSpan,
      child: child,
    );
  }
}
