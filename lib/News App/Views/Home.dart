import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Article model.dart';
import '../../Models/Category model.dart';
import '../Helper/Datas.dart';
import '../Helper/News.dart';

import '../Screens/Feedback.dart';
import 'Article view.dart';
import 'Category view.dart';

class Home extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final String email = '';

  const Home({Key? key, required this.toggleTheme, required this.isDarkMode, required String email})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  String selectedCountry = 'us';
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews(selectedCountry);
  }

  getNews(String countryCode) async {
    setState(() {
      _loading = true;
    });

    News newsClassObject = News();
    print("Fetching news for country code: $countryCode");
    await newsClassObject.getAllNews(countryCode);

    if (newsClassObject.news.isEmpty) {
      setState(() {
        _loading = false;
        articles = [];
      });
    } else {
      setState(() {
        articles = newsClassObject.news;
        _loading = false;
      });
    }
  }

  /// Callback for when the user selects a country from the drawer
  void onCountrySelected(String countryCode) {
    if (countryCode != selectedCountry) {
      setState(() {
        selectedCountry = countryCode;
      });
      getNews(countryCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        email: widget.email,
        toggleTheme: widget.toggleTheme,
        isDarkMode: widget.isDarkMode,
        onCountrySelected: onCountrySelected,
      ),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'H',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '&',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'N',
                style:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading
          ? Center(
          child: Container(
            child: const CircularProgressIndicator(),
          ))
          : articles.isEmpty
          ? Center(child: Text('No news available for this country.'))
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Categories
              Container(
                height: 70,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                        selectedCountry: selectedCountry,
                      );
                    }),
              ),

              /// Blogs
              Container(
                padding: const EdgeInsets.only(top: 16),
                height: MediaQuery.of(context).size.height *
                    0.78,
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
                        description:
                        articles[index].description ?? '',
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

class CustomDrawer extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;
  final Function(String) onCountrySelected;
  final String email;

  const CustomDrawer({
    Key? key,
    required this.toggleTheme,
    required this.isDarkMode,
    required this.onCountrySelected,
    required this.email
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? selectedCountryCode;

  final Map<String, String> countryNames = {
    'au': 'Australia',
    'br': 'Brazil',
    'ca': 'Canada',
    'cn': 'China',
    'eg': 'Egypt',
    'fr': 'France',
    'de': 'Germany',
    'gr': 'Greece',
    'hk': 'Hong Kong',
    'in': 'India',
    'ie': 'Ireland',
    'il': 'Israel',
    'it': 'Italy',
    'jp': 'Japan',
    'nl': 'Netherlands',
    'no': 'Norway',
    'pk': 'Pakistan',
    'pe': 'Peru',
    'ph': 'Philippines',
    'pt': 'Portugal',
    'ro': 'Romania',
    'ru': 'Russian Federation',
    'sg': 'Singapore',
    'es': 'Spain',
    'se': 'Sweden',
    'ch': 'Switzerland',
    'tw': 'Taiwan',
    'ua': 'Ukraine',
    'gb': 'United Kingdom',
    'us': 'United States'
  };

  final emailAddress = FirebaseAuth.instance.currentUser?.email;


  @override
  void initState() {
    super.initState();
    _loadSavedCountry();
  }

  // Load the saved country from SharedPreferences
  void _loadSavedCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCountryCode =
          prefs.getString('selectedCountry') ?? 'us'; // Default to 'us'
    });
  }

  // Save the selected country to SharedPreferences
  void _saveCountry(String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCountry', countryCode);
    setState(() {
      selectedCountryCode = countryCode;
    });
    widget.onCountrySelected(countryCode); // Notify the parent widget
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 20,
                      top: 20,
                      child: Text(
                        'Explore App',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 15,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height - 590),
              _buildDrawerItem(context, Icons.bookmark_outline, 'Saved Items'),
              const SizedBox(height: 8),
              _buildDrawerItem(
                context,
                Icons.dark_mode_outlined,
                'Appearance',
                trailingSwitch: true,
                switchValue: widget.isDarkMode,
                onTap: () {
                  widget.toggleTheme(); // Switch between light and dark theme
                },
              ),
              const SizedBox(height: 8),
              const Divider(),
              _buildCountryDropdown(),
              const SizedBox(height: 8),
              _buildDrawerItem(context, Icons.feedback_outlined, 'Feedback',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()))),
              const SizedBox(height: 8),
              _buildDrawerItem(context, Icons.account_circle, '$emailAddress'),
              const SizedBox(height: 8),
              _buildDrawerItem(context, Icons.exit_to_app, 'Log Out'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Select Country:  '),
          Expanded(
            child: DropdownButton<String>(
              value: selectedCountryCode,
              isExpanded: true,
              items: countryNames.entries
                  .map((entry) => DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value,
                  style: const TextStyle(fontSize: 14),
                ),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _saveCountry(value);
                  Navigator.pop(context); // Close the drawer
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title,
      {bool trailingSwitch = false,
        bool switchValue = false,
        Function? onTap}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: trailingSwitch
            ? Switch(
          value: switchValue,
          onChanged: (_) {
            if (onTap != null)
              onTap();
          },
        )
            : null,
        onTap: () {
          if (onTap != null) onTap();
        },
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  final String selectedCountry;

  CategoryTile({
    this.imageUrl,
    this.categoryName,
    required this.selectedCountry,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryView(
                  category: categoryName.toString(),
                  country: selectedCountry,
                )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
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
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(8), // Rounded edges for the button
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
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
                children: [
                  Text(
                    'Read full article',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.ios_share,
                    size: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}