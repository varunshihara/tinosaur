import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tinosaur/pages/product.dart';

class ProductsPage extends StatefulWidget {
  // final String categorySlug;
  // ProductsPage({Key key, @required this.categorySlug}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String categorySlug = '';
  @override
  Widget build(BuildContext context) {
    this.categorySlug = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('/categories/' + this.categorySlug + '/products')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildGrid(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildGrid(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 10.0 / 15.2,
      // TODO: Build a grid of cards (102)
      children: snapshot.map((data) => _buildGridCards(context, data)).toList(),
    );
    // return ListView(
    //   padding: const EdgeInsets.only(top: 20.0),
    //   children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    // );
  }

  Widget _buildGridCards(BuildContext context, DocumentSnapshot data) {
    // List<Product> products = ProductsRepository.loadProducts(Category.all);
    final product = Record.fromSnapshot(data);

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'en-in');

    // return products.map((product) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // TODO: Adjust card heights (103)
      elevation: 0.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProductPage(),
                  settings: RouteSettings(
                    arguments: '{"productName": "'+product.name+'", "productImage": "'+product.images+'", "productPrice": "'+product.price.toString()+'"}',
                  ),
                ),
              );
        },
        child: Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 10 / 12,
              child: CachedNetworkImage(
                imageUrl: product.images,
                placeholder: (context, url) =>
                    Image.asset('assets/images/placeholder.png'),
                // TODO: Adjust the box size (102)
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(2.0, 12.0, 2.0, 8.0),
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // TODO: Change innermost Column (103)
                  children: <Widget>[
                    // TODO: Handle overflowing labels (103)

                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product == null ? '' : formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // }).toList();
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            // trailing: Text(record.phone.toString()),
            // onTap: () => record.reference.updateData({'phone': FieldValue.increment(1)})
            onTap: () => print(record)),
      ),
    );
  }
}

class Record {
  final String name;
  final int price;
  final String images;
  // final int phone;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['price'] != null),
        assert(map['images'] != null),
        name = map['name'],
        price = map['price'],
        images = map['images'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  // String toString() => "Record<$firstName:$phone>";
  String toString() => "Record<$name:$price:$images>";
}
