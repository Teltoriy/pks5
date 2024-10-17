import 'package:flutter/material.dart';
import 'package:pks/components/products.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pks/main.dart';
import 'package:pks/components/card_prew.dart';
import 'item_list.dart';
import 'package:pks/pages/add_product.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  createState() => HomePageState();
}
class HomePageState extends State<HomePage>{
  List<Product> productItem = appData.productItem;
  @override void initState(){
    super.initState();
    loadProductItem();
  }
  void addItem(Product item){
    setState(() {
      productItem.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.05/1),
          padding: const EdgeInsets.symmetric(vertical: 0),
          itemCount: productItem.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: CardPreview(productItem: productItem[index], isFavorite: appData.indexofFavItems(productItem[index]) != -1,),
              onTap: () {
                debugPrint('tapped ${productItem[index].Name}');
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemView(productItem: productItem[index]))
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Note',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddItem(homeState: this,)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> loadProductItem() async {
    String jsonString = await rootBundle.loadString('assets/products.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      productItem = jsonList.map((json) => Product.fromJson(json)).toList();
    });

  }}