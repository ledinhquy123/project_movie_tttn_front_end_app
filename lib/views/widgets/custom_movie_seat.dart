import 'package:app_movie/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class CustomMovieSeatScreen extends StatelessWidget {
  dynamic movie;

  CustomMovieSeatScreen({
    super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: Colors.white
              )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie['movie_poster'],
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
        const SizedBox(width: 16),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie['movie_name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    IconlyBold.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${double.parse(movie['movie_vote']).toStringAsFixed(1)}/10',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    )
                  ),
                ],
              ),
              const SizedBox(height: 8),
          
              Text(
                movie['movie_genres'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                )
              ),
              const SizedBox(height: 8),

              Text(
                movie['movie_country'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                )
              ),
              const SizedBox(height: 8),

              Text(
                '${movie['duration']} phút',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                )
              ),
            ],
          ),
        )
      ],
    );
  }
}