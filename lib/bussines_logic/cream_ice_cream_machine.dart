import 'dart:math';

import '../domain/models/milk_based_ice_cream.dart';

class CreamIceCreamMachine {
  CreamIceCreamMachine({required this.iceCreams});
  final double productionCost = 3.0;
  final List<MilkBasedIceCream> iceCreams;

  Future<MilkBasedIceCream> produceIceCream() async {
    await Future<void>.delayed(
      Duration(
        seconds: 1 + Random().nextInt(3),
      ),
    );
    return iceCreams[Random().nextInt(iceCreams.length)];
  }
}
