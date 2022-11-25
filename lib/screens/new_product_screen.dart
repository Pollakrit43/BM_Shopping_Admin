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
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
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
                      color: Colors.black,
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
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Add image',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Product information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                  iconSize: 20,
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
                const SizedBox(
                  height: 10,
                ),
                buildSlider(
                  'Price',
                  'price',
                  productController,
                  productController.price,
                ),
                buildSlider(
                  'Quantity',
                  'quantity',
                  productController,
                  productController.quantity,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildCheckbox(
                  'Recommend',
                  'isRecommended',
                  productController,
                  productController.isRecommended,
                ),
                buildCheckbox(
                  'Popular',
                  'isPopular',
                  productController,
                  productController.isPopular,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
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
                          price: productController.newProduct['price'].toInt(),
                          quantity:
                              productController.newProduct['quantity'].toInt(),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
  ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
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
  ) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
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
