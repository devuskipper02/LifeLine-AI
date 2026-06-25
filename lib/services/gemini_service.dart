import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String apiKey = "YOUR_API_KEY";

  static Future<String> askGemini(String prompt) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final response =
          await model.generateContent([Content.text(prompt)]);

      return response.text ?? "No response";
    } catch (e) {
      return "Error: $e";
    }
  }
}
