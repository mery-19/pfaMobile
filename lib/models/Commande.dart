class Commande {
  final int id;
  final double prix_total;
  final String date_ajout;
  final int id_status;
  final String date_update;
  
  Commande({this.id,
  this.prix_total,
  this.date_ajout,
  this.id_status,
  this.date_update,
});

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id:json['id'],
      prix_total:json['prix_total'],
      date_ajout:json['date_ajout'],
      id_status:json['id_status'],
      date_update:json['date_update'],
    );
  }
}