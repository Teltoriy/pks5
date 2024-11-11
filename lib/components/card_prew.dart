import 'package:flutter/material.dart';
import 'package:pks/components/products.dart';

import '../main.dart';

class CardPreview extends StatefulWidget {
  const CardPreview({
    Key? key,
    required this.productItem,
    required this.isFavorite,
    required this.onEdit,
  }) : super(key: key);

  final Product productItem;
  final bool isFavorite;
  final VoidCallback onEdit;

  @override
  _CardPreviewState createState() => _CardPreviewState();
}

class _CardPreviewState extends State<CardPreview> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: widget.productItem.isImageUrl
                    ? Image.network(
                  widget.productItem.img,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 4,
                  fit: BoxFit.fill,
                )
                    : Image.asset(
                  widget.productItem.img,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 4,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                widget.productItem.Name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Flexible(
                child: Text(
                  widget.productItem.Description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          // Иконка редактирования в левом верхнем углу
          Positioned(
            left: 8,
            top: 8,
            child: GestureDetector(
              onTap: () {
                debugPrint('Edit icon tapped for ${widget.productItem.Name}');
                widget.onEdit(); // Запускаем редактирование при нажатии
              },
              child: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
          ),
          // Иконка избранного в правом верхнем углу
          Positioned(
            right: 8,
            top: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  int indexInFav = appData.indexofFavItems(widget.productItem);
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    if (indexInFav == -1) {
                      appData.favItem.add(widget.productItem);
                    }
                  } else {
                    if (indexInFav != -1) {
                      appData.favItem.removeAt(indexInFav);
                      appData.favouriteState?.forceUpdateState();
                      isFavorite = !isFavorite;
                    }
                  }
                });
                debugPrint(
                    'Heart icon tapped for ${widget.productItem.Name}, favorite: $isFavorite');
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
