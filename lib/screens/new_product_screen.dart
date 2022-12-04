import 'package:flutter/material.dart';
import 'package:flutter_ecom_admin/controllers/controllers.dart';
import 'package:flutter_ecom_admin/models/product_model.dart';
import 'package:flutter_ecom_admin/services/database_service.dart';
import 'package:flutter_ecom_admin/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({super.key});

  final ProductController productController = Get.find();

  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Pen',
      'Pencil',
      'Ruler',
      'Eraser',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a Product',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.02,
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.3,
                  child: InkWell(
                    onTap: () async {
                      ImagePicker _picker = ImagePicker();
                      final XFile? _image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No image select'),
                          ),
                        );
                      }
                      if (_image != null) {
                        await storage.uploadImage(_image);
                        var imageUrl =
                            await storage.getDownloadURL(_image.name);
                        productController.newProduct.update(
                          'imageUrl',
                          (_) => imageUrl,
                          ifAbsent: () => imageUrl,
                        );
                        print(productController.newProduct['imageUrl']);
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Color(0xFF4A96D9),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              ImagePicker _picker = ImagePicker();
                              final XFile? _image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('No image select'),
                                  ),
                                );
                              }
                              if (_image != null) {
                                await storage.uploadImage(_image);
                                var imageUrl =
                                    await storage.getDownloadURL(_image.name);
                                productController.newProduct.update(
                                  'imageUrl',
                                  (_) => imageUrl,
                                  ifAbsent: () => imageUrl,
                                );
                                print(productController.newProduct['imageUrl']);
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                          Text(
                            'Add image',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.025,
                ),
                Text(
                  'Product information',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                buildTextFormField(
                  'Product id',
                  'id',
                  productController,
                ),
                buildTextFormField(
                  'Product name',
                  'name',
                  productController,
                ),
                buildTextFormField(
                  'Product Description',
                  'description',
                  productController,
                ),
                // buildTextFormField(
                //   'Product Category',
                //   'category',
                //   productController,
                // ),
                DropdownButtonFormField(
                  iconSize: MediaQuery.of(context).size.width * 0.05,
                  decoration: InputDecoration(
                    hintText: 'Product Category',
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    productController.newProduct.update(
                      'category',
                      (_) => value,
                      ifAbsent: () => value,
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.02,
                ),
                buildSlider(
                  'Price',
                  'price',
                  productController,
                  productController.price,
                  context,
                ),
                buildSlider(
                  'Quantity',
                  'quantity',
                  productController,
                  productController.quantity,
                  context,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.02,
                ),
                buildCheckbox(
                  'Recommend',
                  'isRecommended',
                  productController,
                  productController.isRecommended,
                  context,
                ),
                buildCheckbox(
                  'Popular',
                  'isPopular',
                  productController,
                  productController.isPopular,
                  context,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.02,
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.12,
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        database.addProduct(
                          Product(
                            id: productController.newProduct['id'],
                            name: productController.newProduct['name'],
                            category: productController.newProduct['category'],
                            description:
                                productController.newProduct['description'],
                            imageUrl: productController.newProduct['imageUrl'],
                            isRecommended:
                                productController.newProduct['isRecommended'] ??
                                    false,
                            isPopular:
                                productController.newProduct['isPopular'] ??
                                    false,
                            price:
                                productController.newProduct['price'].toInt(),
                            quantity: productController.newProduct['quantity']
                                .toInt(),
                          ),
                        );
                        Navigator.pop(context);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'กรุณาใส่ข้อมูลให้ครบก่อน',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF010A26),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildCheckbox(
    String title,
    String name,
    ProductController productController,
    bool? controllerValue,
    BuildContext context,
  ) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }

  Row buildSlider(
    String title,
    String name,
    ProductController productController,
    double? controllerValue,
    BuildContext context,
  ) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0,
            max: 300,
            divisions: 20,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  TextFormField buildTextFormField(
    String hintText,
    String name,
    ProductController productController,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }
}
