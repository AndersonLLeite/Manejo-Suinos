import 'package:flutter/material.dart';



class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<Row> rows = [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        BotaoAddWidget(),
        BotaoAddWidget(),
        BotaoAddWidget(),
      ],
    )
  ];

  addRow() {
    rows.add(
      Row(
        children: const [
          BotaoAddWidget(),
          BotaoAddWidget(),
          BotaoAddWidget(),
        ],
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addRow();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Edição'),
      ),
      body: SingleChildScrollView(
        child: Column(children: rows),
      ),
    );
  }
}

class BotaoAddWidget extends StatelessWidget {
  const BotaoAddWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(
        child: Icon(Icons.add),
      ),
    ));
  }
}
