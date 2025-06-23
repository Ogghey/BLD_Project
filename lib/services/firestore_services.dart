import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addSchedule(DateTime date, String title, String time) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('schedules').add({
      'userId': user.uid,
      'date': date,
      'title': title,
      'time': time,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSchedules(DateTime date) {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _db.collection('schedules')
        .where('userId', isEqualTo: user.uid)
        .where('date', isEqualTo: date)
        .orderBy('time')
        .snapshots();
  }

  Future<void> deleteSchedule(String scheduleId) async {
    await _db.collection('schedules').doc(scheduleId).delete();
  }
}