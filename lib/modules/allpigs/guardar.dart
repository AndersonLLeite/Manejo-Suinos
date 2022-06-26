// import 'package:flutter/material.dart';

// import '../../shared/themes/colors/app_colors.dart';

// class Guardar extends StatefulWidget {

//   const Guardar({ Key? key }) : super(key: key);

//   @override
//   State<Guardar> createState() => _GuardarState();
// }

// class _GuardarState extends State<Guardar> {

//    @override
//    Widget build(BuildContext context) {
//        return  SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 AppColors.primary,
//                 AppColors.secondary,
//               ],
//             ),
//           ),
//           child: Column(
//             children: [
//               FutureBuilder(

//                 child: Expanded(
//                   child: ListView.separated(
//                     padding: EdgeInsets.all(5),
//                     separatorBuilder: (BuildContext context, int index) =>
//                         const Divider(
//                       height: 10,
//                       color: Colors.black,
//                     ),
//                     itemCount: repository.pigs.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         shadowColor: Colors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         color: AppColors.primary,
//                         elevation: 20,
//                         child: ListTile(
//                           dense: true,
//                           title: Center(
//                             child: Text(
//                               repository.pigs[index].name,
//                               style: AppTextStyles.listTileTitle,
//                             ),
//                           ),
//                           leading: CircleAvatar(
//                             backgroundImage:
//                                 AssetImage(repository.pigs[index].imageUrl),
//                             radius: 30.0,
//                           ),
//                           subtitle: Icon(
//                               repository.pigs[index].gender == GenderEnum.FEMALE
//                                   ? Icons.female
//                                   : Icons.male,
//                               color: repository.pigs[index].gender ==
//                                       GenderEnum.FEMALE
//                                   ? Colors.pink
//                                   : Colors.blue),
//                           trailing: PopupMenuButton<String>(
//                             onSelected: (String newValue) {
//                               bottomSelected = newValue;
//                               print(newValue);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text(bottomSelected)));
//                             },
//                             itemBuilder: (BuildContext context) =>
//                                 _popupMenuItems,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
// ,
//        );
//   }
// }



  



import 'dart:io';
import 'package:manejo_suinos/shared/entities/pig/pig_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'pigsbase.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pigsdata(
          name TEXT PRIMARY KEY,
          age INTEGER
          weight REAL,
          imageUrl TEXT,
          breed TEXT,
          obtained TEXT,
          gender TEXT,
          motherName TEXT,
          fatherName TEXT,
          birthday TEXT,
          entryFarm TEXT
      )
      ''');
  }

  
}
