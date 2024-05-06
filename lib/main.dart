import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 50,),
            CategoryFilter(),
            Container(
              height: 2,
              color: Colors.redAccent,
            ),
            SelectedCategories()
          ],
        ),
      ),
    );
  }
}

class SelectedCategories extends StatelessWidget {
  SelectedCategories({super.key});
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(() => ListView.builder(
        itemCount: controller.selectedCategories.length,
        itemBuilder: (_, index){
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: CategoryWidget(
              category: controller.selectedCategories[index],
            ),
          );
      }),
    ));
  }
}

class CategoryFilter extends StatelessWidget {
  CategoryFilter({super.key});
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(() => ListView.builder(
        itemCount: controller.categories.length,
        itemBuilder: (_, index){
          return CheckboxListTile(
            value: controller.selectedCategories.contains(controller.categories[index]), 
            onChanged: (bool? selected){
              controller.toggle(controller.categories[index]);
            },
            title: CategoryWidget(
            category: controller.categories[index],
            ),
          );
      }),
    ));
  }
}

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: category.color
      ),
      child: Center(
        child: Text(
          category.name,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}

class Controller extends GetxController{
  final _categories = {
    Category("Item one", Color(0xFFFe7743)):false,
    Category("Item two", Color(0xFF21d0d0)):false,
    Category("Item three", Color(0xFF895ed1)):false,
  }.obs;
  
  void toggle(Category item){
    _categories[item] = !(_categories[item]??true);
    print(_categories[item]);
  }

  get selectedCategories => _categories.entries.where((element) => element.value).map((e) => e.key).toList();
  get categories => _categories.entries.map((e) => e.key).toList();
}

class Category{
  final String name;
  final Color color;

  Category(
    this.name,
    this.color
  );
}