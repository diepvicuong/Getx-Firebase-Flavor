import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/app_setting.dart';

import 'logger.dart';

extension Validator on String {
  bool get isValidEmail => AppSetting.emailRegExp.hasMatch(this);
}

extension FirestoreDocumentExtension on DocumentReference {
  Future<DocumentSnapshot<Object?>> _getFromCacheFirst() async {
    try {
      DocumentSnapshot ds =
          await this.get(const GetOptions(source: Source.cache));
      if (ds.data() == null) {
        return await this.get(const GetOptions(source: Source.server));
      }

      // Get lastest data from server to update cache
      this.get(const GetOptions(source: Source.server));

      return ds;
    } catch (exc) {
      MyLogger.d(exc.toString());
    }
    return await this.get(const GetOptions(source: Source.server));
  }

  Future<Object?> getFirestore({bool fromCache = false}) async {
    try {
      if (fromCache) {
        return await this
            ._getFromCacheFirst()
            .timeout(const Duration(seconds: AppSetting.requestTimeout));
      } else {
        return await this
            .get()
            .timeout(const Duration(seconds: AppSetting.requestTimeout));
      }
    } on TimeoutException catch (e, s) {
      MyLogger.d(e.toString());
    } on FirebaseException catch (e, s) {
      MyLogger.d(e.toString());
    } on SocketException catch (e, s) {
      MyLogger.d(e.toString());
    } catch (e, s) {
      MyLogger.d(e.toString());
    }
    return null;
  }

  Future<void> updateFirestore(Map<String, Object> data) async {
    try {
      await this
          .update(data)
          .timeout(const Duration(seconds: AppSetting.requestTimeout));
    } on TimeoutException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } on FirebaseException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } on SocketException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    }
  }
}

extension FirestoreQueryExtension on Query {
  Future<QuerySnapshot> getFromCacheFirst() async {
    try {
      QuerySnapshot qs = await this.get(const GetOptions(source: Source.cache));
      if (qs.docs.isEmpty)
        return await this.get(const GetOptions(source: Source.server));

      // Get lastest data from server to update cache
      this.get(const GetOptions(source: Source.server));
      return qs;
    } catch (exc) {
      MyLogger.d('Exception: ' + exc.toString());
    }
    return await this.get(const GetOptions(source: Source.server));
  }

  Future<QuerySnapshot?> getFirestore(
      {DocumentSnapshot? startAfter, bool fromCache = false}) async {
    try {
      if (fromCache) {
        if (startAfter == null) {
          return await this
              .getFromCacheFirst()
              .timeout(const Duration(seconds: AppSetting.requestTimeout));
        } else {
          return await this
              .startAfterDocument(startAfter)
              .getFromCacheFirst()
              .timeout(const Duration(seconds: AppSetting.requestTimeout));
        }
      } else {
        if (startAfter == null) {
          return await this
              .get()
              .timeout(const Duration(seconds: AppSetting.requestTimeout));
        } else {
          return await this
              .startAfterDocument(startAfter)
              .get()
              .timeout(const Duration(seconds: AppSetting.requestTimeout));
        }
      }
    } on TimeoutException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } on FirebaseException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } on SocketException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    }
    return null;
  }
}

extension FirestoreBatchExtension on WriteBatch {
  Future<void> commitFirestore() async {
    try {
      await this
          .commit()
          .timeout(const Duration(seconds: AppSetting.requestTimeout));
    } on TimeoutException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } on FirebaseException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } on SocketException catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    } catch (e, s) {
      MyLogger.d('Exception: ' + e.toString());
    }
  }
}
