import 'dart:convert';
import 'package:pks/pages/item_list.dart';
import 'package:pks/components/products.dart';
import 'package:pks/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/card_prew.dart';
bool isFavourite = true;
class Favourite extends StatefulWidget{
  const Favourite({super.key});
  @override
    createState()=> FavouriteState();
}
class FavouriteState extends State<Favourite>
{
  @override
  void initState(){
    super.initState();
    appData.favouriteState=this;
  }
  List<Product> favouriteItems = appData.favItem;
  void addItem(Product item) {
    setState(() {
      favouriteItems.add(item);
    });
  }
  void forceUpdateState()
  {
    if (mounted)
    {
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child:
        favouriteItems.isEmpty ? Center(child: Text("Тут пока ничего нет (⌐■_■)")) :
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.05/1),
          padding: const EdgeInsets.symmetric(vertical: 0),
          itemCount: favouriteItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: CardPreview(productItem: favouriteItems[index], isFavorite: true),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemView(productItem: favouriteItems[index]))
                );
              },
            );
          },
        ),
      ),
    );
  }
}