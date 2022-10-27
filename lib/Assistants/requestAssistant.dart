import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vege_food/Models/apiConstants.dart';

class RequestAssistant
{
  static Future<dynamic> uploadFile(List<File> files, String userid) async
  {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse("${ApiConstants.baseUrl}/includes/process.php"));
    request.fields['useid'] = userid;
    request.fields['uploadUserProfile'] = '1';
    request.files.add(await http.MultipartFile.fromPath('files', files[0].path));
    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    print('\n\n');
    print('RESPONSE WITH HTTP');
    print(responseString);
    print('\n\n');
    return responseString;
  }

  static Future<dynamic> getRequest(Map params) async
  {

    var response = await http.post(Uri.parse("${ApiConstants.baseUrl}/includes/process.php"),
        body: params);
    try
    {
      if(response.statusCode == 200)
      {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      }
      else
      {
        return "failed";
      }
    }
    catch(exp)
    {
      return "failed";
    }
  }
}
