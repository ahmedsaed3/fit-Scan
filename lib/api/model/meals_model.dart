class Meals {
  int? id;
  String? title;
  String? image;
  int? calories;
  String? protein;
  String? fat;
  String? carbs;

  Meals(
      {this.id,
        this.title,
        this.image,
        this.calories,
        this.protein,
        this.fat,
        this.carbs});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    calories = json['calories'];
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbs'] = this.carbs;
    return data;
  }
}