import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_simple_list/components/item_widget.dart';
import 'package:mobx_simple_list/models/item_model.dart';
import 'package:mobx_simple_list/pages/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  _dialog() {
    var model = ItemModel();
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Adicionar item'),
          content: TextField(
            onChanged: model.setTitle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Novo item',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                controller.addItem(model);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText: 'Pesquisa...'),
          onChanged: controller.setFilter,
        ),
        actions: <Widget>[
          Observer(
            builder: (_) {
              return IconButton(
                icon: Text(controller.totalChecked.toString()),
                onPressed: () {},
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: controller.listFiltered.length,
            itemBuilder: (_, index) {
              var item = controller.listFiltered[index];
              return ItemWidget(
                item: item,
                removeClicked: () {
                  controller.removeItem(item);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
