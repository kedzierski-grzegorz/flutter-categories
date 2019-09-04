import 'package:flutter/material.dart';
import 'package:flutter_category/blocs/bloc_provider.dart';
import 'package:flutter_category/blocs/image_route/image_bloc.dart';
import 'package:flutter_category/ui/main_drawer.dart';
import 'package:image_picker_modern/image_picker_modern.dart';

class ImageRoute extends StatefulWidget {
  @override
  _ImageRouteState createState() => _ImageRouteState();
}

class _ImageRouteState extends State<ImageRoute> {
  ImageBloc _bloc;
  List<dynamic> _images = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ImageBloc>(context);
    _bloc.getAllImages().then((data) {
      setState(() {
        _images = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Container(
        child: Center(
          child: _images.length > 0
              ? GridView.builder(
                  itemCount: _images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.network(
                              _images[index],
                              width: 120,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                (index + 1).toString(),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Text('No images'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var image = await ImagePicker.pickImage(source: ImageSource.camera);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
