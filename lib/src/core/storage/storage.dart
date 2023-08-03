import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/groercery.dart';

class Storage {
  Future<void> addGroercery(Groercery groercery) async {
    try {
      final store = await SharedPreferences.getInstance();

      final result = store.getStringList('groerceries');

      if (result == null) {
        await store.setStringList('groerceries', [groercery.toJson()]);
      } else {
        final groerceries = result.map(Groercery.fromJson).toList();

        groerceries.add(groercery);

        await store.setStringList(
            'groerceries', groerceries.map((e) => e.toJson()).toList());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Groercery>> getGroerceries() async {
    try {
      final store = await SharedPreferences.getInstance();

      final result = store.getStringList('groerceries');

      if (result == null) return [];

      final groerceries = result.map(Groercery.fromJson).toList();

      return groerceries;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> updateGroercery(Groercery groercery) async {
    try {
      final store = await SharedPreferences.getInstance();

      final result = store.getStringList('groerceries');

      if (result == null) return;

      final groerceries = result.map(Groercery.fromJson).toList();

      final index = groerceries.indexWhere((e) => e.id == groercery.id);

      groerceries.removeAt(index);

      groerceries.insert(index, groercery);

      await store.setStringList(
          'groerceries', groerceries.map((e) => e.toJson()).toList());
    } catch (e) {
      log(e.toString());
    }
  }
}
