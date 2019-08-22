import 'package:flutter/material.dart';
import 'package:flutter_category/models/category_model.dart';

class AddCategory extends StatefulWidget {
  final CategoryModel category;

  const AddCategory({Key key, this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String _categoryName = '';

  @override
  void initState() {
    super.initState();
    if(widget.category != null)
    setState(() {
      _categoryName = widget.category.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.category != null) _categoryName = widget.category.name;
    return SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: TextEditingController.fromValue(TextEditingValue(text: _categoryName)),
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
                      onPressed: () {},
                      child: Text(
                        'Add',
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
