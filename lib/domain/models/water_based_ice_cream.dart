import '../enums/ingredients_enum.dart';
import '../interfaces/ice_cream_model.dart';

class WaterBasedIceCream implements IceCreamModel {
  const WaterBasedIceCream(this.name);
  factory WaterBasedIceCream.fromJson(Map<String, dynamic> json) {
    return WaterBasedIceCream(json['name']?.toString() ?? 'water icecream');
  }
  @override
  final String name;
  @override
  List<IngredientsEnum> get ingredients => <IngredientsEnum>[
        IngredientsEnum.water,
        IngredientsEnum.fruit,
        IngredientsEnum.sugar,
      ];
  Map<String, dynamic> toJson() {
    final List<String> tmpIngredients = <String>[];
    for (final IngredientsEnum ingredient in ingredients) {
      tmpIngredients.add(ingredient.name);
    }
    return <String, dynamic>{
      'name': name,
      'ingredients': tmpIngredients,
    };
  }
}
