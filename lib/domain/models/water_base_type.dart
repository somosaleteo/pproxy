import '../enums/ingredients_enum.dart';
import '../interfaces/base_type.dart';

class WaterBaseType implements BaseType {
  @override
  List<IngredientsEnum> get ingredients => <IngredientsEnum>[
        IngredientsEnum.water,
        IngredientsEnum.fruit,
        IngredientsEnum.sugar,
      ];

  @override
  String get name => 'water base';
}
