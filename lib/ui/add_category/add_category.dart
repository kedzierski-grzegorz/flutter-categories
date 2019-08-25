import 'package:flutter/material.dart';
import 'package:flutter_category/models/my_icons.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String _selectedIcon;
  List<String> _icons;

  @override
  void initState() {
    super.initState();
    _icons = [];
    MyIcons.icons.forEach((key, icon) {
      _icons.add(key);
    });
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(fontSize: 28),
                decoration: InputDecoration(
                    labelText: "Category name", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select an icon'),
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
    );
  }
}
