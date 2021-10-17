import 'package:data_collection/models/enumeration_model.dart';
import 'package:flutter/material.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class EnumerationCardWidget extends StatefulWidget {
  const EnumerationCardWidget({
    Key key,
    this.enumeration,
    this.index,
  }) : super(key: key);

  final EnumerationModel enumeration;
  final int index;

  @override
  State<EnumerationCardWidget> createState() => _EnumerationCardWidgetState();
}

class _EnumerationCardWidgetState extends State<EnumerationCardWidget> {
  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[widget.index % _lightColors.length];
    final minHeight = getMinHeight(widget.index);
    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              widget.enumeration.property_id ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  widget.enumeration.title ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.enumeration.firstname ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  widget.enumeration.lastname ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.enumeration.property_type ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.enumeration.lga ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.enumeration.phone_number ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// To return different height for different widgets
double getMinHeight(int index) {
  switch (index % 4) {
    case 0:
      return 100;
    case 1:
      return 150;
    case 2:
      return 150;
    case 3:
      return 100;
    default:
      return 100;
  }
}
