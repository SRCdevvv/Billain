import 'package:bilrun/model/product_detail_model.dart';
import 'package:bilrun/widgets/etc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> getOrCreateInitAPIData(
  RegisterCategory,
  RegisterPrice,
  RegisterName,
  RegisterDescription,
  RegisterCaution,
  RegisterMenu,
  RegisterPriceProp,
  RegisterImage,
) async {
  String url = '$serviceUrl/product_list/';

  try {
    var uri = Uri.parse('$url');

    var request = http.MultipartRequest('POST', uri);
    request.fields["name"] = "$RegisterName";
    request.fields["description"] = "$RegisterDescription";
    request.fields["caution"] = "$RegisterCaution";
    request.fields["price"] = "$RegisterPrice";
    request.fields["price_prop"] = "$RegisterPriceProp";
    request.fields["user.id"] = "1";
    request.fields["lend"] = "$RegisterCategory";
    request.fields["category"] = "$RegisterMenu";
    request.fields["place_option"] = "true";

//TODO 사진 path 구하기...

    final multipartFile =
        await http.MultipartFile.fromPath('Image', '$RegisterImage');
    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      print("success");
    } else {
      print("fail: ${response.statusCode}");
    }
  } catch (e) {
    print("error: $e");
  }
}
