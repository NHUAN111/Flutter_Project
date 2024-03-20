import 'package:project_specialized_1/data/response/status.dart';

class APIResponse<T> {
  Status? status;
  String? message;
  T? data;

  APIResponse(this.status, this.data, this.message);

  APIResponse.loading() : status = Status.LOADING;
  APIResponse.completed() : status = Status.COMPLETED;
  APIResponse.error() : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
