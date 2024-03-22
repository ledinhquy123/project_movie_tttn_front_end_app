import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/transaction_controller.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketTapScreen extends StatefulWidget {
  const TicketTapScreen({super.key});

  @override
  State<TicketTapScreen> createState() => _TicketTapScreenState();
}

class _TicketTapScreenState extends State<TicketTapScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // Follow user
  late List<dynamic> allTickets;
  late Future<List<dynamic>> fetchTickets;
  dynamic user = SignInScreen.user;

  @override
  void initState() {
    super.initState();
    fetchTickets = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    allTickets = await TransactionController.getTicket(user['id'].toString());
    return allTickets;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
            child: FutureBuilder(
              future: fetchTickets,
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
                  return Column(
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
                
                      Visibility(
                        visible: allTickets.isNotEmpty,
                        replacement: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: Text(
                              'Chưa có chi tiết vé',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allTickets.length,
                          itemBuilder: (context, index) => customTicket(allTickets[index], index)
                        ),
                      ),
                    ]
                  );
                }
              },
            )
          ),
        ),
      ),
    );
  }

  Widget customTicket(dynamic ticket, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: index % 2 == 0 
        ? LinearGradient(
          colors: [ const Color(0xFF287446).withOpacity(.8), navigtorBar2.withOpacity(.65) ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
        : LinearGradient(
          colors: [ const Color(0xFFFDAA67).withOpacity(.4), navigtorBar2.withOpacity(.65) ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16)
        ),
        border: Border.all(
          width: 1,
          color: Colors.white
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              
              child: Image.network(
                ticket['movie_poster_path'],
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
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    ticket['movie_name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
              
                  Text(
                    ticket['movie_genres'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: outline,
                      fontSize: 10
                    ),
                  ),
                  Text(
                    ticket['movie_country'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: outline,
                      fontSize: 10
                    ),
                  ),
                  
                  Text(
                    ticket['seats_name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: outline,
                      fontSize: 10
                    ),
                  ),

                  Text(
                    ticket['screen_name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: outline,
                      fontSize: 10
                    ),
                  ),
            
                  Text(
                   '${ticket['show_time']} | ${ticket['showdate']}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: outline,
                      fontSize: 10
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: QrImageView(
              backgroundColor: Colors.white,
              data: ticket['qr_path'],
              version: QrVersions.auto,
              embeddedImage: const AssetImage('assets/images/logo.png'),
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(20, 20),
              ),
              gapless: false,
            )
          ),
        ],
      )
    );
  }
}