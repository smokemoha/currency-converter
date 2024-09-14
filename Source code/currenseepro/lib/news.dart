import 'package:flutter/material.dart';

class ExchangeRateArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String content; // New field for article content

  ExchangeRateArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });
}

class ExchangeRateArticlesPage extends StatelessWidget {
  final List<ExchangeRateArticle> articles = [
    ExchangeRateArticle(
      title: 'Understanding Exchange Rates',
      description: 'Learn about the basics of exchange rates and how they impact international trade.',
      imageUrl: 'images/img2.jpeg',
      content: 'This is the content of the first article. You can replace this with your actual article content.',
    ),
    ExchangeRateArticle(
      title: 'Factors Affecting Currency Exchange Rates',
      description: 'Explore the various factors that influence currency exchange rates in the global market.',
      imageUrl: 'images/img1.png',
      content: 'This is the content of the second article. You can replace this with your actual article content.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange Rate Articles'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ExchangeRateArticleCard(article: articles[index]),
          );
        },
      ),
    );
  }
}

class ExchangeRateArticleCard extends StatelessWidget {
  final ExchangeRateArticle article;

  const ExchangeRateArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticlePage(article: article)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                article.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  final ExchangeRateArticle article;

  const ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              article.content,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
