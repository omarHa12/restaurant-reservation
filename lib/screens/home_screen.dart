// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'dart:developer';

/// VERY IMPORTANT NOTE
/// THE VIEW HERE IS BASED ON LIST INDEXES
/// THE PAGE IS BEING VIEWED BASED ON THE ITEMS ON THE BOTTOM NAV BAR

import 'package:flutter/material.dart';
import 'package:resrev/init_parse.dart';
import 'login_screen.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {

static const id = "HomePage";

  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // var test;
  // Future<List<ParseObject>> getGalleryList() async {
  //   QueryBuilder<ParseObject> queryPublisher =
  //   QueryBuilder<ParseObject>(ParseObject('Images'))
  //   ..includeObject(['images']);
  //     // ..orderByAscending('createdAt');
  //   final ParseResponse apiResponse = await queryPublisher.query();

  //   if (apiResponse.success && apiResponse.results != null) {
  //    print(apiResponse.results as List<ParseObject>);
  //    setState(() {
  //      test = apiResponse.results;
  //      log(test.toString());
  //    });
  //   } else {
  //     return [];
  //   }
  // }



  // Image image1 = Image.network('https://images.freeimages.com/images/large-previews/83a/sunset-at-daman-beach-1578040.jpg');

  // PickedFile _pickedFile;
  // void uploadImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile image = await _picker.pickImage(source: ImageSource.gallery);
  // }

  void _onItemTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late ParseUser _authUser;

  @override
  // This must be in every screen
  void initState() {
    initData().then((bool success) {
      ParseUser.currentUser().then((currentUser) {
        setState(() {
          _authUser = currentUser;
        });
      });
    }).catchError((dynamic _) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      // Index Number 1 from the list

      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Welcome ${_authUser.username}'),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: CarouselSlider(
                  // To edit the options of the Carousel slider
                  options: CarouselOptions(
                    height: 220.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    // TODO CHANGE TO TRUE AFTER IMPORTING IMAGES
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: [1,2,3,4].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            decoration: BoxDecoration(color: Colors.black),
                            child: Text(
                              'text $i',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                        );
                      },
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        // TODO EDIT BOTTOM NAV BAR
        bottomNavigationBar: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile")
          ],
          // Take the current index of the items since they are a list
          currentIndex: _selectedIndex,
          // On tap change index number
          onTap: _onItemTap,
        ),
      ),

      // Index Number 2 from the list

      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Welcome ${_authUser.username}'),
          backgroundColor: Colors.orange,
        ),
        body: Center(child: Text('Search'),),
        bottomNavigationBar: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile")
          ],
          // Take the current index of the items since they are a list
          currentIndex: _selectedIndex,
          // On tap change index number
          onTap: _onItemTap,
        ),
      ),

      // INDEX NUMBER 3 FROM THE LIST

      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Welcome ${_authUser.username}'),
          backgroundColor: Colors.orange,
        ),
        body: Center(child: Text('Profile Screen'),),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile")
          ],
          // Take the current index of the items since they are a list
          currentIndex: _selectedIndex,
          // On tap change index number
          onTap: _onItemTap,
        ),
      )

    ];


    return _widgetOptions[_selectedIndex];
  }
}
