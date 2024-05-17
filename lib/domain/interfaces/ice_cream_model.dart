import '../enums/ingredients_enum.dart';

abstract class IceCreamModel {
  const IceCreamModel({
    required this.name,
    required this.ingredients,
  });
  final String name;
  final List<IngredientsEnum> ingredients;
}
