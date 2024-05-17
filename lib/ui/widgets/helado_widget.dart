import 'package:flutter/material.dart';

import '../../domain/enums/ingredients_enum.dart';
import '../../domain/interfaces/ice_cream_model.dart';
import '../../domain/models/water_based_ice_cream.dart';

class HeladoWidget extends StatelessWidget {
  const HeladoWidget({
    required this.iceCream,
    super.key,
  });
  final IceCreamModel iceCream;

  @override
  Widget build(BuildContext context) {
    final bool isWaterBased = iceCream is WaterBasedIceCream;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isWaterBased ? Colors.lightBlue[100] : Colors.pink[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.icecream,
            size: 64,
            color: isWaterBased ? Colors.blue : Colors.pink,
          ),
          const SizedBox(height: 8),
          Text(
            iceCream.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isWaterBased ? Colors.blue : Colors.pink,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ingredients:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ...iceCream.ingredients.map((IngredientsEnum ingredient) => Text(
                ingredient.name,
                style: const TextStyle(fontSize: 14),
              )),
        ],
      ),
    );
  }
}
