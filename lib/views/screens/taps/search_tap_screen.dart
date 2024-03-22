import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_search_movie.dart';
import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class SearchTapScreen extends StatefulWidget {
  
  const SearchTapScreen({super.key});

  @override
  State<SearchTapScreen> createState() => _SearchTapScreenState();
}

class _SearchTapScreenState extends State<SearchTapScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController searchController = TextEditingController();
  Fuzzy<dynamic> movies = Fuzzy(HomeScreen.movieNames);
  List<dynamic> movieSearch = HomeScreen.trendingList;

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

                CustomTextFormField(
                  hintText: 'Tìm kiếm',
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
                      
                  prefixIcon: const Icon(
                    IconlyLight.search,
                    color: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: searchController,
                  
                  onChanged: (value) {
                    List<dynamic> results = movies.search(value);
                    setState(() {
                      search(results);
                    });
                  },

                  onEditingComplete: () {
                    setState(() {
                      if(searchController.text != '') {
                        HomeScreen.previousSearch.add(searchController.text);
                        List<dynamic> results = movies.search(searchController.text);
                        search(results);
                        searchController.text = '';
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      text: 'Phim đang chiếu',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white
                      ),
                      onTap: () {
                        setState(() {
                          movieSearch = HomeScreen.nowPlayingList;
                        });
                      },
                    ),
                    CustomButton(
                      text: 'Phim sắp chiếu',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white
                      ),
                      onTap: () {
                         setState(() {
                          movieSearch = HomeScreen.upComingList;
                        });
                      },
                    )
                  ],
                ),

                ListView.builder(
                  itemCount: HomeScreen.previousSearch.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => previousSearchItem(index)
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Text(
                      'Kết quảt tìm kiếm',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),

                Visibility(
                  visible: movieSearch.isNotEmpty,
                  replacement: Center(
                    child: Text(
                      'Không có kết quả', 
                      style: Theme.of(context).textTheme.headlineLarge
                    )
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: movieSearch.length,
                    itemBuilder: (contex, index) => CustomSearchMovie(
                      index: index, 
                      item: movieSearch[index]
                    )
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  List<dynamic> search(List<dynamic> results) {
    List<dynamic> ans = [];
    for(var result in results) {
      final movie = HomeScreen.allMovies.where(
        (e) => e['title'] == result.item
      ).toList();
      if(movie.isNotEmpty) ans.add(movie[0]);
    }
    if(ans.isNotEmpty) {
      movieSearch = ans;
      return movieSearch;
    }
    return [];
  }

  previousSearchItem(int index) {
    return InkWell(
      onTap: () {
        searchController.text = HomeScreen.previousSearch[index];
        setState(() {
          List<dynamic> results = movies.search(searchController.text);
          search(results);
        });
      },
      child: Dismissible(
        key: GlobalKey(), 
        onDismissed: (DismissDirection dir) {
          setState(() {
            HomeScreen.previousSearch.removeAt(index);
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: outline,
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(16)
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: navigtorBar2
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 1,
                child: Icon(
                  IconlyLight.time_circle,
                  color: Colors.black,
                ),
              ),
              Flexible(
                flex: 5,
                child: Text(
                  HomeScreen.previousSearch[index],
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              const Flexible(
                flex: 1,
                child: Icon(
                  Icons.call_made_outlined,
                  color: Colors.black,
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}