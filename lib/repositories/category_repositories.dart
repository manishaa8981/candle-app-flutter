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
        CategoryModel(categoryName: "Cadle Stick", status: "active", imageUrl: "assets/images/2.webp"),
        CategoryModel(categoryName: "Autumn Candle", status: "active", imageUrl: "assets/images/3.jpeg"),
        CategoryModel(categoryName: "Christmas Candle", status: "active", imageUrl: "assets/images/_4.webp"),
        CategoryModel(categoryName: "Birthday Candle", status: "active", imageUrl: "assets/images/slide1.jpg"),
        CategoryModel(categoryName: "Winter Candle", status: "active", imageUrl: "assets/images/slider1.jpg"),
      ];
  }



}