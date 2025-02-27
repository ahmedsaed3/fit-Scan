import 'package:flutter/material.dart';
import 'package:train_me/widgets/helpers/my_colors.dart';

class HelpAndSupport extends StatefulWidget {
  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  final List<Map<String, dynamic>> _faqs = [

    {
      "question": "How do I change my workout goals?",
      "answer": [
        "Navigate to the Customize Goals section from the main menu and select your desired goals."
      ]
    },
    {
      "question": "Can I use the app offline?",
      "answer": [
        "Certain features like tracking workouts and saved data are available offline. However, some functionalities require an internet connection."
      ]
    },
    {
      "question": "How do I track my progress in the app?",
      "answer": [
        "To track your progress, go to the workout plan section in the home. You can Track your progress through your workout plan section."
      ]
    },
    {
      "question" :"How do I scan my InBody device?",
      "answer":[
        "To scan your InBody:\n\n"
            "Get your InBody sheet and place the scan marker and cover all the information inside the sheet"

      ]
    },
    {
      "question": "How often should I take an InBody test?",
      "answer": [
        "For accurate tracking, take an InBody test every 4-6 weeks. This frequency allows you to monitor significant changes in your body composition."
      ]
    },
    {
      "question": "What is the best workout plan for beginners and what equipment do I need?",
      "answer": [
        "For beginners, it's important to start with exercises that focus on building strength, flexibility, and endurance at a comfortable pace. "
            "You can explore low-intensity workouts using basic equipment such as:\n\n"
            "- Dumbbells: Great for strengthening and toning muscles without the need for heavy lifting.\n"
            "- Resistance Bands: Perfect for beginners to improve flexibility and strength with low impact.\n"
            "- Kettlebells: Ideal for functional exercises that work multiple muscle groups at once.\n"
            "- Yoga Mat: Essential for bodyweight exercises, stretching, and floor-based movements.\n"
            "- Stability Ball: Useful for core strengthening and balance exercises."
      ]
    },
    {
      "question": "How do I prevent muscle soreness after a workout?",
      "answer": [
        "To reduce muscle soreness after a workout:\n\n"
            "- Perform a proper warm-up before and a cool-down after your workout.\n"
            "- Stay hydrated and maintain a balanced diet.\n"
            "- Use foam rollers or get a massage to release muscle tension.\n"
            "- Include active recovery days in your routine with light stretching or yoga."
      ]
    },

    {
      "question": "What should I eat before and after a workout?",
      "answer": [
        "Pre-Workout:\n"
            "- Consume a small meal or snack 1-2 hours before exercise, including carbohydrates and protein (e.g., a banana with peanut butter).\n\n"
            "Post-Workout:\n"
            "- Focus on a balanced meal within 2 hours after exercise, including protein to repair muscles and carbohydrates to replenish energy (e.g., grilled chicken with quinoa and vegetables)\n\n"
            "Finally you can keep up with your daily meals with the diet plan section inside the home "
      ]
    },

    // Other FAQs...
  ];

  // Function to highlight equipment words with black color
  TextSpan _highlightEquipmentWords(String text) {
    // List of equipment words to highlight in black
    List<String> equipmentWords = ["Dumbbells", "Resistance Bands", "Kettlebells", "Yoga Mat", "Stability Ball"];

    // Create a list of TextSpans based on the equipment words
    List<TextSpan> spans = [];
    String remainingText = text;

    for (String word in equipmentWords) {
      if (remainingText.contains(word)) {
        final beforeWord = remainingText.substring(0, remainingText.indexOf(word));
        final highlightedWord = remainingText.substring(remainingText.indexOf(word), remainingText.indexOf(word) + word.length);
        final afterWord = remainingText.substring(remainingText.indexOf(word) + word.length);

        if (beforeWord.isNotEmpty) {
          spans.add(TextSpan(text: beforeWord));
        }
        spans.add(TextSpan(
          text: highlightedWord,
          style: TextStyle(color: MyColors.WiledGreen, fontWeight: FontWeight.bold),
        ));
        remainingText = afterWord;
      }
    }

    // Add any remaining text after the last equipment word
    if (remainingText.isNotEmpty) {
      spans.add(TextSpan(text: remainingText));
    }

    return TextSpan(children: spans);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help&Support",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.015,
          ),
        ),
        backgroundColor: MyColors.LightBlack,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context); // Action when the back arrow is pressed
        },
      ),),
      backgroundColor: MyColors.LightBlack,
      body: ListView.builder(
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final category = _faqs[index];
          return Card(
            color: Colors.black,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ExpansionTile(
              collapsedIconColor: MyColors.WiledGreen,
              iconColor: MyColors.WiledGreen,
              title: Text(
                category["question"],
                style: TextStyle(
                  color: MyColors.WiledGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              children: category["answer"]
                  .map<Widget>(
                    (tip) => ListTile(
                  title: RichText(
                    text: _highlightEquipmentWords(tip),
                  ),
                ),
              )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
