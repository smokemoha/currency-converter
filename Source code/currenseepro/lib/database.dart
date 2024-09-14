import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseMethods {
  Future<void> addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection('usersCart')
        .doc(id)
        .collection("Books")
        .add(userInfoMap);
  }

  // Method to add a new transaction to the database
  Future<void> addTransaction(Map<String, dynamic> transactionData) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Use the user's UID as the document ID
      String userId = user.uid;
      await FirebaseFirestore.instance
          .collection('transactions')
          .doc(userId)
          .collection('history')
          .add(transactionData);
    } else {
      // Handle the case where the user is not logged in
      throw Exception('User not logged in');
    }
  }

  // Method to fetch transaction history for the current user
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserTransactionHistory() {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Use the user's UID to fetch transaction history
      String userId = user.uid;
      return FirebaseFirestore.instance
          .collection('transactions')
          .doc(userId)
          .collection('history')
          .orderBy('timestamp', descending: true) // Assuming 'timestamp' field is used to store date
          .snapshots();
    } else {
      // If the user is not logged in, return an empty stream
      return Stream.empty();
    }
  }
  
} 