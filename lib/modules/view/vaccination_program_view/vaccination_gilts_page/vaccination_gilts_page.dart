import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/vaccine_repository/vaccine_repository.dart';
import '../../../../shared/themes/background/background_gradient.dart';
import '../../../../shared/themes/colors/app_colors.dart';
import '../../../../shared/utils/enums/pigstage_enum.dart';
import '../../../model/entities/vaccine/vaccine_entity.dart';
import '../../add_vaccine_page/add_vaccine_page.dart';

class VaccinationGiltsPage extends StatelessWidget {

  const VaccinationGiltsPage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text('Vacinação Marrãs'),
        centerTitle: true,
      ),
      body: BackgroundGradient(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120.0,
              ),
              const Center(
                child: Text(
                  'Vacinas: ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              FutureBuilder(
                  future: context
                      .watch<VaccineRepository>()
                      .getVaccinesByPigStage(PigStage.GILT.value),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<VaccineEntity>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text('Nenhuma vacina cadastrada'),
                          )
                        : SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                    snapshot.data![index].vaccineName,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].description ?? "",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                    color: AppColors.secondary,
                                  ),
                                  leading: Column(
                                    children: [
                                      Icon(
                                        Icons.vaccines,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        snapshot.data![index].type,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                  }),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddVaccinePage(
                        pigStage: PigStage.GILT,
                      ),
                    ),
                  );
                },
                child: Text('Adicionar nova vacina'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}