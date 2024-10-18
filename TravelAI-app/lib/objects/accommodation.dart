import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum AccommodationType {
  hotel('Hotels', 1),
  homestay('Homestay', 2);

  const AccommodationType(this.name, this.value);

  final String name;
  final int value;

  static getAttractionType(int val) {
    switch (val) {
      case 1:
        return AccommodationType.hotel;

      case 2:
        return AccommodationType.homestay;

      default:
        return null;
    }
  }
}

class Accommodation {
  String? id;
  String name;
  String description;
  String? picture;
  AccommodationType type;
  double price;
  String country;
  String city;

  static CollectionReference collection =
      FirebaseFirestore.instance.collection("accommodation");

  Accommodation.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name']! as String,
          description: json['description']! as String,
          type: AccommodationType.getAttractionType(json['type']!),
          country: json['country'] as String,
          city: json['city']! as String,
          price: json['price']!,
        );

  Accommodation(
      {this.id,
      required this.name,
      required this.description,
      this.picture,
      required this.type,
      required this.country,
      required this.city,
      required this.price});

  FutureOr<bool> addAttractionToFirebase() async {
    String? id;
    bool isFailed = false;
    await collection.add({
      'name': name,
      'description': description,
      'type': type.value,
      'country': country,
      'city': city,
      'price': price,
    }).then((DocumentReference doc) {
      debugPrint("add successfully, id: ${doc.id}");
      id = doc.id;
    }).catchError((error) {
      debugPrint("add fail: $error");
      isFailed = true;
    });

    if (isFailed) {
      return false;
    }
    await collection
        .doc(id)
        .update({'id': id})
        .then((value) => debugPrint("update id successfully"))
        .catchError((error) {
          debugPrint("failed to update attraction: $error");
          isFailed = true;
        });
    return !isFailed;
  }
}
