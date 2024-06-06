import 'package:admin/api_package/delete_servers/delete_api/delete_api.dart';
import 'package:dio/dio.dart';

class DeleteServers {
  static late final DeleteServers instance;
  Delete delete = Delete();

  Future<String> deleteDoctor(String id) async {
    Response response = await delete.deleteDoctor(id);

    try {
      switch (response.statusCode) {
        case 201:
          return "Deleted Successfully";

        case 404:
          return "Doctor not found";

        default:
          return "There is an error";
      }
    } on DioException {
      return "There is an error";
    }
  }

  Future<String> deleteUser(String id) async {
    try {
      Response response = await delete.deleteUser(id);
      switch (response.statusCode) {
        case 201:
          return "Deleted Successfully";

        case 404:
          return "Doctor not found";

        default:
          return "There is an error";
      }
    } on DioException {
      return "There is an error";
    }
  }
}
