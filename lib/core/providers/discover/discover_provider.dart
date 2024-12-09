import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/models/discover/content_model.dart';
import 'package:mybtccanvas/core/models/discover/course_model.dart';
import 'package:mybtccanvas/core/models/discover/news_model.dart';
import 'package:mybtccanvas/core/models/discover/quiz_model.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';

class DiscoverProvider extends ChangeNotifier {
  int _selectedNewsIndex = 0;
  int _selectedSavedNewsIndex = 0;
  final double _newsCardHeight = 380.0;
  final double _newsCardWidth = 330.0;

  // Getters
  List<ArticleModel> get newsArticles => _newsArticles;
  List<ArticleModel> get savedNewsArticles => _newsArticles;
  int get selectedNewsIndex => _selectedNewsIndex;
  int get selectedSavedNewsIndex => _selectedSavedNewsIndex;
  double get newsCardHeight => _newsCardHeight;
  double get newsCardWidth => _newsCardWidth;

  // Method to update the index based on scroll position for news
  void updateNewsScrollPosition(double scrollPosition, double itemWidth) {
    int currentPageIndex = (scrollPosition / itemWidth).round();
    _selectedNewsIndex = currentPageIndex;
    notifyListeners();
  }

  // Method to update the index based on scroll position for saved news
  void updateSavedNewsScrollPosition(double scrollPosition, double itemWidth) {
    int currentPageIndex = (scrollPosition / itemWidth).round();
    _selectedSavedNewsIndex = currentPageIndex;
    notifyListeners();
  }

  // Unified method to handle scrolling for both news and saved news
  void onScroll(ScrollController scrollController, double itemWidth, String type) {
    scrollController.addListener(() {
      double currentScrollPosition = scrollController.position.pixels;
      if (type == "news") {
        updateNewsScrollPosition(currentScrollPosition, itemWidth);
      } else if (type == "savedNews") {
        updateSavedNewsScrollPosition(currentScrollPosition, itemWidth);
      }
    });
  }





  bool _isVideoDescExpandMore = false;
  bool get isVideoDescExpandMore => _isVideoDescExpandMore;
  void initVideoDescExpand(bool value) {
    _isVideoDescExpandMore = value;
    notifyListeners();
  }
  void toggleVideoDescExpanded() {
    _isVideoDescExpandMore = !_isVideoDescExpandMore;
    notifyListeners();
  }

  List<CourseModel> get activeCourses => _activeCourses;
  List<CourseModel> get popularCourses => _popularCourses;

  // int _selectedNewsIndex = 0;

  // int get selectedNewsIndex => _selectedNewsIndex;

  // void updateSelectedNewsIndex(int newIndex) {
  //   _selectedNewsIndex = newIndex;
  //   notifyListeners();
  // }

