
class EmailModel {
  final String sender;
  final String recipient;
  final String subject;
  final String content;

  EmailModel({
    required this.sender,
    required this.recipient,
    required this.subject,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'recipient': recipient,
      'subject': subject,
      'content': content,
    };
  }
}
