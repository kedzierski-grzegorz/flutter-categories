import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/add_category/add_category_bloc.dart';
import 'package:flutter_category/blocs/add_category/add_category_bloc_provider.dart';
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

  @override
  void initState() {
    super.initState();

    _bloc = AddCategoryBlocProvider.of(context);

    _icons = [];
    MyIcons.icons.forEach((key, icon) {
      _icons.add(key);
    });
  }

  String _validateCategoryName(String name) {
    _bloc.existCategoryWithName(name).then((data) => {
      if(data == true){
     //   return 'Please enter an other name';
      }
    });

    if (name.isEmpty) {
      return 'Please enter a category name';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add category'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
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
                  isExpanded: true,
                  hint: Text('Select an icon'),
                  style: TextStyle(fontSize: 28, color: Colors.black),
                  value: _selectedIcon,
                  onChanged: (String newIcon) => setState(() {
                    _selectedIcon = newIcon;
                  }),
                  items: _icons.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
