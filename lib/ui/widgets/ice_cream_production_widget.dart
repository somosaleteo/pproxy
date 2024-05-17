import 'package:flutter/material.dart';

import '../../controllers/ice_cream_machine_proxy.dart';
import '../../domain/interfaces/ice_cream_model.dart';
import '../../domain/models/milk_based_ice_cream.dart';
import '../../domain/models/water_based_ice_cream.dart';
import '../widgets/helado_widget.dart';
import '../widgets/ice_cream_skeleton.dart';

class IceCreamProductionWidget extends StatefulWidget {
  const IceCreamProductionWidget({
    required this.proxy,
    super.key,
  });
  final IceCreamMachineProxy proxy;

  @override
  State<IceCreamProductionWidget> createState() =>
      _IceCreamProductionWidgetState();
}

class _IceCreamProductionWidgetState extends State<IceCreamProductionWidget> {
  final List<IceCreamModel> waterIceCreams = <IceCreamModel>[];
  final List<IceCreamModel> creamIceCreams = <IceCreamModel>[];
  double totalWaterCost = 0;
  double totalCreamCost = 0;

  Future<void> produceIceCream() async {
    if (!widget.proxy.accessPermitted) {
      await _showNotAuthorizedAlert();
      if (mounted) {
        Navigator.pop(context);
      }
      return;
    }
    setState(() {});
    try {
      final IceCreamModel iceCream = await widget.proxy.produceIceCream();
      setState(() {
        if (iceCream is WaterBasedIceCream) {
          waterIceCreams.add(iceCream);
          totalWaterCost += widget.proxy.waterMachine.productionCost;
        } else if (iceCream is MilkBasedIceCream) {
          creamIceCreams.add(iceCream);
          totalCreamCost += widget.proxy.creamMachine.productionCost;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      await _showNotAuthorizedAlert();
      if (mounted) {
        Navigator.pop(context);
      }
      return;
    }
  }

  Future<void> _showNotAuthorizedAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Autorizado'),
          content: const Text('No se le permite a este usuario hacer helados'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final int waterIceCreamsInProduction = widget.proxy.productionQueue
        .whereType<Future<WaterBasedIceCream>>()
        .length;
    final int creamIceCreamsInProduction = widget.proxy.productionQueue
        .whereType<Future<MilkBasedIceCream>>()
        .length;
    const int crossAxisCount = 12;
    const double spacing = 2.5;

    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.8,
          width: size.width,
          child: Column(
            children: <Widget>[
              const Text(
                'Water Ice Creams',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                  ),
                  itemCount: waterIceCreams.length + waterIceCreamsInProduction,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < waterIceCreams.length) {
                      return FittedBox(
                        fit: BoxFit.fitHeight,
                        child: HeladoWidget(iceCream: waterIceCreams[index]),
                      );
                    } else {
                      return const IceCreamSkeleton();
                    }
                  },
                ),
              ),
              Text(
                'Total Cost: \$${totalWaterCost.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 20),
              const Text(
                'Cream Ice Creams',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                  ),
                  itemCount: creamIceCreams.length + creamIceCreamsInProduction,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < creamIceCreams.length) {
                      return FittedBox(
                        fit: BoxFit.fitHeight,
                        child: HeladoWidget(iceCream: creamIceCreams[index]),
                      );
                    } else {
                      return const IceCreamSkeleton();
                    }
                  },
                ),
              ),
              Text(
                'Total Cost: \$${totalCreamCost.toStringAsFixed(2)}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: produceIceCream,
          child: const Text('Produce Ice Cream'),
        ),
      ],
    );
  }
}
