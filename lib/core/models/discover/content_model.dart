import 'package:mybtccanvas/core/utils/enums/enum.dart';

class ContentModel {
  final ContentType type;
  final String title;
  final String? url;
  final String subtitle;
  final String description;
  final String imageUrl; 

  ContentModel({
    required this.type,
    required this.title,
    this.url,
    required this.subtitle,
    required this.description,
    required this.imageUrl, 
  });
}
