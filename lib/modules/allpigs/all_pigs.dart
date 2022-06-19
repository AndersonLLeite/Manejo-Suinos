import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/pig_repository.dart';
import 'package:manejo_suinos/shared/themes/styles/textstyles/app_text_styles.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';

class AllPigs extends StatefulWidget {
  const AllPigs({Key? key}) : super(key: key);

  @override
  State<AllPigs> createState() => _AllPigsState();
}

class _AllPigsState extends State<AllPigs> {
  PigRepository repository = PigRepository();
  static const menuItems = <String>['remover', 'arquivar'];
  String bottomSelected = '';
  final List<PopupMenuItem<String>> _popupMenuItems = menuItems
      .map((String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: const [
                Colors.blue,
                Colors.pink,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(5),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 10,
                    color: Colors.black,
                  ),
                  itemCount: repository.pigs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      title: Center(
                        child: Text(
                          repository.pigs[index].name,
                          style: AppTextStyles.listTileTitle,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(repository.pigs[index].imageUrl),
                        radius: 30.0,
                      ),
                      subtitle: Icon(
                          repository.pigs[index].gender == GenderEnum.FEMALE
                              ? Icons.female
                              : Icons.male,
                          color:
                              repository.pigs[index].gender == GenderEnum.FEMALE
                                  ? Colors.pink
                                  : Colors.blue),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String newValue) {
                          bottomSelected = newValue;
                          print(newValue);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(bottomSelected)));
                        },
                        itemBuilder: (BuildContext context) => _popupMenuItems,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          print(bottomSelected);
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
        ),
        child: Text("Adicionar novo suino"),
      ),
    );
  }
}
