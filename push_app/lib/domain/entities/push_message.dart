// Entidad para hacer un mapeo y saber como luce mi data.

// Ver en README.md Recibir nuestra primera notificación Push
// para entender por qué son estos campos.
class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;

  // Esta data corresponde a los campos opcionales que se envían en una notification push.
  final Map<String, dynamic>? data;

  final String? imageUrl;

  PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sentDate,
    this.data,
    this.imageUrl,
  });

  @override
  String toString() {
    return '''
PushMessage -
  id:        $messageId
  title :    $title
  body :     $body
  sentDate : $sentDate
  data :     $data
  imageUrl : $imageUrl
''';
  }
}
