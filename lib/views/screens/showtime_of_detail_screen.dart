import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/movie_controller.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/widgets/custom_showtime.dart';
import 'package:app_movie/views/widgets/custom_weekday.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class ShowtimeOfDetailScreen extends StatefulWidget {
  dynamic idMovie;

  ShowtimeOfDetailScreen({
    super.key,
    required this.idMovie,
  });

  @override
  State<ShowtimeOfDetailScreen> createState() => _ShowtimeOfDetailScreenState();
}

class _ShowtimeOfDetailScreenState extends State<ShowtimeOfDetailScreen> {
  List<dynamic> movie = [];
  List<dynamic> dataWeekday = [];
  List<dynamic> dataShowtimeWeekdayMovie = [];

  Map<String, bool> selectWeekday = {};
  int currentIndex = 0;

  late Future<List<dynamic>> fetchDataShowtimeWeekdayMovie;

  @override
  void initState() {
    super.initState();

    dataWeekday = HomeScreen.weekdayList;
    List<String> keys = dataWeekday.map((e) => e['id'].toString()).toList();
    List<bool> values = List.generate(dataWeekday.length, (index) => false);
    selectWeekday = Map.fromIterables(keys, values);

    fetchDataShowtimeWeekdayMovie = fetchShowtimeWeekdayMovie();

    movie = HomeScreen.nowPlayingList.where(
      (element) => element['id_movie'] == widget.idMovie
    ).toList();
  }

  Future<List<dynamic>> fetchShowtimeWeekdayMovie() async {
    dataShowtimeWeekdayMovie = await MovieController.getShowtimeMovieWeekday(
      currentIndex.toString(), widget.idMovie
    );
    return dataShowtimeWeekdayMovie;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 32),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain2, primaryMain1 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Image.network(
                        movie[0]['backdrop_path'],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: primaryMain1,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 64),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: dataWeekday.length,
                              itemBuilder: (context, index) {
                                DateTime dateOfWeek = DateTime.parse(dataWeekday[index]['date']);
                                DateTime now = DateTime.now().subtract(const Duration(days: 1));
                                return customWeekday(
                                  context,
                                  dataWeekday[index], 
                                  dateOfWeek.isAfter(now)
                                  ? () {
                                    setState(() {
                                      currentIndex = dataWeekday[index]['id'];

                                      selectWeekday.forEach((key, value) {
                                        selectWeekday[key] = false;
                                        if(key == dataWeekday[index]['id'].toString()) {
                                          selectWeekday[key] = !selectWeekday[key]!;
                                        }
                                      });

                                      fetchDataShowtimeWeekdayMovie = fetchShowtimeWeekdayMovie();
                                    });
                                  }
                                  : () {
                                    showSnackbar(context, 'Ngày chiếu không hợp lệ', Colors.red);
                                  }, 
                                  selectWeekday[dataWeekday[index]['id'].toString()]!
                                );
                              }
                            ),
                          ),
                          const SizedBox(height: 32),

                          FutureBuilder(
                            future: fetchDataShowtimeWeekdayMovie,
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: primaryMain1,
                                  ),
                                );
                              }else if(snapshot.hasError) {
                                return Text('Error ${snapshot.error}');
                              }else {
                                return Visibility(
                                  visible: dataShowtimeWeekdayMovie.isNotEmpty,
                                  replacement: Text(
                                    'Chưa có lịch chiếu chi tiết hôm nay',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineLarge,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: dataShowtimeWeekdayMovie.length,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              width: 80,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                                child: customShowTime(
                                                  dataShowtimeWeekdayMovie[index],
                                                  context,
                                                )
                                              )
                                            );
                                          }
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Positioned(
                //   bottom: 24,
                //   // left: 42,
                //   child: CustomButton(
                //     width: MediaQuery.of(context).size.width / 1.2,
                //     height: MediaQuery.of(context).size.height / 20,
                //     text: 'Tiếp tục',
                //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w700
                //     ),
                //     onTap: () {
                //       print('select seat');
                //     }
                //   ),
                // ),

                Positioned(
                  top: MediaQuery.of(context).size.height / 6,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryMain2.withOpacity(.7),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          movie[0]['title'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge!.
                          copyWith(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 30,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Đánh giá: ',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              IconlyBold.star,
                              size: 12,
                              color: Color(0xFFFFD233),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movie[0]['vote_average'].toStringAsFixed(1)}/10',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                                          
                        Text(
                          'Thể loại: ${movie[0]['genres']}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Quốc gia: ${movie[0]['country']}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Thời lượng: ${movie[0]['runtime']} phút',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                                          
                        Text(
                          movie[0]['over_view'],
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
                showButtonBack(
                  context, 
                  primaryMain2, 
                  primaryMain1, 
                  Icons.arrow_back,
                  32,
                  24
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

}