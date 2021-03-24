
class Product
{
  final int id;
  final String name;
  final String description;
  final String image;
  final double prix_vente;
  final int tva;
  final int id_promotion;
  final int qty;

  double prix_promo;

  Product({
    this.id,
    this.name,
    this.description,
    this.prix_vente,
    this.image,
    this.tva,
    this.id_promotion,
    this.qty

  });
   
  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      id:json['id'],
      name: json['name'],
      description:json['description'],
      prix_vente: json['prix_vente'],
      image: json['image'],
      tva: json['tva'],
      id_promotion: json['id_promotion'],
      qty: json['quantite_stock'],

    );
  }

}