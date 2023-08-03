import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import '../core/storage/storage.dart';
import '../models/groercery.dart';

part './groercery_state.dart';

class GroerceryProvider extends ValueNotifier<GroerceryState> {
  final Storage _storage;

  GroerceryProvider(this._storage) : super(const GroerceryState());

  Future<void> getGroerceries() async {
    value = value.copyWith(status: Status.loading);

    final groerceries = await _storage.getGroerceries();

    value = value.copyWith(
      status: Status.loaded,
      groerceries: groerceries,
    );
  }

  Future<void> addGroercery(String name) async {
    value = value.copyWith(status: Status.loading);

    final groerceries = await _storage.getGroerceries();

    await _storage.addGroercery(Groercery(
      id: groerceries.length + 1,
      name: name,
      products: [],
    ));

    value = value.copyWith(
      status: Status.loaded,
      groerceries: await _storage.getGroerceries(),
    );
  }
}
