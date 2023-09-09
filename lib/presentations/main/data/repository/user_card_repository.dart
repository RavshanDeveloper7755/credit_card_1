
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/widgets/toast.dart';
import '../models/user_card.dart';

class UserCardsRepository{
  final FirebaseFirestore firestore;
  UserCardsRepository({required this.firestore});

  /// ------------------------- CREATE CONTACT -------------------------

  Future<void> addCard({required UserCard cardModel}) async {
    try {
      DocumentReference newCard =
      await firestore.collection("Cards").add(cardModel.toJson());
      await firestore
          .collection("Cards")
          .doc(newCard.id)
          .update({"cardId": newCard.id});
      getMyToast(message: 'Card muvaffaqiyatli saqlandi');
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  /// ------------------------- READ CONTACTS -------------------------

  Stream<List<UserCard>> getAllCards() => firestore
      .collection("Cards")
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((e) => UserCard.fromJson(e.data()))
      .toList());

  /// ------------------------- UPDATE CONTACT -------------------------

  Future<void> updateCard({required UserCard cardModel}) async {
    try {
      await firestore
          .collection("Cards")
          .doc(cardModel.cardId)
          .update(cardModel.toJson());
      getMyToast(message: "Card muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  /// ------------------------- DELETE CONTACT -------------------------

  Future<void> deleteCard({required String docId}) async {
    try {
      await firestore.collection("Cards").doc(docId).delete();
      getMyToast(message: "Card muvaffaqiyatli o'chirildi");
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }
}