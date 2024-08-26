import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://192.168.1.10/api/get_all_tables_data.php";

  Future<Map<String, dynamic>> fetchAllTablesData() async {
    try {
      print('Fetching data from $apiUrl...');
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetching data: $e');
      throw Exception('Error fetching data');
    }
  }
}
