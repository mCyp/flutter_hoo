import 'package:flutter_hoo/db/shoe.dart';
import 'package:flutter_hoo/db/use.dart';

class FavShoe {
  final int id;
  final int userId;
  User user;
  final int shoeId;
  Shoe shoe;
  final int date;

  FavShoe(this.userId, this.shoeId, this.date, {this.id, this.user, this.shoe});

  factory FavShoe.fromJson(Map<String, dynamic> map) {
    return FavShoe(map['userId'], map['shoeId'], map['date'], id: map['id']);
  }

  factory FavShoe.fromJsonAndShoe(Map<String, dynamic> map) {
    Shoe shoe =
        Shoe(map['name'], null, map['price'], null, null, id: map['shoeId']);
    return FavShoe(map['userId'], map['shoeId'], map['date'], id: map['id'], shoe: shoe);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'userId': userId, 'shoeId': shoeId, 'date': date};
  }
}
