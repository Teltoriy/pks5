import 'package:flutter/material.dart';
import 'package:pks/components/products.dart';

import '../main.dart';

class ItemView extends StatefulWidget {
  final Product productItem;
  const ItemView({super.key, required this.productItem});
  @override
  createState() => ItemViewState();
}

class ItemViewState extends State<ItemView> {
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.productItem.Name)),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.6, right: 16.0, bottom: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.productItem.isImageUrl
                        ? Image.network(widget.productItem.img,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fill)
                        : Image.asset(widget.productItem.img,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fill),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(widget.productItem.FullDescription,
                    style: const TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 250,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appData.indexofCartItems(widget.productItem) != -1
                          ? const Color.fromARGB(255, 0, 64, 3)
                          : const Color.fromARGB(255, 0, 25, 64),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(10.0)),
                  child: Text(
                      appData.indexofCartItems(widget.productItem) != -1
                          ? "Добавлено в корзину - ${widget.productItem.Price} руб."
                          : "Добавить в корзину - ${widget.productItem.Price} руб.",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      addedToCart = !addedToCart;
                      int indexInCart = appData.indexofCartItems(widget.productItem);
                      if(addedToCart){
                        if (indexInCart==-1){
                          appData.cartItem.add(widget.productItem);
                        }
                      } else {
                        if (indexInCart !=-1){
                          appData.cartItem.removeAt(indexInCart);
                          appData.cartState?.forceUpdateState();
                        }
                      }
                    });
                  },
                ),
              ))
        ]));
  }
}