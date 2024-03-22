import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/screens/detail_movie_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeTapScreen extends StatefulWidget {
  const HomeTapScreen({super.key});

  @override
  State<HomeTapScreen> createState() => _HomeTapScreenState();
}

class _HomeTapScreenState extends State<HomeTapScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<dynamic> trendingList = [];
  List<dynamic> popularList = [];
  List<dynamic> nowPlayingList = [];
  List<dynamic> upComingList = [];

  @override
  void initState() {
    super.initState();
    trendingList = HomeScreen.trendingList;
    popularList = HomeScreen.popularList;
    nowPlayingList = HomeScreen.nowPlayingList;
    upComingList = HomeScreen.upComingList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain2, primaryMain1 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CINE AURA',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                ),
                const SizedBox(height: 16),

                Container(
                  height: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CarouselSlider.builder(
                    itemCount: trendingList.length, 
                    itemBuilder: (context, index, realIndex) {
                      // return Text(trendingList[index].toString());
                      return builImage(trendingList[index]['poster_path']);
                    }, 
                    options: CarouselOptions(
                      height: 400,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      enlargeCenterPage: true, // quay lại mục đầu tiên
                    )
                  ),
                ),
                const SizedBox(height: 32),
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Phim được yêu thích nhất',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => DeatailMovieScreen(
                                  id: popularList[index]['id_movie']
                                )
                              )
                            );
                          },
                          child: SizedBox(
                            width: 120,
                            child: builImage(popularList[index]['poster_path'])
                            // child: Text(popularList[index].toString()),
                          )
                        )
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Phim đang chiếu',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: nowPlayingList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => DeatailMovieScreen(
                                  id: nowPlayingList[index]['id_movie']
                                )
                              )
                            );
                          },
                          child: SizedBox(
                            width: 120,
                            child: builImage(nowPlayingList[index]['poster_path'])
                            // child: Text(nowPlayingList[index].toString()),
                          )
                        )
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Phim sắp chiếu',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upComingList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => DeatailMovieScreen(
                                  id: upComingList[index]['id_movie']
                                )
                              )
                            );
                          },
                          child: SizedBox(
                            width: 120,
                            child: builImage(upComingList[index]['poster_path'])
                            // child: Text(upComingList[index].toString()),
                          ) 
                        )
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget builImage(String urlImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child; // Ảnh đã được tải thành công, hiển thị nó
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryMain1,
              ),
            );
          }
        },
      ),
    );
  }

}