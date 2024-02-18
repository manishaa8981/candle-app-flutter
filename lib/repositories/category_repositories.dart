import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/category_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository{
  CollectionReference<CategoryModel> categoryRef = FirebaseService.db.collection("category")
      .withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) {
      return CategoryModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
    Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if(!hasData){
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>>  getCategory(String categoryId) async {
      try{
        print(categoryId);
        final response = await categoryRef.doc(categoryId).get();
        return response;
      }catch(e){
        rethrow;
      }
  }

  List<CategoryModel> makeCategory(){
      return [
        CategoryModel(categoryName: "amaryllis", status: "active", imageUrl: "https://florgeous.com/wp-content/uploads/2019/09/amaryllis-plant.jpg"),
        CategoryModel(categoryName: "Aconite", status: "active", imageUrl: "https://www.flowerglossary.com/wp-content/uploads/2017/09/aconite.jpg"),
        CategoryModel(categoryName: "Geum", status: "active", imageUrl: "https://www.flowerglossary.com/wp-content/uploads/2017/09/geum.jpg"),
        CategoryModel(categoryName: "Rose", status: "active", imageUrl: "https://www.flowerglossary.com/wp-content/uploads/2017/09/rose.jpg"),
        CategoryModel(categoryName: "SunFlower", status: "active", imageUrl: "https://www.flowerglossary.com/wp-content/uploads/2017/09/sunflower.jpg"),
      ];
  }



}