import 'package:mobx/mobx.dart';
import 'package:mobx_simple_list/models/item_model.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  ObservableList<ItemModel> listItems = [
    ItemModel(title: "Item 1", check: true),
    ItemModel(title: "Item 2", check: false),
    ItemModel(title: "Item 3", check: false),
  ].asObservable();

  @observable
  String filter = '';

  @computed
  int get totalChecked => listItems.where((item) => item.check).length;

  @computed
  List<ItemModel> get listFiltered {
    if (filter.isNotEmpty) {
      return listItems
          .where(
              (item) => item.title.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }

    return listItems;
  }

  @action
  addItem(ItemModel model) {
    if (model.title != null) listItems.add(model);
  }

  @action
  removeItem(ItemModel model) {
    listItems.removeWhere((item) => item.title == model.title);
  }

  @action
  setFilter(String value) => filter = value;
}
