import 'package:flutter/material.dart';
import 'package:flutter_ecom_admin/controllers/product_controller.dart';
import 'package:flutter_ecom_admin/models/product_model.dart';
import 'package:flutter_ecom_admin/screens/screens.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        backgroundColor: Color(0xFF010A26),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF54BFA1),
      body: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.3,
              child: InkWell(
                onTap: () {
                  Get.to(() => NewProductScreen());
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Color(0xFF4A96D9),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => NewProductScreen());
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      Text(
                        'Add a new product',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  ProductCard({
    super.key,
    required this.product,
    required this.index,
  });

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  'ID - ${product.id}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              product.description,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.02,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Slider(
                            value: product.price.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 10,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductPrice(
                                index,
                                product,
                                value.toInt(),
                              );
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductPrice(
                                  product, 'price', value.toInt());
                            },
                          ),
                          Text(
                            '\฿${product.price.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Slider(
                            value: product.quantity.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 10,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductQuantity(
                                index,
                                product,
                                value.toInt(),
                              );
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductQuantity(
                                product,
                                'quantity',
                                value.toInt(),
                              );
                            },
                          ),
                          Text(
                            '${product.quantity.toInt()}',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
