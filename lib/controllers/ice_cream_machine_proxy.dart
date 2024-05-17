import 'dart:async';
import 'dart:collection';

import '../bussines_logic/cream_ice_cream_machine.dart';
import '../bussines_logic/water_ice_cream_machine.dart';
import '../domain/interfaces/ice_cream_model.dart';

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
  final Queue<Future<IceCreamModel>> productionQueue =
      Queue<Future<IceCreamModel>>();

  Future<IceCreamModel> produceIceCream() async {
    if (!accessPermitted) {
      throw Exception('Access Denied');
    }

    Future<IceCreamModel> iceCreamFuture;
    if (productionQueue.length >= maxQueueLength) {
      iceCreamFuture = waterMachine.produceIceCream();
    } else {
      iceCreamFuture = creamMachine.produceIceCream();
    }
    productionQueue.add(iceCreamFuture);
    final IceCreamModel iceCream = await iceCreamFuture;
    productionQueue.remove(iceCreamFuture);
    return iceCream;
  }
}
