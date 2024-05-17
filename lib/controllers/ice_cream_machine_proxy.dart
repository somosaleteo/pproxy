import 'dart:async';
import 'dart:collection';

import '../bussines_logic/cream_ice_cream_machine.dart';
import '../bussines_logic/water_ice_cream_machine.dart';
import '../domain/interfaces/ice_cream_model.dart';
import '../domain/models/water_based_ice_cream.dart';

class IceCreamMachineProxy {
  IceCreamMachineProxy({
    required this.waterMachine,
    required this.creamMachine,
    required this.accessPermitted,
    this.maxQueueLength = 5,
  });
  final WaterIceCreamMachine waterMachine;
  final CreamIceCreamMachine creamMachine;
  final bool accessPermitted;
  final int maxQueueLength;
  final Queue<IceCreamModel> productionQueue = Queue<IceCreamModel>();

  Future<IceCreamModel> produceIceCream() async {
    if (productionQueue.length >= maxQueueLength) {
      if (accessPermitted) {
        final WaterBasedIceCream iceCream =
            await waterMachine.produceIceCream();
        productionQueue.add(iceCream);
        return iceCream;
      } else {
        throw Exception('Access Denied');
      }
    } else {
      final iceCream = await creamMachine.produceIceCream();
      productionQueue.add(iceCream);
      return iceCream;
    }
  }
}