  // List of active courses
  final List<CourseModel> _activeCourses = [
    CourseModel(
      courseId: 1001,
      courseTitle: "Bitcoin Basics",
      courseSubtitle: "Learn the fundamentals of Bitcoin and cryptocurrency.",
      courseCategory: "Cryptocurrency",
      courseThumbnail: "https://img.freepik.com/free-vector/cryptocurrency-bitcoin-golden-coin-background_1017-31505.jpg",
      totalDuration: 15.5,  // Total duration in hours
      numberOfVideos: 12,
      courseProgress: 0.6,  // Progress as a percentage
      numberOfUsers: 250,
      enrolledUserImages: [
        "https://i.imgur.com/7vHh1kj.png",
        "https://i.imgur.com/4eE2Fui.png",
        "https://i.imgur.com/R6TjYbH.png"
      ],
      sections: [
        SectionModel(
          sectionId: 1,
          sectionTitle: "Introduction to Bitcoin",
          sectionDescription: "Learn the basics of Bitcoin and how it has evolved over time.",
          videos: [
            VideoModel(
              videoId: 1,
              videoTitle: "What is Bitcoin?",
              videoDescription: "Bitcoin is a decentralized digital currency, created in 2009 by an unknown individual or group of individuals using the pseudonym Satoshi Nakamoto. Unlike traditional currencies, Bitcoin operates on a peer-to-peer network, meaning there is no central authority like a government or financial institution controlling it. Transactions are verified by network nodes through cryptography and recorded on a public ledger known as the blockchain. One of Bitcoin's key features is its limited supply—only 21 million bitcoins can ever be created. This scarcity is designed to simulate precious metals like gold, making Bitcoin a store of value. Another notable feature is its decentralization, which provides users with autonomy over their assets without reliance on third-party intermediaries. Bitcoin also ensures pseudonymity, meaning transactions are linked to a wallet address rather than a personal identity, providing a level of privacy. Additionally, Bitcoin transactions are irreversible, reducing the risk of fraud for merchants. The blockchain technology behind Bitcoin ensures security and transparency, with transactions being immutable once confirmed. Bitcoins global accessibility allows anyone with an internet connection to participate, regardless of location or banking status. Lastly, Bitcoin has inspired the creation of thousands of other cryptocurrencies, known as altcoins, contributing to the growing ecosystem of digital assets.",
              videoUrl: "https://www.youtube.com/watch?v=Gc2en3nHxA4",
              videoThumbnail: "https://img.youtube.com/vi/Gc2en3nHxA4/hqdefault.jpg",
              videoDuration: 600,  // Duration in seconds
              lastWatchedPosition: 600,
            ),
            VideoModel(
              videoId: 2,
              videoTitle: "History of Bitcoin",
              videoDescription: "Discover the incredible journey of Bitcoin, the first decentralized digital currency, from its creation in 2009 by the mysterious Satoshi Nakamoto to its impact on the global financial system. This video explores the key moments in Bitcoin's development, including its early adoption by tech enthusiasts, the rise of cryptocurrency exchanges, and its use as a store of value. Learn about Bitcoin's role in the evolution of blockchain technology, its influence on financial innovation, and the challenges it has faced, from regulation to market volatility. Whether you're new to Bitcoin or a seasoned enthusiast, this video offers a comprehensive look at its history and enduring impact.",
              videoUrl: "https://www.youtube.com/watch?v=2F-4D5GgU-U",
              videoThumbnail: "https://img.youtube.com/vi/2F-4D5GgU-U/hqdefault.jpg",
              videoDuration: 900,
              lastWatchedPosition: 300,
            ),
          ],
        ),
        SectionModel(
          sectionId: 2,
          sectionTitle: "How Bitcoin Works",
          sectionDescription: "Understand the technology behind Bitcoin and how it functions.",
          videos: [
            VideoModel(
              videoId: 3,
              videoTitle: "Understanding Blockchain",
              videoDescription: "Dive into the fundamentals of blockchain technology, the revolutionary system behind Bitcoin and many other cryptocurrencies. This video offers an in-depth explanation of how blockchain works, including its decentralized structure, cryptographic security, and how it enables transparent and immutable transactions. Explore the key components such as blocks, nodes, and consensus mechanisms, and understand how blockchain ensures trust without the need for intermediaries. We also examine the broader applications of blockchain beyond cryptocurrency, from supply chain management to smart contracts, and its potential to transform various industries.",
              videoUrl: "https://www.youtube.com/watch?v=SSo_EIwHSWc",
              videoThumbnail: "https://img.youtube.com/vi/SSo_EIwHSWc/hqdefault.jpg",
              videoDuration: 1200,
              lastWatchedPosition: 0,
            ),
            VideoModel(
              videoId: 4,
              videoTitle: "Mining Bitcoin",
              videoDescription: "Explore the fascinating process of Bitcoin mining, the method by which new bitcoins are created and transactions are verified on the blockchain. This video explains how miners use powerful computers to solve complex cryptographic puzzles, securing the Bitcoin network while earning rewards in the form of new bitcoins. Learn about the importance of mining in maintaining the decentralized nature of Bitcoin, the role of proof-of-work, and how mining difficulty adjusts over time. We also cover the evolution of mining technology, from CPUs to specialized ASIC machines, and discuss the environmental impact and energy consumption of Bitcoin mining.",
              videoUrl: "https://www.youtube.com/watch?v=H1a4VY2LQ8Y",
              videoThumbnail: "https://img.youtube.com/vi/H1a4VY2LQ8Y/hqdefault.jpg",
              videoDuration: 800,
              lastWatchedPosition: 200,
            ),
          ],
        ),
      ],
    ),
    CourseModel(
      courseId: 1002,
      courseTitle: "Advanced Bitcoin Trading",
      courseSubtitle: "Strategies and techniques for trading Bitcoin.",
      courseCategory: "Cryptocurrency",
      courseThumbnail: "https://www.investopedia.com/thmb/zgjRJ5Joirye-VvUCxCU3l6GP6o=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-2070086171-083d1a9e4d464f658ed24e91017aa2fc.jpg",
      totalDuration: 200.0,
      numberOfVideos: 10,
      courseProgress: 0.4,
      numberOfUsers: 180,
      enrolledUserImages: [
        "https://i.imgur.com/7vHh1kj.png",
        "https://i.imgur.com/4eE2Fui.png",
        "https://i.imgur.com/R6TjYbH.png"
      ],
      sections: [
        SectionModel(
          sectionId: 1,
          sectionTitle: "Trading Strategies",
          sectionDescription: "Learn advanced trading strategies for Bitcoin and other cryptocurrencies.",
          videos: [
            VideoModel(
              videoId: 1,
              videoTitle: "Technical Analysis for Bitcoin",
              videoDescription: "An in-depth look at technical analysis techniques for trading Bitcoin.",
              videoUrl: "https://www.youtube.com/watch?v=VwD1t3bAB9E",
              videoThumbnail: "https://img.youtube.com/vi/VwD1t3bAB9E/hqdefault.jpg",
              videoDuration: 750,
              lastWatchedPosition: 0,
            ),
            VideoModel(
              videoId: 2,
              videoTitle: "Fundamental Analysis",
              videoDescription: "Understand the fundamentals of trading and how they apply to Bitcoin.",
              videoUrl: "https://www.youtube.com/watch?v=qfFn9iq3qYY",
              videoThumbnail: "https://img.youtube.com/vi/qfFn9iq3qYY/hqdefault.jpg",
              videoDuration: 900,
              lastWatchedPosition: 300,
            ),
          ],
        ),
      ],
    ),
    CourseModel(
      courseId: 1003,
      courseTitle: "Investing in Bitcoin",
      courseSubtitle: "A comprehensive guide to investing in Bitcoin.",
      courseCategory: "Cryptocurrency",
      courseThumbnail: "https://www.bankrate.com/2022/07/07151503/Cryptocurrency-statistics.jpeg?auto=webp&optimize=high&crop=16:9",
      totalDuration: 160.0,
      numberOfVideos: 15,
      courseProgress: 0.2,
      numberOfUsers: 150,
      enrolledUserImages: [
        "https://i.imgur.com/7vHh1kj.png",
        "https://i.imgur.com/4eE2Fui.png",
        "https://i.imgur.com/R6TjYbH.png"
      ],
      sections: [
        SectionModel(
          sectionId: 1,
          sectionTitle: "Getting Started with Bitcoin",
          sectionDescription: "Learn how to buy, store, and invest in Bitcoin.",
          videos: [
            VideoModel(
              videoId: 1,
              videoTitle: "How to Buy Bitcoin",
              videoDescription: "A step-by-step guide to purchasing Bitcoin for the first time.",
              videoUrl: "https://www.youtube.com/watch?v=nvCkc_9t2pI",
              videoThumbnail: "https://img.youtube.com/vi/nvCkc_9t2pI/hqdefault.jpg",
              videoDuration: 600,
              lastWatchedPosition: 0,
            ),
            VideoModel(
              videoId: 2,
              videoTitle: "Setting Up a Wallet",
              videoDescription: "Learn how to store your Bitcoin securely in a digital wallet.",
              videoUrl: "https://www.youtube.com/watch?v=Z5l9N1Zr7D0",
              videoThumbnail: "https://img.youtube.com/vi/Z5l9N1Zr7D0/hqdefault.jpg",
              videoDuration: 480,
              lastWatchedPosition: 200,
            ),
          ],
        ),
      ],
    ),
  ];

