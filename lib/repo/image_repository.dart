import 'package:http/http.dart' as http;
import 'package:chat_app/models/image_model.dart';
import 'dart:convert';

class ImageRepository {
  Future<List<PixelFordImage>> getNetworkImages() async {
    var endpointUrl = Uri.parse('https://pixelford.com/api2/images');

    final response = await http.get(endpointUrl);

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;
      final List<PixelFordImage> _imageList = decodedList.map((listItem) {
        return PixelFordImage.fromJson(listItem);
      }).toList();

      return _imageList;
    } else {
      throw Exception("API not successful");
    }
  }
}
