import 'package:manejo_suinos/shared/themes/images/app_images.dart';
import 'package:manejo_suinos/shared/utils/enums/breed_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/obtained_enum.dart';

import '../shared/entities/pig/pig_entity.dart';

class PigRepository {
  PigRepository();
  final List<PigEntity> _allPigs = [
    PigEntity(
      id: 1,
      name: 'Banquinha',
      age: 1,
      imageUrl: AppImages.pigs,
      breed: BreedEnum.DUROC,
      weight: 1.3,
      gender: GenderEnum.FEMALE,
      birthday: DateTime.now(),
      entryFarm: DateTime.now(),
      obtained: ObtainedEnum.BORN,
      motherID: 1,
      fatherID: 2,
    ),
    PigEntity(
      id: 1,
      name: 'Branquinha',
      age: 1,
      imageUrl: AppImages.pigs,
      breed: BreedEnum.DUROC,
      weight: 1.3,
      gender: GenderEnum.FEMALE,
      birthday: DateTime.now(),
      entryFarm: DateTime.now(),
      obtained: ObtainedEnum.BORN,
      motherID: 1,
      fatherID: 2,
    ),
    PigEntity(
      id: 1,
      name: 'Pretinho',
      age: 1,
      imageUrl: AppImages.pigs,
      breed: BreedEnum.DUROC,
      weight: 1.3,
      gender: GenderEnum.MALE,
      birthday: DateTime.now(),
      entryFarm: DateTime.now(),
      obtained: ObtainedEnum.PURCHASED,
      motherID: 1,
      fatherID: 2,
    ),
    PigEntity(
      id: 1,
      name: 'Pintado',
      age: 1,
      imageUrl: AppImages.pigs,
      breed: BreedEnum.PIETRAIN,
      weight: 1.3,
      gender: GenderEnum.MALE,
      birthday: DateTime.now(),
      entryFarm: DateTime.now(),
      obtained: ObtainedEnum.BORN,
      motherID: 1,
      fatherID: 2,
    ),
  ];

  List<PigEntity> get pigs => _allPigs;
}
