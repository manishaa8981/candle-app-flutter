import 'package:candel/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/product_model.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/category_viewmodel.dart';
import '../../viewmodels/product_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  late AuthViewModel _authViewModel;
  late CategoryViewModel _categoryViewModel;
  late ProductViewModel _productViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
      _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
      refresh();
    });
    super.initState();
  }


  Future<void> refresh() async {
    _categoryViewModel.getCategories();
    _productViewModel.getProducts();
    _authViewModel.getMyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CategoryViewModel, AuthViewModel, ProductViewModel>(
        builder: (context, categoryVM, authVM, productVM, child) {
      return Container(decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/img_3.png"),
          opacity: 0.2,
          fit: BoxFit.cover,
        ),
      ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.only(top: 60),
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/img_1.png",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        WelcomeText(authVM),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [...categoryVM.categories.map((e) => CategoryCard(e))],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Products",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold ,fontFamily: 'Poppins', color: Colors.pink),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.count(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: [
                              ...productVM.products.map((e) => ProductCard(e))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            HomeHeader(),
          ],
        ),
      );
    });
  }

  Widget HomeHeader() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.pink.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(child: Image.asset("assets/images/img_3.png", height: 70, width: 70,)),
                Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                        child: Container()
                        // Icon(Icons.search, size: 30,)
                    )),
              ],
            )));
  }

  Widget WelcomeText(AuthViewModel authVM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Explore Here",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: Colors.pink) ,
              )),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Container(
        //       margin: EdgeInsets.symmetric(horizontal: 10),
        //       child: Text(
        //         authVM.loggedInUser != null ? authVM.loggedInUser!.name.toString() : "Guest",
        //         style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),
        //       )),
        // ),
      ],
    );
  }

  Widget CategoryCard(CategoryModel e) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed("/single-category", arguments:e.id.toString());
      },
      child: Container(
        width: 150,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: Image.network(
                    e.imageUrl.toString(),
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
            ),
         SizedBox(height: 8,),
         Text(e.categoryName.toString() + "\n",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }

  Widget ProductCard(ProductModel e) {
    return InkWell(
      onTap: () {
        // print(e.id);
        Navigator.of(context).pushNamed("/single-product", arguments: e.id);
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 250,
          child: Card(
            elevation: 5,
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      e.imageUrl.toString(),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/img_1.png',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    )),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(color: Colors.pink.shade100.withOpacity(1)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              e.productName.toString(),
                              style: TextStyle(fontSize: 20, ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            Text(
                              "Rs. "+e.productPrice.toString(),
                              style: TextStyle(fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
