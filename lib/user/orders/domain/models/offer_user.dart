  class OfferUser {
    final int id;
    final String name;
    final String? image;
    final double? avgRating;
    final String? profession;

    OfferUser({
      required this.id,
      required this.name,
      this.image,
      this.avgRating,
      this.profession,
    });

    factory OfferUser.fromJson(Map<String, dynamic> json) {
      return OfferUser(
        id: json['id'] as int,
        name: json['name'] as String,
        image: json['image'] as String?,
        avgRating: (json['avg_rating'] as num?)?.toDouble(),
        profession: json['profession'] as String?,
      );
    }
  }