  // List of popular courses
  final List<CourseModel> _popularCourses = [
    CourseModel(
      courseId: 1001,
      courseTitle: "Bitcoin Basics",
      courseSubtitle: "Learn the fundamentals of Bitcoin and cryptocurrency.",
      courseCategory: "Cryptocurrency",
      courseThumbnail: "https://img.freepik.com/free-vector/cryptocurrency-bitcoin-golden-coin-background_1017-31505.jpg",
      totalDuration: 15.5,  // Total duration in hours
      numberOfVideos: 12,
      courseProgress: 0.6,  // Progress as a percentage
      numberOfUsers: 250,
      enrolledUserImages: [
        "https://i.imgur.com/7vHh1kj.png",
        "https://i.imgur.com/4eE2Fui.png",
        "https://i.imgur.com/R6TjYbH.png"
      ],
      sections: [
        SectionModel(
          sectionId: 1,
          sectionTitle: "Introduction to Bitcoin",
          sectionDescription: "Learn the basics of Bitcoin and how it has evolved over time.",
          videos: [
            VideoModel(
              videoId: 1,
              videoTitle: "What is Bitcoin?",
              videoDescription: "Bitcoin is a decentralized digital currency, created in 2009 by an unknown individual or group of individuals using the pseudonym Satoshi Nakamoto. Unlike traditional currencies, Bitcoin operates on a peer-to-peer network, meaning there is no central authority like a government or financial institution controlling it. Transactions are verified by network nodes through cryptography and recorded on a public ledger known as the blockchain. One of Bitcoin's key features is its limited supply—only 21 million bitcoins can ever be created. This scarcity is designed to simulate precious metals like gold, making Bitcoin a store of value. Another notable feature is its decentralization, which provides users with autonomy over their assets without reliance on third-party intermediaries. Bitcoin also ensures pseudonymity, meaning transactions are linked to a wallet address rather than a personal identity, providing a level of privacy. Additionally, Bitcoin transactions are irreversible, reducing the risk of fraud for merchants. The blockchain technology behind Bitcoin ensures security and transparency, with transactions being immutable once confirmed. Bitcoins global accessibility allows anyone with an internet connection to participate, regardless of location or banking status. Lastly, Bitcoin has inspired the creation of thousands of other cryptocurrencies, known as altcoins, contributing to the growing ecosystem of digital assets.",
              videoUrl: "https://www.youtube.com/watch?v=Gc2en3nHxA4",
              videoThumbnail: "https://img.youtube.com/vi/Gc2en3nHxA4/hqdefault.jpg",
              videoDuration: 600,  // Duration in seconds
              lastWatchedPosition: 600,
            ),
            VideoModel(
              videoId: 2,
              videoTitle: "History of Bitcoin",
              videoDescription: "Discover the incredible journey of Bitcoin, the first decentralized digital currency, from its creation in 2009 by the mysterious Satoshi Nakamoto to its impact on the global financial system. This video explores the key moments in Bitcoin's development, including its early adoption by tech enthusiasts, the rise of cryptocurrency exchanges, and its use as a store of value. Learn about Bitcoin's role in the evolution of blockchain technology, its influence on financial innovation, and the challenges it has faced, from regulation to market volatility. Whether you're new to Bitcoin or a seasoned enthusiast, this video offers a comprehensive look at its history and enduring impact.",
              videoUrl: "https://www.youtube.com/watch?v=2F-4D5GgU-U",
              videoThumbnail: "https://img.youtube.com/vi/2F-4D5GgU-U/hqdefault.jpg",
              videoDuration: 900,
              lastWatchedPosition: 300,
            ),
          ],
        ),
        SectionModel(
          sectionId: 2,
          sectionTitle: "How Bitcoin Works",
          sectionDescription: "Understand the technology behind Bitcoin and how it functions.",
          videos: [
            VideoModel(
              videoId: 3,
              videoTitle: "Understanding Blockchain",
              videoDescription: "Dive into the fundamentals of blockchain technology, the revolutionary system behind Bitcoin and many other cryptocurrencies. This video offers an in-depth explanation of how blockchain works, including its decentralized structure, cryptographic security, and how it enables transparent and immutable transactions. Explore the key components such as blocks, nodes, and consensus mechanisms, and understand how blockchain ensures trust without the need for intermediaries. We also examine the broader applications of blockchain beyond cryptocurrency, from supply chain management to smart contracts, and its potential to transform various industries.",
              videoUrl: "https://www.youtube.com/watch?v=SSo_EIwHSWc",
              videoThumbnail: "https://img.youtube.com/vi/SSo_EIwHSWc/hqdefault.jpg",
              videoDuration: 1200,
              lastWatchedPosition: 0,
            ),
            VideoModel(
              videoId: 4,
              videoTitle: "Mining Bitcoin",
              videoDescription: "Explore the fascinating process of Bitcoin mining, the method by which new bitcoins are created and transactions are verified on the blockchain. This video explains how miners use powerful computers to solve complex cryptographic puzzles, securing the Bitcoin network while earning rewards in the form of new bitcoins. Learn about the importance of mining in maintaining the decentralized nature of Bitcoin, the role of proof-of-work, and how mining difficulty adjusts over time. We also cover the evolution of mining technology, from CPUs to specialized ASIC machines, and discuss the environmental impact and energy consumption of Bitcoin mining.",
              videoUrl: "https://www.youtube.com/watch?v=H1a4VY2LQ8Y",
              videoThumbnail: "https://img.youtube.com/vi/H1a4VY2LQ8Y/hqdefault.jpg",
              videoDuration: 800,
              lastWatchedPosition: 200,
            ),
          ],
        ),
      ],
    ),
    CourseModel(
      courseId: 1002,
      courseTitle: "Advanced Bitcoin Trading",
      courseSubtitle: "Strategies and techniques for trading Bitcoin.",
      courseCategory: "Cryptocurrency",
      courseThumbnail: "https://www.investopedia.com/thmb/zgjRJ5Joirye-VvUCxCU3l6GP6o=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-2070086171-083d1a9e4d464f658ed24e91017aa2fc.jpg",
      totalDuration: 200.0,
      numberOfVideos: 10,
      courseProgress: 0.4,
      numberOfUsers: 180,
      enrolledUserImages: [
        "https://i.imgur.com/7vHh1kj.png",
        "https://i.imgur.com/4eE2Fui.png",
        "https://i.imgur.com/R6TjYbH.png"
      ],
      sections: [
        SectionModel(
          sectionId: 1,
          sectionTitle: "Trading Strategies",
          sectionDescription: "Learn advanced trading strategies for Bitcoin and other cryptocurrencies.",
          videos: [
            VideoModel(
              videoId: 1,
              videoTitle: "Technical Analysis for Bitcoin",
              videoDescription: "Master the art of trading Bitcoin with this comprehensive guide to technical analysis. This video delves into key techniques used by traders to predict price movements and make informed decisions in the volatile cryptocurrency market. Learn how to read Bitcoin price charts, identify trends, and use popular indicators like moving averages, RSI, and MACD. We also cover support and resistance levels, candlestick patterns, and the importance of volume in trading. Whether you're a beginner or an experienced trader, this video provides valuable insights to help you enhance your Bitcoin trading strategies.",
              videoUrl: "https://www.youtube.com/watch?v=VwD1t3bAB9E",
              videoThumbnail: "https://img.youtube.com/vi/VwD1t3bAB9E/hqdefault.jpg",
              videoDuration: 750,
              lastWatchedPosition: 0,
            ),
            VideoModel(
              videoId: 2,
              videoTitle: "Fundamental Analysis",
              videoDescription: "Gain a deeper understanding of Bitcoin trading through fundamental analysis. This video explores the core principles of evaluating an asset’s intrinsic value and how they apply to Bitcoin. Learn how factors such as market demand, adoption rates, technological developments, regulation, and macroeconomic trends can impact Bitcoin’s price. We break down key metrics like Bitcoin's network activity, market capitalization, and scarcity, along with external influences such as government policies and institutional investments. Whether you're new to fundamental analysis or looking to refine your skills, this video offers essential insights for making informed Bitcoin trading decisions.",
              videoUrl: "https://www.youtube.com/watch?v=qfFn9iq3qYY",
              videoThumbnail: "https://img.youtube.com/vi/qfFn9iq3qYY/hqdefault.jpg",
              videoDuration: 900,
              lastWatchedPosition: 300,
            ),
          ],
        ),
      ],
    ),
  ];

