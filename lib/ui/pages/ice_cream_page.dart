import 'package:flutter/material.dart';

import '../../bussines_logic/cream_ice_cream_machine.dart';
import '../../bussines_logic/water_ice_cream_machine.dart';
import '../../controllers/ice_cream_machine_proxy.dart';
import '../../domain/interfaces/ice_cream_model.dart';
import '../../domain/models/milk_based_ice_cream.dart';
import '../../domain/models/water_based_ice_cream.dart';
import '../widgets/helado_widget.dart';

class IceCreamPage extends StatefulWidget {
  const IceCreamPage({super.key});

  @override
  State<IceCreamPage> createState() => _IceCreamPageState();
}

class _IceCreamPageState extends State<IceCreamPage> {
  final WaterIceCreamMachine waterMachine = WaterIceCreamMachine(
    iceCreams: <WaterBasedIceCream>[
      const WaterBasedIceCream('Strawberry Ice'),
      const WaterBasedIceCream('Lemon Ice'),
    ],
  );

  final CreamIceCreamMachine creamMachine = CreamIceCreamMachine(
    iceCreams: <MilkBasedIceCream>[
      const MilkBasedIceCream(name: 'Vanilla Cream'),
      const MilkBasedIceCream(name: 'Chocolate Cream'),
    ],
  );

  late IceCreamMachineProxy proxy;
  final List<IceCreamModel> waterIceCreams = <IceCreamModel>[];
  final List<IceCreamModel> creamIceCreams = <IceCreamModel>[];
  double totalWaterCost = 0;
  double totalCreamCost = 0;

  @override
  void initState() {
    super.initState();
    proxy = IceCreamMachineProxy(
      waterMachine: waterMachine,
      creamMachine: creamMachine,
      accessPermitted: true,
    );
  }

  Future<void> produceIceCream() async {
    try {
      final iceCream = await proxy.produceIceCream();
      setState(() {
        if (iceCream is WaterBasedIceCream) {
          waterIceCreams.add(iceCream);
          totalWaterCost += waterMachine.productionCost;
        } else if (iceCream is MilkBasedIceCream) {
          creamIceCreams.add(iceCream);
          totalCreamCost += creamMachine.productionCost;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helado App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Water Ice Creams',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...waterIceCreams.map(
                        (IceCreamModel iceCream) =>
                            HeladoWidget(iceCream: iceCream),
                      ),
                      Text(
                        'Total Cost: \$${totalWaterCost.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Cream Ice Creams',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...creamIceCreams
                          .map((iceCream) => HeladoWidget(iceCream: iceCream))
                          .toList(),
                      Text(
                          'Total Cost: \$${totalCreamCost.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: produceIceCream,
              child: const Text('Produce Ice Cream'),
            ),
          ],
        ),
      ),
    );
  }
}
