import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/bloc_provider.dart';
import 'package:flutter_category/blocs/categories_bloc.dart';
import 'package:flutter_category/blocs/edit_categories/edit_category_bloc.dart';
import 'package:flutter_category/events/category_edited_event.dart';
import 'package:flutter_category/events/event_bus_instance.dart';
import 'package:flutter_category/models/category_model.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel category;
  final Function hidePanel;

  EditCategory({Key key, this.category, this.hidePanel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  EditCategoryBloc _bloc;
  CategoriesBloc _categoriesBloc;
  TextEditingController _categoryNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<EditCategoryBloc>(context);
    _categoriesBloc = Provider.of<CategoriesBloc>(context);
    setState(() {
      if (widget.category != null) {
        _categoryNameController = TextEditingController.fromValue(
            TextEditingValue(text: widget.category.name));
      } else {
        _categoryNameController = TextEditingController();
      }
    });
  }

  void _saveCategory() async {
    widget.category.name = _categoryNameController.text;
    await _bloc.updateCategory(widget.category).then((t) {
      EventBusInstance.eventBus.fire(CategoryEditedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.category != null) {
      _categoryNameController = TextEditingController.fromValue(
          TextEditingValue(text: widget.category.name));
    } else {
      _categoryNameController = TextEditingController();
    }
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _categoryNameController,
                style: Theme.of(context).textTheme.display1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    colorBrightness: Brightness.light,
                    splashColor: Colors.white12,
                    onPressed: _saveCategory,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
