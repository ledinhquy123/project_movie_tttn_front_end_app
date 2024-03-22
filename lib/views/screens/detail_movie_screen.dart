import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/actor_controller.dart';
import 'package:app_movie/controllers/comment_controller.dart';
import 'package:app_movie/services/movies_api.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/screens/showtime_of_detail_screen.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class DeatailMovieScreen extends StatefulWidget {
  String id;
  DeatailMovieScreen({
    super.key,
    required this.id
  });

  @override
  State<DeatailMovieScreen> createState() => _DeatailMovieScreenState();
}

class _DeatailMovieScreenState extends State<DeatailMovieScreen> {
  late Future<List<List<dynamic>>> allActors;

  List<dynamic> dataActor = [];
  List<dynamic> dataComments = [];
  dynamic movie;
  dynamic user;
  bool checkUserComment = false;

  TextEditingController _commentController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    movie = HomeScreen.allMovies.where(
      (element) => element['id_movie'] == widget.id
    ).toList();
    movie = movie[0];
    print(movie);

    user = SignInScreen.user;

    allActors = fetchActor();
  }

  Future<List<List<dynamic>>> fetchActor() async {
    dataActor = await ActorController.getActor(widget.id);
    await getMovieComments();
    final check = await MovieApi.checkUserComment({
      'userId': user['id'],
      'movieId': movie['id_movie']
    });
    setState(() {
      checkUserComment = check;
    });
    return [
      dataActor,
      dataComments
    ];
  }

  Future<void> getMovieComments() async {
    final response = await MovieApi.getMovieComments(widget.id);
    setState(() {
      dataComments = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: getMovieComments,
          child: SingleChildScrollView(
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
              child: FutureBuilder(
                future: allActors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(
                      color: primaryMain1,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Image.network(
                                movie['backdrop_path'],
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
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Diễn viên',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: dataActor.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => infoActor(
                                        dataActor[index]['profile_path'],
                                        dataActor[index]['name'],
                                        dataActor[index]['character'],
                                      )
                                    ),
                                  ),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Trailer',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: YoutubePlayer(
                                      controller: YoutubePlayerController(
                                        initialVideoId: YoutubePlayer.convertUrlToId(movie['video_path'])!,
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: false,
                                          mute: true
                                        )
                                      ),
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: Colors.blueAccent,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Visibility(
                                    visible: movie['status'] == '1' ? true : false,
                                    replacement: const Text('Hiện tại phim không chiếu tại rạp'),
                                    child: CustomButton(
                                      text: 'Mua vé',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(
                                            builder: (context) => ShowtimeOfDetailScreen(idMovie: widget.id,)
                                          )
                                        );
                                      }
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Cộng đồng Cine Aura nghĩ gì?',
                                        style: Theme.of(context).textTheme.bodyLarge!.
                                        copyWith(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Visibility(
                                    visible: checkUserComment,
                                    replacement: Text(
                                      'Hãy mua vé trước khi đánh giá',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: primaryMain1,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    child: Form(
                                      key: _key,
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            hintText: 'Viết đánh giá của bạn',
                                            hintStyle: const TextStyle(
                                              color: outline,
                                            ),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30)
                                              ),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: outline
                                              )
                                            ),
                                                
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30)
                                              ),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: outline,
                                              )
                                            ),
                                                
                                            style: const TextStyle(color: Colors.white),
                                    
                                            errorBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30)
                                              ),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: primaryMain1,
                                              )
                                            ),
                                    
                                            errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: primaryMain1,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700
                                            ),
                                    
                                            focusedErrorBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30)
                                              ),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: primaryMain1,
                                              )
                                            ),
                                    
                                            validator: (value) {
                                              if(value!.isEmpty){
                                                return 'Đánh giá không được để trống';
                                              }
                                              return null;
                                            },
                                    
                                            contentPadding: const EdgeInsets.symmetric(
                                              vertical: 8, 
                                              horizontal: 16
                                            ),
                                            controller: _commentController,
                                          ),
                                          const SizedBox(height: 4),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green
                                            ),
                                            onPressed: () async {
                                              if(_key.currentState!.validate()) {
                                                showDialog(context: context, builder: (context) => const Center(
                                                  child: CircularProgressIndicator(
                                                    color: primaryMain1,
                                                  ),
                                                ));
                                                bool check = await CommentController.createMovieComment(
                                                  {
                                                    "content": _commentController.text,
                                                    "idUser": user['id'],
                                                    "idMovie": movie['id_movie']
                                                  }
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context);
                                                if(check) {
                                                  // ignore: use_build_context_synchronously
                                                  showSnackbar(context, 'Đánh giá đã được gửi', Colors.green);
                                                } else {
                                                  // ignore: use_build_context_synchronously
                                                  showSnackbar(context, 'Gửi thất bại', Colors.red);
                                                }
                                                _commentController.text = '';
                                              }
                                            }, 
                                            child: const Text('Gửi')
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  Visibility(
                                    visible: dataComments.isNotEmpty,
                                    replacement: SizedBox(
                                      height: MediaQuery.of(context).size.height / 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Chưa có bình luận về phim',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.headlineLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8, 
                                        vertical: 4
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8)
                                        )
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${dataComments.length} bình luận', 
                                                style: Theme.of(context).textTheme.bodyLarge
                                              ),
                                            ],
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: dataComments.length,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) => customComment(dataComments[index])
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                    
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
                                  movie['title'],
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
                                      '${double.parse(movie['vote_average']).toStringAsFixed(1)}/10',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                                                  
                                Text(
                                  'Thể loại: ${movie['genres']}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Quốc gia: ${movie['country']}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Thời lượng: ${movie['runtime']} phút',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Ngày phát hành: ${movie['release_date']}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 8),
                                                  
                                Text(
                                  movie['over_view'],
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
                    );
                  }
                },
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget customComment(dynamic comment) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(
          width: 1,
          color: outline
        ))
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(30)
          ),
          child: CircleAvatar(
            child: Image.network(comment['user_avatar'], fit: BoxFit.cover),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment['user_name'], 
              style: Theme.of(context).textTheme.bodyLarge
            ),
            Text(
              comment['created_at'],
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: outline
              )
            )
          ],
        ),
        subtitle: Text(
          comment['content'],
          style: Theme.of(context).textTheme.bodyMedium
        ),
      ),
    );
  }

  Widget infoActor(String urlImage, String name, String character) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 100,
                height: 100,
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
              ),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            character,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }
}