import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": 'Red dress',
      "picture": "images/products/dress1.jpeg",
      "price": 50,
      "size": "M",
      "color": "Red",
      "quantity": 1
    },
    {
      "name": 'Blazer',
      "picture": "images/products/blazer2.jpeg",
      "price": 100,
      "price": 50,
      "size": "S",
      "color": "Black",
      "quantity": 2
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, int index) {
        return Single_cart_product(
          cart_prod_name: Products_on_the_cart[index]["name"],
          cart_prod_color: Products_on_the_cart[index]["color"],
          cart_prod_qty: Products_on_the_cart[index]["quantity"],
          cart_prod_size: Products_on_the_cart[index]["size"],
          cart_prod_price: Products_on_the_cart[index]["price"],
          cart_prod_picture: Products_on_the_cart[index]["picture"],
        );
      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(cart_prod_picture, width: 100, height: 100,),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cart_prod_size,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                    child: Text("Color:")),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cart_prod_color,
                      style: TextStyle(color: Colors.red)),
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text("\$$cart_prod_price",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            )
          ],
        ),

       trailing: Column(
         children: <Widget>[
           Expanded(child: IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){},)),
           Expanded(child: Text("$cart_prod_qty")),
           Expanded(child: IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){},))
         ],
       ),
      ),

    );
  }
}
