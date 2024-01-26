import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sawahcek/screen/login_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carouselTimer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 5), (timer) {
      if (pageNo == 5) {
        pageController.animateToPage(
          0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc,
        );
        pageNo = 1; // Set pageNo to 1 to ensure the next transition is smooth
      } else {
        pageController.animateToPage(
          pageNo,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc,
        );
        pageNo++;
      }
    });
  }

  // List of different image paths
  List<String> imagePaths = [
    'images/1.jpeg',
    'images/2.jpg',
    'images/3.jpg',
    'images/4.jpg',
    'images/5.jpg',
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carouselTimer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 248, 255, 20),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 36.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                selected: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                selectedTileColor: Color.fromRGBO(0, 63, 100, 50),
                title: Text(
                  "Welcome Back to SawahCheck.",
                  style: Theme.of(context).textTheme.subtitle1!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                subtitle: Text(
                  "A Greet welcome to you all.",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Carousel Section
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  pageNo = index;
                  setState(() {});
                },
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: GestureDetector(
                      onPanDown: (d) {
                        carouselTimer?.cancel();
                        carouselTimer = null;
                      },
                      onPanCancel: () {
                        carouselTimer = getTimer();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 8,
                          left: 8,
                          top: 24,
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          image: DecorationImage(
                            image: AssetImage(imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: imagePaths.length,
              ),
            ),
            const SizedBox(
              height:10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.circle,
                      size: 12.0,
                      color: pageNo == index
                          ? Color.fromRGBO(0, 63, 100, 50)
                          : Colors.grey.shade300,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: pageNo == index ? Color.fromRGBO(0, 63, 100, 50): Colors.black,
                        width: pageNo == index ? 3.0 : 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
