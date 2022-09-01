import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';

class AddPigstyPage extends StatefulWidget {

  const AddPigstyPage({ Key? key }) : super(key: key);

  @override
  State<AddPigstyPage> createState() => _AddPigstyPageState();
}

class _AddPigstyPageState extends State<AddPigstyPage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
           appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Adicionar novo baia'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
           body: BackgroundGradient(child: Column()),
       );
  }
}