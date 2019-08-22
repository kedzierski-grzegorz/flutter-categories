import 'package:flutter/material.dart';
import 'package:flutter_category/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final ValueChanged<CategoryModel> onTap;

  const CategoryItem({Key key, this.category, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).accentColor,
          onTap: () => onTap(category),
          child: Row(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    category.icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.display1,
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
