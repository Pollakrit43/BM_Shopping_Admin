import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final bool isRecommended;
  final bool isPopular;
  int price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.isRecommended,
    required this.isPopular,
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      category,
      description,
      imageUrl,
      isRecommended,
      isPopular,
      price,
      quantity,
    ];
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    bool? isRecommended,
    bool? isPopular,
    int? price,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isRecommended: isRecommended ?? this.isRecommended,
      isPopular: isPopular ?? this.isPopular,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    return Product(
      id: snap['id'],
      name: snap['name'],
      category: snap['category'],
      description: snap['description'],
      imageUrl: snap['imageUrl'],
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
      price: snap['price'],
      quantity: snap['quantity'],
    );
  }
  String toJson() => json.encode(toMap());


  @override
  bool get stringify => true;

  static List<Product> products = [
    Product(
      id: '1',
      name: 'ปากกาดำ',
      category: 'Pen',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      imageUrl: 'https://pyxis.nymag.com/v1/imgs/736/b66/5c6cff297e5f12161776b7e7ead53502df-bic-4-color.2x.rsquare.w600.jpg',
      isRecommended: true,
      isPopular: true,
      price: 20,
      quantity: 0
    ),
     Product(
      id: '2',
      name: 'ปากกาดำ',
      category: 'Pen',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      imageUrl: 'https://pyxis.nymag.com/v1/imgs/736/b66/5c6cff297e5f12161776b7e7ead53502df-bic-4-color.2x.rsquare.w600.jpg',
      isRecommended: true,
      isPopular: true,
      price: 25,
      quantity: 0
    ),
     Product(
      id: '3',
      name: 'ปากกาดำ',
      category: 'Pen',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      imageUrl: 'https://pyxis.nymag.com/v1/imgs/736/b66/5c6cff297e5f12161776b7e7ead53502df-bic-4-color.2x.rsquare.w600.jpg',
      isRecommended: true,
      isPopular: true,
      price: 40,
      quantity: 0
    ),
     Product(
      id: '4',
      name: 'ปากกาดำ',
      category: 'Pen',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      imageUrl: 'https://pyxis.nymag.com/v1/imgs/736/b66/5c6cff297e5f12161776b7e7ead53502df-bic-4-color.2x.rsquare.w600.jpg',
      isRecommended: true,
      isPopular: true,
      price: 50,
      quantity: 0,
    ),
  ];
}
