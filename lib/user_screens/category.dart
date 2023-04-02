import 'package:carousel_slider/carousel_slider.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:kurdbid/user_screens/list_of_items.dart';

class CateGoryScreen extends StatelessWidget {
  CateGoryScreen({super.key});

  List<String> categories = [
    'car.jpg',
    'electronics.jpeg',
    'fur.jpg',
    'house.jpg'
  ];
  List<String> labels = ['Cars', 'Electronics', 'Furniture', 'House'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider(
                  items: [
                    Image.asset(
                      getImage(
                        folderName: 'images',
                        fileName: 'bid.png',
                      ),
                      fit: BoxFit.cover,
                    )
                  ],
                  options: CarouselOptions(
                    height: 200.h,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    //onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 500.h,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () =>
                        getPage(context, ListOfItem(category: labels[index])),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 200.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              //color: Colors.blue,
                              image: DecorationImage(
                                  image: AssetImage(
                                    getImage(
                                        folderName: 'images',
                                        fileName: categories[index]),
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          // AspectRatio(
                          //   aspectRatio: 4 / 3,
                          //   child: Container(
                          //     color: Colors.black.withOpacity(0.7),
                          //   ),
                          // ),
                          Container(
                            height: 200.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Center(
                            child: textLabel(
                                text: labels[index],
                                color: Colors.white,
                                fontSize: 28.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
