import 'package:asiatic_seller/const/const.dart';
import 'package:asiatic_seller/controllers/products_controller.dart';
import 'package:asiatic_seller/services/store_services.dart';
import 'package:asiatic_seller/views/products_screen/add_product.dart';
import 'package:asiatic_seller/views/products_screen/product_details.dart';
import 'package:asiatic_seller/views/widgets/appbar_widget.dart';
import 'package:asiatic_seller/views/widgets/loading_indicator.dart';
import 'package:asiatic_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: uiGrey,
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => const AddProduct());
        },
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      appBar: appbarWidget(products),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => ListTile(
                      onTap: () {
                        Get.to(() => ProductDetails(data: data[index]));
                      },
                      leading: Image.network(data[index]['p_imgs'][0],
                          width: 100, height: 100, fit: BoxFit.cover),
                      title: boldText(
                          text: "${data[index]['p_name']}", color: fontGrey),
                      subtitle: Row(
                        children: [
                          normalText(
                              text: "\$${data[index]['p_price']}",
                              color: darkGrey),
                          10.widthBox,
                          boldText(
                              text: data[index]['is_featured'] == true
                                  ? "Featured"
                                  : '',
                              color: green),
                        ],
                      ),
                      trailing: VxPopupMenu(
                          arrowSize: 0.0,
                          menuBuilder: () => Column(
                                children: List.generate(
                                  popupMenuTitles.length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Icon(popupMenuIcons[i],
                                            color: data[index]['featured_id'] ==
                                                        currentUser!.uid &&
                                                    i == 0
                                                ? green
                                                : darkGrey),
                                        10.widthBox,
                                        normalText(
                                            text: data[index]['featured_id'] ==
                                                        currentUser!.uid &&
                                                    i == 0
                                                ? 'Remove Featured'
                                                : popupMenuTitles[i],
                                            color: darkGrey)
                                      ],
                                    ).onTap(() {
                                      switch (i) {
                                        case 0:
                                          if (data[index]['is_featured'] ==
                                              true) {
                                            controller
                                                .removeFeatured(data[index].id);
                                            VxToast.show(context,
                                                msg: "Removed");
                                          } else {
                                            controller
                                                .addFeatured(data[index].id);
                                            VxToast.show(context, msg: "Added");
                                          }

                                          break;
                                        case 1:
                                          break;
                                        case 2:
                                          controller
                                              .removeProduct(data[index].id);
                                          VxToast.show(context,
                                              msg: "Product Removed");
                                          break;
                                        default:
                                      }
                                    }),
                                  ),
                                ),
                              ).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick,
                          child: const Icon(Icons.more_vert)),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
