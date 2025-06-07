class WebServiceResponse {
  String errorCode = '';
  String message = '';

  WebServiceResponse(this.errorCode, this.message);

  @override
  String toString() {
    return 'WebServiceResponse{errorCode: $errorCode, message: $message}';
  }
}
