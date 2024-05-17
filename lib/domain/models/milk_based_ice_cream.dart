import '../enums/ingredients_enum.dart';
import '../interfaces/ice_cream_model.dart';

class MilkBasedIceCream extends IceCreamModel {
  const MilkBasedIceCream({
    required super.name,
    super.ingredients = const <IngredientsEnum>[
      IngredientsEnum.milk,
      IngredientsEnum.fruit,
      IngredientsEnum.sugar,
    ],
  });
}
