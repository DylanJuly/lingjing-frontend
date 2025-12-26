/// 食谱模型
class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final String cookingSteps;
  final Map<String, double> nutrition; // 营养成分
  final List<String> tags; // 标签：如"药食同源"、"温补"等
  final String mealType; // 餐次：早餐、午餐、晚餐、加餐
  final int cookingTime; // 制作时间（分钟）
  final int difficulty; // 难度等级 1-5
  
  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.cookingSteps,
    required this.nutrition,
    required this.tags,
    required this.mealType,
    required this.cookingTime,
    required this.difficulty,
  });
  
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      cookingSteps: json['cookingSteps'] as String,
      nutrition: Map<String, double>.from(json['nutrition'] as Map),
      tags: List<String>.from(json['tags'] as List),
      mealType: json['mealType'] as String,
      cookingTime: json['cookingTime'] as int,
      difficulty: json['difficulty'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'cookingSteps': cookingSteps,
      'nutrition': nutrition,
      'tags': tags,
      'mealType': mealType,
      'cookingTime': cookingTime,
      'difficulty': difficulty,
    };
  }
}




