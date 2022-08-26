import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';

import 'package:manejo_suinos/shared/utils/enums/finality_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/obtained_enum.dart';

import '../../modules/model/entities/event/event_entity.dart';
import '../../modules/model/entities/heighing/weighing_entity.dart';
import '../../modules/model/entities/pig/pig_entity.dart';
import '../event_repository/event_repository.dart';
import '../weighing_repository/weighing_repository.dart';

class CreateDbInitial {
  CreateDbInitial();
  List<PigEntity> listPigEntity = [
    PigEntity(
      name: 'Tom',
      age: 300,
      weight: 150.0,
      gpd: 1,
      gender: Gender.MALE.value,
      finality: Finality.BREEDER.value,
      obtained: Obtained.PURCHASED.value,
      motherName: "Indefinido",
      fatherName: "Indefinido",
      buyValue: 1000,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Daffy',
      age: 300,
      weight: 150.0,
      gpd: 1,
      gender: Gender.FEMALE.value,
      finality: Finality.MATRIX.value,
      obtained: Obtained.PURCHASED.value,
      motherName: "Indefinido",
      fatherName: "Indefinido",
      buyValue: 1000,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Bugs',
      age: 150,
      weight: 100.0,
      gpd: 1,
      gender: Gender.MALE.value,
      finality: Finality.BREEDER.value,
      obtained: Obtained.BORN.value,
      motherName: "Daffy",
      fatherName: "Tom",
      buyValue: 0,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Raffy',
      age: 150,
      weight: 100.0,
      gpd: 1,
      gender: Gender.FEMALE.value,
      finality: Finality.MATRIX.value,
      obtained: Obtained.BORN.value,
      motherName: "Daffy",
      fatherName: "Tom",
      buyValue: 0,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Rex',
      age: 1,
      weight: 1.5,
      gpd: 1,
      gender: Gender.MALE.value,
      finality: Finality.FATTEN.value,
      obtained: Obtained.BORN.value,
      motherName: "Raffy",
      fatherName: "Bugs",
      buyValue: 0,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Ginger',
      age: 1,
      weight: 1.5,
      gpd: 1,
      gender: Gender.FEMALE.value,
      finality: Finality.FATTEN.value,
      obtained: Obtained.BORN.value,
      motherName: "Raffy",
      fatherName: "Bugs",
      buyValue: 0,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Ellie',
      age: 1,
      weight: 1.2,
      gpd: 1,
      gender: Gender.FEMALE.value,
      finality: Finality.FATTEN.value,
      obtained: Obtained.BORN.value,
      motherName: "Daffy",
      fatherName: "Tom",
      buyValue: 0,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Elfie',
      age: 1,
      weight: 1.1,
      gpd: 1,
      gender: Gender.MALE.value,
      finality: Finality.FATTEN.value,
      obtained: Obtained.BORN.value,
      motherName: "Daffy",
      fatherName: "Tom",
      buyValue: 0,
      sellValue: 0,
    ),
    PigEntity(
      name: 'Bella',
      age: 1,
      weight: 1.6,
      gpd: 1,
      gender: Gender.FEMALE.value,
      finality: Finality.FATTEN.value,
      obtained: Obtained.BORN.value,
      motherName: "Raffy",
      fatherName: "Bugs",
      buyValue: 0,
      sellValue: 0,
    ),
  ];

  List<WeighingEntity> listWeighing = [
    WeighingEntity(
        name: "Tom", date: "13/08/2022", weight: 150, age: 300, gpd: 1),
    WeighingEntity(
        name: "Daffy", date: "13/08/2022", weight: 150, age: 300, gpd: 1),
    WeighingEntity(
        name: "Bugs", date: "13/08/2022", weight: 100, age: 150, gpd: 1),
    WeighingEntity(
        name: "Raffy", date: "13/08/2022", weight: 100, age: 150, gpd: 1),
    WeighingEntity(
        name: "Rex", date: "13/08/2022", weight: 1.5, age: 1, gpd: 1),
    WeighingEntity(
        name: "Ginger", date: "13/08/2022", weight: 1.5, age: 1, gpd: 1),
    WeighingEntity(
        name: "Ellie", date: "13/08/2022", weight: 1.2, age: 1, gpd: 1),
    WeighingEntity(
        name: "Elfie", date: "13/08/2022", weight: 1.1, age: 1, gpd: 1),
    WeighingEntity(
        name: "Bella", date: "13/08/2022", weight: 1.6, age: 1, gpd: 1),
  ];

  // List<EventEntity> listEvents = [
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 1)),
  //     pigName: "Tom",
  //   ),
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 2)),
  //     pigName: "Daffy",
  //   ),
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 3)),
  //     pigName: "Bugs",
  //   ),
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 4)),
  //     pigName: "Raffy",
  //   ),
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 5)),
  //     pigName: "Ginger",
  //   ),
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 6)),
  //     pigName: "Ellie",
  //   ),
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 7)),
  //     pigName: "Elfie",
  //   ),
  //   EventEntity(
  //     title: "Pesar o suino",
  //     description: "Dia de fazer pesagem",
  //     date: DateTime.now().add(Duration(days: 8)),
  //     pigName: "Bella",
  //   ),
  //   EventEntity(
  //     title: "Trocar de baia",
  //     description: "Trocar de baia para limpeza",
  //     date: DateTime.now(),
  //     pigName: "Tom",
  //   ),
  //   EventEntity(
  //     title: "Trocar de baia",
  //     description: "Trocar de baia para limpeza",
  //     date: DateTime.now(),
  //     pigName: "Daffy",
  //   ),
  // ];

  createInitialData() {
    for (var pig in listPigEntity) {
      PigRepository.instance.addPig(pig);
    }

    for (var weighing in listWeighing) {
      WeighingRepository.instance.addWeighing(weighing);
    }
  }
}
