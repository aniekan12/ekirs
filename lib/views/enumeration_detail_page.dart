import 'package:data_collection/local_db/db_helper.dart';
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

  List<EnumerationModel> enumerations;
  @override
  void initState() {
    super.initState();
    refreshEnumeration();
  }

  @override
  void dispose() {
    SqfliteDatabaseHelper.instance.close();
    super.dispose();
  }

  Future refreshEnumeration() async {
    setState(() => isLoading = true);

    this.enumerations = await SqfliteDatabaseHelper.instance.fetchAllInfo();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      '' ?? enumeration.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Text(
                    //   DateFormat.yMMMd().format(note.createdTime),
                    //   style: TextStyle(color: Colors.white38),
                    // ),
                    SizedBox(height: 8),
                    Text(
                      '' ?? enumeration.firstname,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '' ?? enumeration.lastname,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    Text(
                      '' ?? enumeration.property_name,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        // await Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => AddEditNotePage(note: note),
        //     ));

        refreshEnumeration();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          //await SqfliteDatabaseHelper.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
