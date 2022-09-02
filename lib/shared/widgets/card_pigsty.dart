import 'package:flutter/material.dart';

import 'package:manejo_suinos/shared/themes/images/app_images.dart';

class CardPigsty extends StatelessWidget {
  final String pigstyName;
  final String pigstyType;
  const CardPigsty({
    Key? key,
    required this.pigstyName,
    required this.pigstyType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          AppImages.pigsty,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Column(
                  children: [Text(pigstyName), Text(pigstyType)],
                )
              ],
            )),
      ),
    );
  }
}
