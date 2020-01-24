import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'products.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    // print(data.documentID);
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.categoryName),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.categoryName),
            // trailing: Text(record.phone.toString()),
            // onTap: () => record.reference.updateData({'phone': FieldValue.increment(1)})
            onTap: () {
              // print(data.data);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProductsPage(),
                  settings: RouteSettings(
                    arguments: data.documentID,
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class Record {
  final String categoryName;
  // final int phone;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['categoryName'] != null),
        // assert(map['phone'] != null),
        categoryName = map['categoryName'];
  // phone = map['phone'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  // String toString() => "Record<$firstName:$phone>";
  String toString() => "Record<$categoryName>";
}
