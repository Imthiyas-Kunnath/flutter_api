import 'package:flutter/material.dart';
import 'package:flutter_api/models/posts.dart';
import 'package:flutter_api/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product>? posts;
  var isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async{
    posts = await RemoteService().getPosts();
    if (posts!=null){
      setState(() {
        isLoaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index){
          return Container(
            child: Text(posts![index].title),
          );
        }),
        replacement: const Center(
          child: CircularProgressIndicator(),

        ),
      ),
    );
  }
}
