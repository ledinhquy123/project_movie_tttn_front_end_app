import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/detail_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class CustomSearchMovie extends StatelessWidget {
  int index;
  dynamic item;

  CustomSearchMovie({
    super.key,
    required this.index,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => DeatailMovieScreen(
              id: item['id_movie']
            )
          )
        );
      },
      child: Container(
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
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
                
                child: Image.network(
                  item['poster_path'],
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
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      item['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Row(
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
                          '${double.parse(item['vote_average']).toStringAsFixed(1)}/10',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                
                    Text(
                      item['genres'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: outline,
                        fontSize: 10
                      ),
                    ),
                    Text(
                        item['country'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: outline,
                          fontSize: 10
                        ),
                      ),
                
                    Text(
                      item['over_view'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: outline,
                        fontSize: 10
                      ),
                    ),
                
                    Text(
                      item['runtime'] != '0' 
                      ? '${item['runtime']} phút' 
                      : '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: outline,
                        fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}