  // List of newses
  final List<ArticleModel> _newsArticles = [
    ArticleModel(
      articleId: 5001,
      articleTitle: "Bitcoin's Role in the Future of Finance",
      articleSubtitle: "Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system.",
      articleDescription: "Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system. Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system. Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system. Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system. Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system.",
      articleImage: "https://img.freepik.com/free-vector/cryptocurrency-bitcoin-golden-coin-background_1017-31505.jpg",
      createdBy: "John Doe",
      totalreaction: 1500,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5002,
      articleTitle: "Why Bitcoin is Volatile: A Deep Dive",
      articleSubtitle: "Understanding the reasons behind Bitcoin's price volatility and what it means for investors.",
      articleDescription: "Understanding the reasons behind Bitcoin's price volatility and what it means for investors. Understanding the reasons behind Bitcoin's price volatility and what it means for investors. Understanding the reasons behind Bitcoin's price volatility and what it means for investors. Understanding the reasons behind Bitcoin's price volatility and what it means for investors. Understanding the reasons behind Bitcoin's price volatility and what it means for investors.",
      articleImage: "https://www.investopedia.com/thmb/zgjRJ5Joirye-VvUCxCU3l6GP6o=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-2070086171-083d1a9e4d464f658ed24e91017aa2fc.jpg",
      createdBy: "Jane Smith",
      totalreaction: 890,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5003,
      articleTitle: "Bitcoin vs. Traditional Currencies",
      articleSubtitle: "Comparing Bitcoin to traditional fiat currencies and the future of digital money.",
      articleDescription: "Comparing Bitcoin to traditional fiat currencies and the future of digital money. Comparing Bitcoin to traditional fiat currencies and the future of digital money. Comparing Bitcoin to traditional fiat currencies and the future of digital money. Comparing Bitcoin to traditional fiat currencies and the future of digital money. Comparing Bitcoin to traditional fiat currencies and the future of digital money.",
      articleImage: "https://www.bankrate.com/2022/07/07151503/Cryptocurrency-statistics.jpeg?auto=webp&optimize=high&crop=16:9",
      createdBy: "Satoshi Nakamoto",
      totalreaction: 2200,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5004,
      articleTitle: "Is Bitcoin a Good Investment in 2024?",
      articleSubtitle: "Analyzing Bitcoin's investment potential in 2024 and the risks involved.",
      articleDescription: "Analyzing Bitcoin's investment potential in 2024 and the risks involved. Analyzing Bitcoin's investment potential in 2024 and the risks involved. Analyzing Bitcoin's investment potential in 2024 and the risks involved. Analyzing Bitcoin's investment potential in 2024 and the risks involved.",
      articleImage: "https://helios-i.mashable.com/imagery/articles/04ldy4kWWpLv9ccOUPseqIo/hero-image.fill.size_1248x702.v1647386540.jpg",
      createdBy: "Elon Musker",
      totalreaction: 3200,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5005,
      articleTitle: "Environmental Impact of Bitcoin Mining",
      articleSubtitle: "A look at the environmental concerns surrounding Bitcoin mining and potential solutions.",
      articleDescription: "A look at the environmental concerns surrounding Bitcoin mining and potential solutions. A look at the environmental concerns surrounding Bitcoin mining and potential solutions. A look at the environmental concerns surrounding Bitcoin mining and potential solutions. A look at the environmental concerns surrounding Bitcoin mining and potential solutions. A look at the environmental concerns surrounding Bitcoin mining and potential solutions.",
      articleImage: "https://media1.riverfronttimes.com/riverfronttimes/imager/u/blog/42128365/image8.png?cb=1721834628",
      createdBy: "Greta Green",
      totalreaction: 680,
      articleChips: ["Price action", "Investor sentiment"]
    ),

    ArticleModel(
      articleId: 5006,
      articleTitle: "Bitcoin's Role in the Future of Finance",
      articleSubtitle: "Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system.",
      articleDescription: "Exploring how Bitcoin and other cryptocurrencies are shaping the future of the global financial system.",
      articleImage: "https://img.freepik.com/free-vector/cryptocurrency-bitcoin-golden-coin-background_1017-31505.jpg",
      createdBy: "John Doe",
      totalreaction: 1500,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5007,
      articleTitle: "Why Bitcoin is Volatile: A Deep Dive",
      articleSubtitle: "Understanding the reasons behind Bitcoin's price volatility and what it means for investors.",
      articleDescription: "Understanding the reasons behind Bitcoin's price volatility and what it means for investors.",
      articleImage: "https://www.investopedia.com/thmb/zgjRJ5Joirye-VvUCxCU3l6GP6o=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-2070086171-083d1a9e4d464f658ed24e91017aa2fc.jpg",
      createdBy: "Jane Smith",
      totalreaction: 890,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5008,
      articleTitle: "Bitcoin vs. Traditional Currencies",
      articleSubtitle: "Comparing Bitcoin to traditional fiat currencies and the future of digital money.",
      articleDescription: "Comparing Bitcoin to traditional fiat currencies and the future of digital money.",
      articleImage: "https://www.bankrate.com/2022/07/07151503/Cryptocurrency-statistics.jpeg?auto=webp&optimize=high&crop=16:9",
      createdBy: "Satoshi Nakamoto",
      totalreaction: 2200,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5009,
      articleTitle: "Is Bitcoin a Good Investment in 2024?",
      articleSubtitle: "Analyzing Bitcoin's investment potential in 2024 and the risks involved.",
      articleDescription: "Analyzing Bitcoin's investment potential in 2024 and the risks involved.",
      articleImage: "https://helios-i.mashable.com/imagery/articles/04ldy4kWWpLv9ccOUPseqIo/hero-image.fill.size_1248x702.v1647386540.jpg",
      createdBy: "Elon Musker",
      totalreaction: 3200,
      articleChips: ["Price action", "Investor sentiment"]
    ),
    ArticleModel(
      articleId: 5010,
      articleTitle: "Environmental Impact of Bitcoin Mining",
      articleSubtitle: "A look at the environmental concerns surrounding Bitcoin mining and potential solutions.",
      articleDescription: "A look at the environmental concerns surrounding Bitcoin mining and potential solutions.",
      articleImage: "https://media1.riverfronttimes.com/riverfronttimes/imager/u/blog/42128365/image8.png?cb=1721834628",
      createdBy: "Greta Green",
      totalreaction: 680,
      articleChips: ["Price action", "Investor sentiment"]
    ),
  ];


