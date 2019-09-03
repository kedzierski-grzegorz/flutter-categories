import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/add_category/add_category_bloc.dart';
import 'package:flutter_category/blocs/bloc_provider.dart';
import 'package:flutter_category/models/category_model.dart';
import 'package:flutter_category/models/my_icons.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  AddCategoryBloc _bloc;
  String _selectedIcon;
  List<String> _icons;
  TextEditingController _categoryNameController = TextEditingController();
  bool _isInvalidCategoryNameAsync = false;
  Function _submitFunc;

  @override
  void initState() {
    super.initState();

    _icons = [];
    MyIcons.icons.forEach((key, icon) {
      _icons.add(key);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<AddCategoryBloc>(context);
    _categoryNameController.addListener(_checkExistingCategoryName);
  }

  void _checkExistingCategoryName() {
    _bloc.existCategoryWithName(_categoryNameController.text).then((data) {
      if (data == true) {
        _isInvalidCategoryNameAsync = true;
        _validateForm();
      } else {
        _isInvalidCategoryNameAsync = false;
        _validateForm();
      }
    });

    _validateForm();
  }

  String _validateCategoryName(String name) {
    if (_isInvalidCategoryNameAsync) {
      return 'Please enter an other name';
    }

    if (name.isEmpty) {
      return 'Please enter a category name';
    }

    return null;
  }

  void _validateForm() {
    if (_categoryNameController.text.isEmpty ||
        _isInvalidCategoryNameAsync ||
        _selectedIcon == null) {
      setState(() {
        _submitFunc = null;
      });
    } else {
      setState(() {
        _submitFunc = _submit;
      });
    }
  }

  void _submit() {
    _bloc
        .addCategory(
            CategoryModel(null, _categoryNameController.text, _selectedIcon))
        .then((data) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Add category'),
            SizedBox(
              width: 10.0,
            ),
            Hero(
              tag: 'AddHero',
              child: Icon(Icons.add),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitFunc,
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _categoryNameController,
                    style: TextStyle(fontSize: 28),
                    decoration: InputDecoration(
                      labelText: "Category name",
                      border: OutlineInputBorder(),
                      errorText:
                          _validateCategoryName(_categoryNameController.text),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    key: Key('Dropdown'),
                    isExpanded: true,
                    hint: Text('Select an icon'),
                    style: TextStyle(fontSize: 28, color: Colors.black),
                    value: _selectedIcon,
                    onChanged: (String newIcon) => setState(() {
                      _selectedIcon = newIcon;
                      _validateForm();
                    }),
                    items: _icons.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        key: Key('Item' + value),
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(MyIcons.icons[value]),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                value,
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  _selectedIcon == null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'Please enter an other name',
                            style: TextStyle(
                                color: Colors.red[700], fontSize: 12.0),
                          ),
                        )
                      : SizedBox(
                          height: 11.0,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
