class MessageModel {
  final bool isSuccess;
  final String message;

  MessageModel({required this.isSuccess, required this.message});

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
        isSuccess: jsonData['success'], message: jsonData['message']);
  }
}
