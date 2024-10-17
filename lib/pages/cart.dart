import 'package:flutter/material.dart';
import 'package:pks/components/products.dart';
import 'package:pks/main.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  createState() => CartState();
}

class CartState extends State<Cart> {
  Map<Product, int> cartItems = {};

  @override
  void initState() {
    super.initState();
    appData.cartState = this;

    for (var item in appData.cartItem) {
      cartItems[item] = 1;
    }
  }

  int getTotalSum() {
    int sum = 0;
    cartItems.forEach((product, quantity) {
      sum += product.Price * quantity;
    });
    return sum;
  }

  void forceUpdateState() {
    if (mounted) {
      setState(() {});
    }
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      cartItems.remove(product);
    } else {
      cartItems[product] = quantity;
    }
    forceUpdateState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Корзина"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {},
              child: Text(
                "Оплатить",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: cartItems.isEmpty
            ? Center(child: Text("Тут пока ничего нет (⌐■_■)"))
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  Product product = cartItems.keys.elementAt(index);
                  return CartItemWidget(
                    productItem: product,
                    quantity: cartItems[product]!,
                    onRemove: () {
                      setState(() {
                        int indexInCart = appData.indexofCartItems(product);
                        if (indexInCart != -1) {
                          appData.cartItem.removeAt(indexInCart);
                        }
                        cartItems.remove(product);
                      });
                    },
                    onUpdate: (newQuantity) {
                      updateQuantity(product, newQuantity);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Общая сумма: ${getTotalSum()} руб.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Product productItem;
  final int quantity;
  final Function() onRemove;
  final Function(int) onUpdate;

  const CartItemWidget({
    super.key,
    required this.productItem,
    required this.quantity,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: productItem.isImageUrl
                  ? Image.network(
                productItem.img,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                productItem.img,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productItem.Name, style: TextStyle(fontSize: 18)),
                  Text("${productItem.Price} руб."),
                  Text("Количество: $quantity"),
                  Text("Итого: ${productItem.Price * quantity} руб."),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    onUpdate(quantity + 1);
                  },
                ),
                Text(quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      onUpdate(quantity - 1);
                    } else {
                      onRemove();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
