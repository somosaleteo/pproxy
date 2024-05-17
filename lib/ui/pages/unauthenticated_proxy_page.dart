import 'package:flutter/material.dart';

import '../../bussines_logic/cream_ice_cream_machine.dart';
import '../../bussines_logic/water_ice_cream_machine.dart';
import '../../controllers/ice_cream_machine_proxy.dart';
import '../../domain/models/milk_based_ice_cream.dart';
import '../../domain/models/water_based_ice_cream.dart';
import '../widgets/ice_cream_production_widget.dart';

class UnauthenticatedProxyPage extends StatefulWidget {
  const UnauthenticatedProxyPage({super.key});

  @override
  State<UnauthenticatedProxyPage> createState() =>
      _UnauthenticatedProxyPageState();
}

class _UnauthenticatedProxyPageState extends State<UnauthenticatedProxyPage> {
  late IceCreamMachineProxy proxy;

  @override
  void initState() {
    super.initState();
    proxy = _createProxy(accessPermitted: false);
  }

  IceCreamMachineProxy _createProxy({required bool accessPermitted}) {
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

    return IceCreamMachineProxy(
      waterMachine: waterMachine,
      creamMachine: creamMachine,
      accessPermitted: accessPermitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helado No Autenticado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IceCreamProductionWidget(proxy: proxy),
      ),
    );
  }
}
