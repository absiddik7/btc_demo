import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/discover/discover_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/discover/article/article_card.dart';
import 'package:mybtccanvas/ui/screens/discover/article/article_detail_screen.dart';
import 'package:mybtccanvas/ui/screens/discover/course/course_card.dart';
import 'package:mybtccanvas/ui/screens/discover/course/course_detail_screen.dart';
import 'package:mybtccanvas/ui/screens/discover/discover_explore/content_stack.dart';
import 'package:mybtccanvas/ui/screens/discover/discover_explore/user_card.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final ScrollController _scrollControllerNews = ScrollController();
  final ScrollController _scrollControllerSavedNews = ScrollController();
  

  @override
  void initState() {
    super.initState();
    final discoverProvider = Provider.of<DiscoverProvider>(context, listen: false);
    
    // Set up scroll listeners for both news and saved news
    discoverProvider.onScroll(_scrollControllerNews, discoverProvider.newsCardWidth, "news");
    discoverProvider.onScroll(_scrollControllerSavedNews, discoverProvider.newsCardWidth, "savedNews");
  }

  @override
  dispose() {
    _scrollControllerNews.dispose();
    _scrollControllerSavedNews.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
          child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Consumer2<ThemeProvider, DiscoverProvider>(
          builder: (context, themeProvider, discoverProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstant.appHorizontalPadding,
                      vertical: SizeConstant.appVerticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: kToolbarHeight * 1),
                      Text(context.lang.explore_and_discover,
                          style:
                              AppTextStyles.outfitSB24(color: themeProvider.currentTheme.textPrimaryColor)),
                      const SizedBox(height: SizeConstant.spaceLarge),

                      // User Card
                      const UserCard(),
                    ],
                  ),
                ),

                const SizedBox(height: SizeConstant.spaceSmall),

                Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    height: SizeConstant.stackContainerHeight + 28.0,
                    width: double.infinity,
                    child: ContentStack(
                      courseContentList: discoverProvider.contentList,
                      containerHeight: SizeConstant.stackContainerHeight,
                    )),

                const SizedBox(height: SizeConstant.spaceSmall),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstant.appHorizontalPadding,
                      vertical: SizeConstant.appVerticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.lang.active_courses,
                          style:
                              AppTextStyles.outfitSB24(color: themeProvider.currentTheme.textPrimaryColor)),

                      const SizedBox(height: SizeConstant.spaceMedium),

                      // Active Courses with index
                      Column(
                        children: discoverProvider.activeCourses.asMap().entries.map((entry) {
                          int index = entry.key;
                          var course = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: SizeConstant.spaceSmall),
                            child: InkWell(
                              onTap: () {
                                // Pass the index to open course detail
                                //openCourseDetail(index, course);
                                print("index= ${index.toString()}");
                                Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => CourseDetailScreen(
                                    courseModel: course,
                                    isActiveCourse: true,
                                  ),
                                ));
                              },
                              child: CourseCard(
                                isPopularCourse: false,
                                courseModel: course,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstant.appHorizontalPadding,
                      vertical: SizeConstant.appVerticalPadding),
                  child: Text(context.lang.news,
                      style: AppTextStyles.outfitSB24(color: themeProvider.currentTheme.textPrimaryColor)),
                ),
                const SizedBox(height: SizeConstant.spaceMedium),

                Padding(
                  padding: const EdgeInsets.only(left: SizeConstant.appHorizontalPadding),
                  child: Column(
                    children: [
                      // Horizontal ListView.builder for articles
                      SizedBox(
                        height: discoverProvider.newsCardHeight,
                        child: ListView.builder(
                          controller: _scrollControllerNews,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: discoverProvider.newsArticles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: SizeConstant.paddingMedium),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => NewsArticleDetailScreen(
                                      articleModel: discoverProvider.newsArticles[index],
                                      isSaved: false,
                                      heroTag: "newsArticle$index",
                                    ),
                                  ));
                                },
                                child: ArticleCard(
                                  height: discoverProvider.newsCardHeight,
                                  width: discoverProvider.newsCardWidth,
                                  articleModel: discoverProvider.newsArticles[index],
                                  isSaved: false,
                                  heroTag: "newsArticle$index",
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: SizeConstant.spaceMedium),

                      buildIndicator(discoverProvider.selectedNewsIndex, discoverProvider.newsArticles.length, themeProvider),

                      const SizedBox(height: SizeConstant.spaceLarge),
                    ],
                  ),
                ),

                
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstant.appHorizontalPadding,
                      vertical: SizeConstant.appVerticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.lang.popular_courses,
                          style: AppTextStyles.outfitSB24(color: themeProvider.currentTheme.textPrimaryColor)),

                      const SizedBox(height: SizeConstant.spaceMedium),

                      Column(
                        children: discoverProvider.popularCourses.asMap().entries.map((entry) {
                          int index = entry.key;
                          var course = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: SizeConstant.spaceSmall),
                            child: InkWell(
                              onTap: () {
                                // Pass the index to open course detail
                                //openCourseDetail(index, course);
                                print("index= ${index.toString()}");
                                Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => CourseDetailScreen(
                                    courseModel: course,
                                    isActiveCourse: false,
                                  ),
                                ));
                              },
                              child: CourseCard(
                                isPopularCourse: true,
                                courseModel: course,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 0),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstant.appHorizontalPadding,
                      vertical: SizeConstant.appVerticalPadding),
                  child: Text(context.lang.saved_articles,
                      style: AppTextStyles.outfitSB24(color: themeProvider.currentTheme.textPrimaryColor)),
                ),
                const SizedBox(height: SizeConstant.spaceMedium),

                Padding(
                  padding: const EdgeInsets.only(left: SizeConstant.appHorizontalPadding),
                  child: Column(
                    children: [
                      // Horizontal ListView.builder for articles
                      SizedBox(
                        height: discoverProvider.newsCardHeight,
                        child: ListView.builder(
                          controller: _scrollControllerSavedNews,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: discoverProvider.newsArticles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: SizeConstant.paddingMedium),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => NewsArticleDetailScreen(
                                      articleModel: discoverProvider.newsArticles[index],
                                      isSaved: true,
                                      heroTag: "savedNewsArticle$index",
                                    ),
                                  ));
                                },
                                child: ArticleCard(
                                  height: discoverProvider.newsCardHeight,
                                  width: discoverProvider.newsCardWidth,
                                  articleModel: discoverProvider.newsArticles[index],
                                  isSaved: true,
                                  heroTag: "savedNewsArticle$index",
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: SizeConstant.spaceMedium),

                      buildIndicator(discoverProvider.selectedSavedNewsIndex, discoverProvider.newsArticles.length, themeProvider),

                      const SizedBox(height: SizeConstant.spaceLarge),
                    ],
                  ),
                ),

                const SizedBox(height: SizeConstant.spaceExtraLarge * 2),
              ],
            );
          },
        ),
      )),
    );
  }

  Widget buildIndicator(int activeIndex, int indicatorLength, ThemeProvider themeProvider) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: indicatorLength,
      effect: ScrollingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotScale: 1.8,
        spacing: 10,
        activeDotColor: themeProvider.currentTheme.appThirdColor,
        dotColor: themeProvider.currentTheme.appDarkGreyColor,
      ),
    );
  }
}
