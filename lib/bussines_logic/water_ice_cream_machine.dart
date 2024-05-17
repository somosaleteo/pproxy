import 'dart:math';

import '../domain/models/water_based_ice_cream.dart';

class WaterIceCreamMachine {
  WaterIceCreamMachine({
    required this.iceCreams,
  });
  final double productionCost = 1.0;
  final List<WaterBasedIceCream> iceCreams;

  Future<WaterBasedIceCream> produceIceCream() async {
    await Future.delayed(Duration(milliseconds: 100 + Random().nextInt(400)));
    return iceCreams[Random().nextInt(iceCreams.length)];
  }
}
