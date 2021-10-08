import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PromotionData {
  String promokey;
  PromotionData(this.promokey);

  Query<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('promotions');

  late int promotion;
  int calculatePromotion(String promocode) {
    return promotion;
  }
}
