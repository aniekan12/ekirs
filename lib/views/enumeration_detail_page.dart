import 'package:data_collection/models/enumeration_model.dart';
import 'package:flutter/material.dart';

class EnumerationDetailPage extends StatefulWidget {
  final int enumerationId;

  const EnumerationDetailPage({
    Key key,
    this.enumerationId,
  }) : super(key: key);

  @override
  _EnumerationDetailPageState createState() => _EnumerationDetailPageState();
}

class _EnumerationDetailPageState extends State<EnumerationDetailPage> {
  EnumerationModel enumeration;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
