import 'package:flutter/material.dart';



import '../../Models/Article model.dart';
import '../helper/news.dart';
import 'Article view.dart';


class CategoryView extends StatefulWidget {
  final String category;
  final String country;

  const CategoryView(
      {super.key, required this.category, required this.country});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = [];
  bool _loading = true;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getCategoryNews(
        widget.category.toLowerCase(), widget.country);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.category,
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                'News',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading
          ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ))
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
                height: MediaQuery.of(context).size.height *
                    0.85, // Set a specific height for the PageView
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return FadeTransitionPage(
                      pageIndex: index,
                      currentIndex: _currentPage,
                      child: BlogTile(
                        imageUrl: articles[index].urlToImage,
                        description: articles[index].description ?? '',
                        title: articles[index].title ?? '',
                        url: articles[index].url ?? '',
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FadeTransitionPage extends StatelessWidget {
  final int pageIndex;
  final int currentIndex;
  final Widget child;

  FadeTransitionPage({
    required this.pageIndex,
    required this.currentIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double fadeValue = (pageIndex == currentIndex) ? 1.0 : 0.0;
    return AnimatedOpacity(
      opacity: fadeValue,
      duration: Duration(milliseconds: 300),
      child: child,
    );
  }
}

class BlogTile extends StatelessWidget {
  final String? imageUrl, title, description, url;

  BlogTile(
      {required this.imageUrl,
        required this.description,
        required this.title,
        required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), // Rounded top-left corner
                  topRight: Radius.circular(16), // Rounded top-right corner
                ),
                child: (imageUrl != null && imageUrl!.isNotEmpty)
                    ? Image.network(
                  imageUrl!,
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/images/news_img_placeholder.png',
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 60,
            left: 15,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[300],
                // Set your desired background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(8), // Rounded edges for the button
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8), // Adjust padding as needed
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleView(blogUrl: url!),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // Ensures the button size wraps its content
                children: [
                  Text(
                    'Read full article',
                    style: TextStyle(
                      fontSize: 14, // Adjust font size
                      color: Colors.black, // Adjust text color
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.ios_share,
                    size: 20,
                    color: Colors.black, // Adjust icon color
                  ),
                ],
              ),
            )),
      ],
    );
  }
}