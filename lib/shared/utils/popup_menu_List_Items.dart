import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/utils/enums/breed_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/obtained_enum.dart';

class PopupMenuListItems {
  static const _breedMenuItems = <String>[
    Breed.DUROC,
    Breed.PIETRAIN,
    Breed.LANDRACE,
    Breed.LARGE_WHITE
  ];

  static const _genderMenuItems = <String>[
    Gender.FEMALE,
    Gender.MALE,
  ];
  static const _obtainedMenuItems = <String>[Obtained.BORN, Obtained.PURCHASED];

  static const _pigmenuItems = <String>['remover'];

  final List<PopupMenuItem<String>> _popupPigMenuItems = _pigmenuItems
      .map((String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  final List<PopupMenuItem<String>> _popupBreedMenuItems = _breedMenuItems
      .map((String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  final List<PopupMenuItem<String>> _popupGenderMenuItems = _genderMenuItems
      .map((String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  final List<PopupMenuItem<String>> _popupObtainedMenuItems = _obtainedMenuItems
      .map((String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  List<PopupMenuItem<String>> get popupBreedMenuItems => _popupBreedMenuItems;
  List<PopupMenuItem<String>> get popupGenderMenuItems => _popupGenderMenuItems;
  List<PopupMenuItem<String>> get popupObtainedMenuItems =>
      _popupObtainedMenuItems;
  List<PopupMenuItem<String>> get popupPigMenuItems => _popupPigMenuItems;
}
