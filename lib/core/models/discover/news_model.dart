class ArticleModel {
  final int articleId;
  final String articleTitle;
  final String articleSubtitle;
  final String articleDescription;
  final String articleImage;
  final String createdBy;
  final int totalreaction;
  final List<String> articleChips;

  ArticleModel({
    required this.articleId, 
    required this.articleTitle, 
    required this.articleSubtitle, 
    required this.articleDescription,
    required this.articleImage, 
    required this.createdBy, 
    required this.totalreaction,
    required this.articleChips
  });
}