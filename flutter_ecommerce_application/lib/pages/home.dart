import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_ecommerce_application/commons/common.dart';

//my own imports
import 'package:flutter_ecommerce_application/components/horizontal_listview.dart';
import 'package:flutter_ecommerce_application/components/products.dart';
import 'package:flutter_ecommerce_application/pages/cart.dart';
import 'package:flutter_ecommerce_application/provider/provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    Widget image_carousel = Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.asset("images/c1.jpg"),
          Image.asset("images/m1.jpeg"),
          Image.asset("images/m2.jpg"),
          Image.asset("images/w1.jpeg"),
          Image.asset("images/w3.jpeg"),
          Image.asset("images/w4.jpeg"),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: deepOrange),
        elevation: 0.1,
        backgroundColor: white,
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50],
          elevation: 0.0,
          child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: " Search...", border: InputBorder.none),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "The search field cannot be empty";
                }
              }),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: deepOrange,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: deepOrange,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // header
            UserAccountsDrawerHeader(
              accountName: Text("Santos Enoque"),
              accountEmail: Text("santosenoque.ss@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: deepOrange,
              ),
            ),
            //body
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My Account"),
                leading: Icon(Icons.person, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My Orders"),
                leading: Icon(Icons.shopping_basket, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
              child: ListTile(
                title: Text("Shopping Cart"),
                leading: Icon(Icons.shopping_cart, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Favourites"),
                leading: Icon(Icons.favorite, color: Colors.red),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.help),
              ),
            ),

            InkWell(
              onTap: () {
                user.signOut();
              },
              child: ListTile(
                title: Text("Log out"),
                leading: Icon(Icons.transit_enterexit,color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          //image_carousel begins here
          image_carousel,

          //padding widget
          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Container(
          //       alignment: Alignment.centerLeft, child: Text("Categories")),
          // ),

          // //Horizontal list view begins here
          // HorizontalList(),

          //padding widget
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Recent products")),
              ),
            ],
          ),

          //gridview

          Flexible(child: Products()),
        ],
      ),
    );
  }
}
