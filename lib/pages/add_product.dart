import 'package:flutter/material.dart';
import 'package:pks/components/products.dart';
import 'package:pks/pages/home_page.dart';
import 'package:pks/components/api_service.dart';

class AddItem extends StatefulWidget {
  final HomePageState homeState;
  final Product? editingProduct;

  const AddItem({Key? key, required this.homeState, this.editingProduct}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController fulldescriptionController;
  late TextEditingController imageURLController;
  late TextEditingController priceController;

  final ApiService apiService = ApiService();
  late bool isImageUrl;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.editingProduct?.Name ?? '');
    descriptionController = TextEditingController(text: widget.editingProduct?.Description ?? '');
    fulldescriptionController = TextEditingController(text: widget.editingProduct?.FullDescription ?? '');
    imageURLController = TextEditingController(text: widget.editingProduct?.img ?? '');
    priceController = TextEditingController(text: widget.editingProduct?.Price.toString() ?? '');
    isImageUrl = widget.editingProduct?.isImageUrl ?? true;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    fulldescriptionController.dispose();
    imageURLController.dispose();
    priceController.dispose();
    super.dispose();
  }

  // Функция для проверки корректности URL
  bool _isValidImageUrl(String url) {
    return Uri.parse(url).isAbsolute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingProduct != null ? "Редактировать товар" : "Создать товар"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Название"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: fulldescriptionController,
              decoration: InputDecoration(labelText: "Краткое описание"),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Описание"),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            SizedBox(height: 10),
            // Только поле для ввода URL картинки
            TextField(
              controller: imageURLController,
              decoration: InputDecoration(labelText: "URL картинки"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Цена"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
              child: Text(
                "Сохранить",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              onPressed: () async {
                // Проверка на корректность URL для изображения
                String imageUrl = imageURLController.text;

                if (!_isValidImageUrl(imageUrl)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Некорректный URL изображения"),
                  ));
                  return;
                }

                Product newItem = Product(
                  widget.editingProduct?.id ?? -1,
                  titleController.text,
                  descriptionController.text,
                  fulldescriptionController.text,
                  int.parse(priceController.text),
                  imageUrl,
                );
                newItem.isImageUrl = true; // Присваиваем, что изображение по URL

                if (widget.editingProduct == null) {
                  widget.homeState.addItem(newItem); // Добавляем новый товар
                } else {
                  // Обновление товара
                  try {
                    await apiService.updateProduct(widget.editingProduct!.id, newItem);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Товар обновлён")));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ошибка обновления товара")),
                    );
                  }
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
