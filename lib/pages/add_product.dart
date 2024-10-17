import 'package:flutter/material.dart';
import 'package:pks/components/products.dart';
import 'package:pks/pages/home_page.dart';

class AddItem extends StatelessWidget {
  AddItem({super.key, required this.homeState});
  final HomePageState homeState;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController fulldescriptionController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Товар"),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Название",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: fulldescriptionController,
                decoration: InputDecoration(
                  labelText: "Краткое описание",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Описание",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: imageURLController,
                decoration: InputDecoration(
                  labelText: "URL картинки",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Цена",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0, bottom: 10.0)),
                child: Text("Сохранить",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                onPressed: () {
                  Product newItem = Product(
                      -1,
                      titleController.text,
                      descriptionController.text,
                      fulldescriptionController.text,
                      int.parse(priceController.text),
                      imageURLController.text,
                      );
                  newItem.isImageUrl = true;
                  homeState.addItem(newItem);
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }
}