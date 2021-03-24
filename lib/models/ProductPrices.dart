
import 'package:pfaMobile/models/Product.dart';
import 'package:pfaMobile/services/PromotionService.dart';

class ProductPrices
{
  double prix_vente;
  double prix_promotion = 0;

  ProductPrices(Product product){
    prix_vente = product.prix_vente;
    // if(product.id_promotion != null){
    //   PromotionService.fetchById(product.id_promotion).then((value){
    //     print("enter");
    //     print(value.date_expire);
    //     print(value.libele);
    //     if(DateTime.parse(value.date_expire).isAfter(DateTime.now())){
    //       prix_promotion = prix_vente - prix_vente*value.taux_promotion/100;
    //       print(prix_promotion);
    //     }
    //   });
    // }
  }


}