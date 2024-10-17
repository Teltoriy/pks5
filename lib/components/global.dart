import 'package:pks/components/products.dart';
import 'package:pks/pages/favourite.dart';
class GlobalData {
  List<Product> productItem = [];
  List<Product> favItem = [];
  FavouriteState? favouriteState;
  int indexofFavItems(Product itemCheck)
  {
    for (int i=0; i<favItem.length ; i++){
      if (favItem[i].id==itemCheck.id)
        {
          return i;
        }
    }
    return -1;
  }
}