  // Example list containing various content types with title, subtitle, etc.
  final List<ContentModel> _contentList = [
    ContentModel(
      type: ContentType.video,
      title: 'What is Bitcoin?',
      url: 'https://drive.google.com/uc?export=download&id=1eO1dwFu1GY66N8cEckRmIBT7mMNnQlnJ', 
      subtitle: 'Bitcoin Explained',
      description: 'This video explains the basics of Bitcoin and how it works.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png', 
    ),
    ContentModel(
      type: ContentType.text,
      title: 'Introduction to Bitcoin',
      url: 'https://drive.google.com/uc?export=download&id=1eO1dwFu1GY66N8cEckRmIBT7mMNnQlnJ', 
      subtitle: 'Learn the basics of Bitcoin',
      description: 'Bitcoin is a decentralized digital currency, created in 2009 by an unknown individual or group of individuals using the pseudonym Satoshi Nakamoto. Unlike traditional currencies, Bitcoin operates on a peer-to-peer network, meaning there is no central authority like a government or financial institution controlling it. Transactions are verified by network nodes through cryptography and recorded on a public ledger known as the blockchain. One of Bitcoin\'s key features is its limited supply—only 21 million bitcoins can ever be created. This scarcity is designed to simulate precious metals like gold, making Bitcoin a store of value. Another notable feature is its decentralization, which provides users with autonomy over their assets without reliance on third-party intermediaries. Bitcoin also ensures pseudonymity, meaning transactions are linked to a wallet address rather than a personal identity, providing a level of privacy. Additionally, Bitcoin transactions are irreversible, reducing the risk of fraud for merchants. The blockchain technology behind Bitcoin ensures security and transparency, with transactions being immutable once confirmed. Bitcoins global accessibility allows anyone with an internet connection to participate, regardless of location or banking status. Lastly, Bitcoin has inspired the creation of thousands of other cryptocurrencies, known as altcoins, contributing to the growing ecosystem of digital assets.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png',
    ),
    ContentModel(
      type: ContentType.text,
      title: 'Importance of Bitcoin',
      url: 'https://drive.google.com/uc?export=download&id=1eO1dwFu1GY66N8cEckRmIBT7mMNnQlnJ', 
      subtitle: 'Why Bitcoin Matters',
      description: 'Bitcoin has emerged as a revolutionary technology that has the potential to transform the global financial system. Its decentralized nature and limited supply make it a unique asset class that offers a hedge against inflation and economic uncertainty. Bitcoin provides financial freedom to individuals by allowing them to store and transfer value without the need for intermediaries. Its pseudonymous and censorship-resistant properties ensure privacy and security for users around the world. Bitcoin has also become a popular investment choice for individuals and institutions seeking exposure to digital assets. As the first cryptocurrency, Bitcoin has paved the way for the development of thousands of other cryptocurrencies and blockchain projects. Its underlying technology, blockchain, has applications beyond finance, including supply chain management, voting systems, and decentralized applications. Bitcoin\'s impact on the financial landscape is undeniable, and its future potential continues to attract interest and investment from a wide range of stakeholders.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png', 
    ),
    ContentModel(
      type: ContentType.button,
      title: 'Getting Started',
      url: 'https://bitcoin.org/',
      subtitle: 'Visit Our Website',
      description: 'Click the button below to visit our website and learn more about Bitcoin.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png', 
    ),
  ];

