class LignePanier {
  final int id;
  final String name;
  final String image;
  final int quantite;
  final int quantite_disponible;
  double prix;
  
  
  LignePanier({this.id,
  this.name,
  this.image,
  this.quantite,
  this.quantite_disponible,
  this.prix,
});

  factory LignePanier.fromJson(Map<String, dynamic> json) {
    return LignePanier(
      id:json['id'],
      name:json['name'],
      image:json['image'],
      quantite:json['quantite'],
      quantite_disponible:json['quantite_disponible'],
      prix:json['prix'],
    );
  }

  static void afficher(LignePanier ligne){
    print("id: "+ligne.id.toString());
    print("name: "+ligne.name);
    print("image: "+ligne.image);
    print("quantite: "+ligne.quantite.toString());
    print("quantite_disponible: "+ligne.quantite_disponible.toString());
    print("prix: "+ligne.prix.toString());
  }
}
