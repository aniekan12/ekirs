import 'package:data_collection/local_db/db_helper.dart';
import 'package:data_collection/views/propertydetails.dart';
import 'package:data_collection/widgets/enumeration_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class EnumerationPage extends StatefulWidget {
  const EnumerationPage({Key key}) : super(key: key);

  @override
  _EnumerationPageState createState() => _EnumerationPageState();
}

class _EnumerationPageState extends State<EnumerationPage> {
  List enumerations;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshEnumeration();
  }

  // @override
  // void dispose() {
  //   SqfliteDatabaseHelper.instance.close();
  //   super.dispose();
  // }

  Future refreshEnumeration() async {
    setState(() => isLoading = true);

    this.enumerations = await SqfliteDatabaseHelper.instance.fetchAllInfo();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : enumerations.isEmpty
                  ? Text(
                      'No Enumeration data to show',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildEnumeration(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PropertyDetails()),
            );

            refreshEnumeration();
          },
        ),
      );

  Widget buildEnumeration() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: enumerations.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final enumerationModel = enumerations[index];

          return GestureDetector(
            onTap: () async {
              // await Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => NoteDetailPage(noteId: enumer.id),
              // ));

              refreshEnumeration();
            },
            child: EnumerationCardWidget(
                enumeration: enumerationModel, index: index),
          );
        },
      );
}