  List<ContentModel> get contentList => _contentList;






  // quiz data

  int currentQuestionIndex = 0;
  Map<int, int> selectedAnswersById = {}; // Store answers by questionId

  // correct answers and incorrect answers
  int _correctAnsCount = 0;
  int _incorrectAnsCount = 0;
  int _pointsPerQuestion = 5;

  int get correctAnsCount => _correctAnsCount;
  int get incorrectAnsCount => _incorrectAnsCount;
  int get pointsPerQuestion => _pointsPerQuestion;

  void incrementCorrectAnswers() {
    _correctAnsCount++;
    notifyListeners();
  }

  void decrementCorrectAnswers() {
    _incorrectAnsCount++;
    notifyListeners();
  }

  String getPerformanceLabel(BuildContext context, int correctAnswers, int totalQuestions) {
    // Calculate the percentage score
    int score = ((correctAnswers / totalQuestions) * 100).round();

    // Determine the performance label based on the score
    if (score >= 90) {
      return context.lang.outstanding; //Outstanding
    } else if (score >= 75) {
      return context.lang.excellent;   //Excellent
    } else if (score >= 50) {
      return context.lang.good;        //Good
    } else if (score >= 35) {
      return context.lang.average;     //Average
    } else {
      return context.lang.poor;        //Poor
    }
  }

  // Reset the quiz and clear selected answers
  void resetQuiz() {
    currentQuestionIndex = 0;
    selectedAnswersById.clear(); // Clear the map

    _correctAnsCount = 0;
    _incorrectAnsCount = 0;
    notifyListeners();
  }

  // Update the current question index
  void updateQuestionIndex(int index) {
    currentQuestionIndex = index;
    notifyListeners();
  }

  // Store the selected answer for a specific question by questionId
  void selectAnswer(int questionId, int optionIndex) {
    selectedAnswersById[questionId] = optionIndex;
    notifyListeners();
  }

  // Retrieve the selected answer for a specific question by questionId
  int getSelectedAnswer(int questionId) {
    return selectedAnswersById.containsKey(questionId) 
        ? selectedAnswersById[questionId]! 
        : -1; // -1 indicates no answer selected
  }

