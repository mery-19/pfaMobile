class Promotion {
  final int id;
  final String libele;
  final double taux_promotion;
  final String date_expire;
  
  Promotion({this.id,
  this.libele,
  this.taux_promotion,
  this.date_expire,
});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id:json['id'],
      libele:json['libele'],
      taux_promotion:json['taux_promotion'],
      date_expire:json['date_expiration'],
    );
  }
}
