import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/transaction_controller.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/views/screens/combo_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_movie_seat.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SeatScreen extends StatefulWidget {
  dynamic movie;

  SeatScreen({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  List<dynamic> allSeats = [];

  late Future<List<dynamic>> seatsData;
  Map<String, String> statusSeat = {};

  @override
  void initState() {
    super.initState();
    // print(widget.movie);
    seatsData = fetchSeats();
  }

  Future<List<dynamic>> fetchSeats() async {
    allSeats = await TransactionController.getSeats(
      widget.movie['screen_id'].toString(), 
      widget.movie['id'].toString()
    );
    List<String> keys = allSeats.map((e) => e['id'].toString()).toList();
    List<String> values = List.generate(allSeats.length, (index) => "false");
    statusSeat = Map.fromIterables(keys, values);
    return allSeats;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain1, primaryMain2 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Stack(
              children: [
                FutureBuilder(
                  future: seatsData, 
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryMain1,
                        ),
                      );
                    }else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error ${snapshot.error}'),
                      );
                    }else {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height/16,
                          bottom: 24
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CINE AURA',
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomMovieSeatScreen(movie: widget.movie),
                            const SizedBox(height: 16),

                            SizedBox(
                              height: 50,
                              child: Image.asset(
                                'assets/images/screen.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Màn Hình',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ],
                            ),
                            
                            GridView.count(
                              childAspectRatio: 5/3,
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 1.0,
                              shrinkWrap: true,
                              crossAxisCount: 5,
                              physics: const NeverScrollableScrollPhysics(),
                              children: allSeats.map(
                                (e) => customSeat(e)
                              ).toList()
                            ),
                            const SizedBox(height: 32),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                customStatus('Ghế trống', const Color(0xFFB3B3B3)),
                                customStatus('Đã đặt', const Color(0xFFC94044)),
                                customStatus('Đang chọn', const Color(0xFF64FFA2)),
                              ],
                            ),
                            const SizedBox(height: 32),

                            CustomButton(
                              text: 'Tiếp tục',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                              ),
                              onTap: () {
                                Map<String, dynamic> body = {
                                  'screen_id': widget.movie['id'].toString(),
                                  'data': statusSeat
                                };
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => ComboScreen(
                                      movie: widget.movie, data: body,
                                    ),
                                  )
                                );
                              }
                            ),
                          ],
                        ),
                      );
                    }
                  }
                ),
                showButtonBack(context, primaryMain2, primaryMain1, Icons.arrow_back, 64, 0),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget customSeat(dynamic seat) {
    return InkWell(
      onTap: seat['status'] == 1 
        ? (){}
        : () {
        setState(() {
          statusSeat[seat['id'].toString()] = statusSeat[seat['id'].toString()]! == "true" 
            ? "false" 
            : "true";
        });
      },
      child: Icon(
        Icons.chair,
        color: seat['status'] == 1 
          ? const Color(0xFFC94044)
          : (statusSeat[seat['id'].toString()] == "true" 
            ? const Color(0xFF64FFA2) 
            : const Color(0xFFB3B3B3)
          ) 
      ),
    );
  }

  Widget customStatus(String text, Color color) {
    return Row(
      children: [
        Icon(
          Icons.rectangle,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
            fontFamily: 'Poppins',
          )
        )
      ],
    );
  }
  
}