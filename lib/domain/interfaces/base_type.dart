import '../enums/ingredients_enum.dart';

abstract class BaseType {
  const BaseType({
    required this.name,
    required this.ingredients,
  });

  final String name;
  final List<IngredientsEnum> ingredients;
}
