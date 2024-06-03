import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_getx/controller/product_controller.dart';
import 'package:shopping_app_getx/utils/app_images.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Product",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
              height: 30,
              margin: EdgeInsets.only(right: 20),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0x33374957)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Image.asset(AppImages.bag,width: 20,height: 20,),
                    SizedBox(
                      width: 12,
                    ),
                    GetX<ProductController>(builder: (controller) =>
                        Text(
                          controller.count.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                    ),

                  ],
                ),
              )),
        ],
      ),
      body: Column(
        children: [
          Obx(() =>
            productController.isLoading.value ? const Center(
              child: CircularProgressIndicator(),
            ) : Expanded(
              child: GridView.builder(
                itemCount: productController.productData.length,
                padding: EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                   // Space between rows
                  childAspectRatio: 0.7, // Aspect ratio of the grid items
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Image.network(
                            productController.productData[index].image.toString(),
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productController.productData[index].title.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7,right:14),
                          child: Text(
                            productController.productData[index].category.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,bottom: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${productController.productData[index].price}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                productController.productData[index].rating!.rate.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed:(){
                                    productController.addtoCard(productController.productData[index]);
                                  },
                                  child: Text(
                                    "Add to Card",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                ),
                              ),
                              InkWell(
                                onTap: (){

                                },
                                  child: Icon(
                                      Icons.favorite_border_outlined
                                  )
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
