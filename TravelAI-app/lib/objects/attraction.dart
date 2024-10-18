import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_travel_assistant/objects/city.dart';

enum AttractionType {
  siteAndLandmark('Site & Landmark', 1),
  museum('Museum', 2),
  pagodaAndChurch("Pagoda & Church", 3);

  const AttractionType(this.name, this.value);

  final String name;
  final int value;

  static getAttractionType(int val) {
    switch (val) {
      case 1:
        return AttractionType.siteAndLandmark;

      case 2:
        return AttractionType.museum;

      case 3:
        return AttractionType.pagodaAndChurch;

      default:
        return null;
    }
  }
}

class Attraction {
  String? id;
  String name;
  String description;
  String? picture;
  AttractionType type;
  String country;
  String city;

  static CollectionReference collection =
      FirebaseFirestore.instance.collection("attraction");

  Attraction.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name']! as String,
          description: json['description']! as String,
          type: AttractionType.getAttractionType(json['type']!),
          country: json['country'] as String,
          city: json['city']! as String,
        );

  Attraction(
      {this.id,
      required this.name,
      required this.description,
      this.picture,
      required this.type,
      required this.country,
      required this.city});

  FutureOr<bool> addAttractionToFirebase() async {
    String? id;
    bool isFailed = false;
    await collection.add({
      'name': name,
      'description': description,
      'type': type.value,
      'country': country,
      'city': city,
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

  static List<Attraction> getAttractionByLocation(City city) {
    String cityName = city.cityName;
    List<Attraction> ret = [];
    collection
        .where('city', isEqualTo: cityName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var attraction = Attraction(
            name: doc['name'],
            description: doc['description'],
            type: AttractionType.getAttractionType(doc['type']),
            country: doc['country'],
            city: doc['city']);

        ret.add(attraction);
      });
    });

    return ret;
  }
}
