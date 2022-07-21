import 'package:flutter/material.dart';

class ManejoPage extends StatefulWidget {
  const ManejoPage({Key? key}) : super(key: key);

  @override
  State<ManejoPage> createState() => _ManejoPageState();
}

class _ManejoPageState extends State<ManejoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.red,
        ),
      ),
    );
  }
}
