class ArticleModel {
  String? authorName;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  // DateTime? publishedAt;
  ArticleModel(
      {this.authorName,
        this.url,
        this.description,
        this.title,
        this.content,
        this.urlToImage,
        // this.publishedAt
      });
}