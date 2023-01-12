import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    try {
      final reference = _firebaseFirestore.doc(path);
      await reference.set(body);
    } on FirebaseException catch (e) {
      print("[FirestoreService] setData ${e.message}");
    }
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    final snapshots = _firebaseFirestore.collection(path);

    return snapshots.get().then(
        (value) => value.docs.map((e) => builder(e.data(), e.id)).toList());
  }

  Future<T?> getDocument<T>({
    required String collectionPath,
    required String id,
    required T? Function(Map<String, dynamic>? data, String documentId) builder,
  }) async {
    var collection = _firebaseFirestore.collection(collectionPath);
    var document = await collection.doc(id).get();

    //final data = await _firebaseFirestore.collection(path).doc().get();
    return builder(document.data(), document.id);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _firebaseFirestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final snapshots = query.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) {
            return builder(
                snapshot.data() as Map<String, dynamic>, snapshot.id);
          })
          .where((value) => value != null)
          .toList();

      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentId),
  }) {
    final reference = _firebaseFirestore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
        (event) => builder(event.data() as Map<String, dynamic>, event.id));
  }
}