  // Move to the next question
  void nextQuestion() {
    if (currentQuestionIndex < quizList[0].questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }


  List<Quiz> get quizList => _quizList;
  final List<Quiz> _quizList = [
    Quiz(
      quizId: 1,
      title: 'Bitcoin Basics Quiz',
      questions: [
        Question(
          questionId: 101,
          question: "What is Bitcoin?",
          questionImageUrl: "https://example.com/bitcoin-question1.jpg",
          options: [
            Answer(answerText: "Digital Currency", answerImageUrl: "https://example.com/digital-currency.jpg", isCorrect: true),
            Answer(answerText: "Physical Coin", answerImageUrl: "https://example.com/physical-coin.jpg", isCorrect: false),
            Answer(answerText: "Banknote", answerImageUrl: "https://example.com/banknote.jpg", isCorrect: false),
            Answer(answerText: "Commodity", answerImageUrl: "https://example.com/commodity.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 102,
          question: "Who invented Bitcoin?",
          questionImageUrl: "https://example.com/bitcoin-creator.jpg",
          options: [
            Answer(answerText: "Elon Musk", answerImageUrl: "https://example.com/elon.jpg", isCorrect: false),
            Answer(answerText: "Vitalik Buterin", answerImageUrl: "https://example.com/vitalik.jpg", isCorrect: false),
            Answer(answerText: "Satoshi Nakamoto", answerImageUrl: "https://example.com/satoshi.jpg", isCorrect: true),
            Answer(answerText: "Bill Gates", answerImageUrl: "https://example.com/bill.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 103,
          question: "What year was Bitcoin created?",
          questionImageUrl: "https://example.com/bitcoin-year.jpg",
          options: [
            Answer(answerText: "2008", answerImageUrl: "https://example.com/2008.jpg", isCorrect: true),
            Answer(answerText: "2010", answerImageUrl: "https://example.com/2010.jpg", isCorrect: false),
            Answer(answerText: "2005", answerImageUrl: "https://example.com/2005.jpg", isCorrect: false),
            Answer(answerText: "2015", answerImageUrl: "https://example.com/2015.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 104,
          question: "What is Bitcoin mining?",
          questionImageUrl: "https://example.com/bitcoin-mining.jpg",
          options: [
            Answer(answerText: "Creating new bitcoins by solving complex problems", answerImageUrl: "https://example.com/mining.jpg", isCorrect: true),
            Answer(answerText: "Extracting coins from the earth", answerImageUrl: "https://example.com/earth.jpg", isCorrect: false),
            Answer(answerText: "Collecting bitcoins from users", answerImageUrl: "https://example.com/collecting.jpg", isCorrect: false),
            Answer(answerText: "Buying bitcoins from an exchange", answerImageUrl: "https://example.com/exchange.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 105,
          question: "What is the total supply limit of Bitcoin?",
          questionImageUrl: "https://example.com/total-supply.jpg",
          options: [
            Answer(answerText: "21 million", answerImageUrl: "https://example.com/21-million.jpg", isCorrect: true),
            Answer(answerText: "100 million", answerImageUrl: "https://example.com/100-million.jpg", isCorrect: false),
            Answer(answerText: "1 billion", answerImageUrl: "https://example.com/1-billion.jpg", isCorrect: false),
            Answer(answerText: "Unlimited", answerImageUrl: "https://example.com/unlimited.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 106,
          question: "What is a Bitcoin address?",
          questionImageUrl: "https://example.com/address.jpg",
          options: [
            Answer(answerText: "A wallet identifier", answerImageUrl: "https://example.com/wallet-id.jpg", isCorrect: true),
            Answer(answerText: "A physical location", answerImageUrl: "https://example.com/location.jpg", isCorrect: false),
            Answer(answerText: "A bank account", answerImageUrl: "https://example.com/bank-account.jpg", isCorrect: false),
            Answer(answerText: "A social security number", answerImageUrl: "https://example.com/ssn.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 107,
          question: "What is the smallest unit of Bitcoin?",
          questionImageUrl: "https://example.com/satoshi.jpg",
          options: [
            Answer(answerText: "Satoshi", answerImageUrl: "https://example.com/satoshi.jpg", isCorrect: true),
            Answer(answerText: "Millibit", answerImageUrl: "https://example.com/millibit.jpg", isCorrect: false),
            Answer(answerText: "Microbit", answerImageUrl: "https://example.com/microbit.jpg", isCorrect: false),
            Answer(answerText: "Bitcoin Cent", answerImageUrl: "https://example.com/cent.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 108,
          question: "What is Bitcoin halving?",
          questionImageUrl: "https://example.com/halving.jpg",
          options: [
            Answer(answerText: "Reduction of mining rewards", answerImageUrl: "https://example.com/reward.jpg", isCorrect: true),
            Answer(answerText: "Doubling the supply", answerImageUrl: "https://example.com/doubling.jpg", isCorrect: false),
            Answer(answerText: "Introducing new coins", answerImageUrl: "https://example.com/new-coins.jpg", isCorrect: false),
            Answer(answerText: "Decreasing transaction fees", answerImageUrl: "https://example.com/fees.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 109,
          question: "What is a Bitcoin wallet?",
          questionImageUrl: "https://example.com/wallet.jpg",
          options: [
            Answer(answerText: "A digital wallet for storing bitcoins", answerImageUrl: "https://example.com/digital-wallet.jpg", isCorrect: true),
            Answer(answerText: "A bank account", answerImageUrl: "https://example.com/bank-account.jpg", isCorrect: false),
            Answer(answerText: "A physical wallet", answerImageUrl: "https://example.com/physical-wallet.jpg", isCorrect: false),
            Answer(answerText: "A blockchain address", answerImageUrl: "https://example.com/blockchain-address.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 110,
          question: "What is a Bitcoin private key?",
          questionImageUrl: "https://example.com/private-key.jpg",
          options: [
            Answer(answerText: "A secret code for accessing your wallet", answerImageUrl: "https://example.com/secret-code.jpg", isCorrect: true),
            Answer(answerText: "A public address", answerImageUrl: "https://example.com/public-address.jpg", isCorrect: false),
            Answer(answerText: "A government-issued ID", answerImageUrl: "https://example.com/gov-id.jpg", isCorrect: false),
            Answer(answerText: "A password reset token", answerImageUrl: "https://example.com/reset-token.jpg", isCorrect: false),
          ],
        ),
      ],
    ),

    Quiz(
      quizId: 2,
      title: 'Bitcoin Wallets and Security Quiz',
      questions: [
        Question(
          questionId: 201,
          question: "What is the main purpose of a Bitcoin wallet?",
          questionImageUrl: "https://example.com/purpose-wallet.jpg",
          options: [
            Answer(answerText: "Storing private keys", answerImageUrl: "https://example.com/private-key-storage.jpg", isCorrect: true),
            Answer(answerText: "Storing bitcoins", answerImageUrl: "https://example.com/bitcoin-storage.jpg", isCorrect: false),
            Answer(answerText: "Making transactions", answerImageUrl: "https://example.com/transactions.jpg", isCorrect: false),
            Answer(answerText: "Sending email", answerImageUrl: "https://example.com/email.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 202,
          question: "Which of these is NOT a type of Bitcoin wallet?",
          questionImageUrl: "https://example.com/wallet-types.jpg",
          options: [
            Answer(answerText: "Cold Wallet", answerImageUrl: "https://example.com/cold-wallet.jpg", isCorrect: false),
            Answer(answerText: "Hot Wallet", answerImageUrl: "https://example.com/hot-wallet.jpg", isCorrect: false),
            Answer(answerText: "Paper Wallet", answerImageUrl: "https://example.com/paper-wallet.jpg", isCorrect: false),
            Answer(answerText: "Account Wallet", answerImageUrl: "https://example.com/account-wallet.jpg", isCorrect: true),
          ],
        ),
        Question(
          questionId: 203,
          question: "What does 'cold storage' refer to?",
          questionImageUrl: "https://example.com/cold-storage.jpg",
          options: [
            Answer(answerText: "Keeping bitcoins offline", answerImageUrl: "https://example.com/offline.jpg", isCorrect: true),
            Answer(answerText: "Using a hot wallet", answerImageUrl: "https://example.com/hot-wallet.jpg", isCorrect: false),
            Answer(answerText: "Mining bitcoins", answerImageUrl: "https://example.com/mining.jpg", isCorrect: false),
            Answer(answerText: "Selling bitcoins", answerImageUrl: "https://example.com/selling.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 204,
          question: "What is 2FA (Two-Factor Authentication)?",
          questionImageUrl: "https://example.com/2fa.jpg",
          options: [
            Answer(answerText: "An additional layer of security", answerImageUrl: "https://example.com/security.jpg", isCorrect: true),
            Answer(answerText: "A type of wallet", answerImageUrl: "https://example.com/wallet-type.jpg", isCorrect: false),
            Answer(answerText: "A transaction method", answerImageUrl: "https://example.com/transaction-method.jpg", isCorrect: false),
            Answer(answerText: "A public key", answerImageUrl: "https://example.com/public-key.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 205,
          question: "What should you do if you lose your private key?",
          questionImageUrl: "https://example.com/lost-key.jpg",
          options: [
            Answer(answerText: "Your bitcoins are lost forever", answerImageUrl: "https://example.com/lost-forever.jpg", isCorrect: true),
            Answer(answerText: "Request a new key from the bank", answerImageUrl: "https://example.com/new-key.jpg", isCorrect: false),
            Answer(answerText: "Contact customer service", answerImageUrl: "https://example.com/customer-service.jpg", isCorrect: false),
            Answer(answerText: "Generate a new wallet", answerImageUrl: "https://example.com/new-wallet.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 206,
          question: "What is a seed phrase?",
          questionImageUrl: "https://example.com/seed-phrase.jpg",
          options: [
            Answer(answerText: "A set of words used to recover your wallet", answerImageUrl: "https://example.com/recover-wallet.jpg", isCorrect: true),
            Answer(answerText: "A type of password", answerImageUrl: "https://example.com/password.jpg", isCorrect: false),
            Answer(answerText: "A type of transaction", answerImageUrl: "https://example.com/transaction.jpg", isCorrect: false),
            Answer(answerText: "A type of private key", answerImageUrl: "https://example.com/private-key.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 207,
          question: "What is the best way to keep your private key safe?",
          questionImageUrl: "https://example.com/private-key-safety.jpg",
          options: [
            Answer(answerText: "Store it in a safe place", answerImageUrl: "https://example.com/safe-place.jpg", isCorrect: true),
            Answer(answerText: "Share it with a friend", answerImageUrl: "https://example.com/share.jpg", isCorrect: false),
            Answer(answerText: "Keep it online", answerImageUrl: "https://example.com/online.jpg", isCorrect: false),
            Answer(answerText: "Post it on social media", answerImageUrl: "https://example.com/social-media.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 208,
          question: "What does a hardware wallet do?",
          questionImageUrl: "https://example.com/hardware-wallet.jpg",
          options: [
            Answer(answerText: "Stores private keys offline", answerImageUrl: "https://example.com/offline-keys.jpg", isCorrect: true),
            Answer(answerText: "Creates new bitcoins", answerImageUrl: "https://example.com/create-bitcoins.jpg", isCorrect: false),
            Answer(answerText: "Transfers funds instantly", answerImageUrl: "https://example.com/transfer-funds.jpg", isCorrect: false),
            Answer(answerText: "Generates blockchain addresses", answerImageUrl: "https://example.com/generate-address.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 209,
          question: "Which of the following is a risk of using a hot wallet?",
          questionImageUrl: "https://example.com/hot-wallet-risk.jpg",
          options: [
            Answer(answerText: "Vulnerability to hacking", answerImageUrl: "https://example.com/hacking.jpg", isCorrect: true),
            Answer(answerText: "Loss of hardware", answerImageUrl: "https://example.com/loss-hardware.jpg", isCorrect: false),
            Answer(answerText: "Decreased transaction speed", answerImageUrl: "https://example.com/transaction-speed.jpg", isCorrect: false),
            Answer(answerText: "Limited access to funds", answerImageUrl: "https://example.com/limited-access.jpg", isCorrect: false),
          ],
        ),
        Question(
          questionId: 210,
          question: "What happens if you lose your seed phrase?",
          questionImageUrl: "https://example.com/lost-seed.jpg",
          options: [
            Answer(answerText: "You may lose access to your wallet", answerImageUrl: "https://example.com/lost-wallet.jpg", isCorrect: true),
            Answer(answerText: "Your funds are doubled", answerImageUrl: "https://example.com/doubled-funds.jpg", isCorrect: false),
            Answer(answerText: "You get a new wallet", answerImageUrl: "https://example.com/new-wallet.jpg", isCorrect: false),
            Answer(answerText: "You can still access your funds", answerImageUrl: "https://example.com/access-funds.jpg", isCorrect: false),
          ],
        ),
      ],
    )
  ];


}