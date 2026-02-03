import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/base/base_view.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';
import 'package:movie_planner/src/core/paging/paging_bloc.dart';
import 'package:movie_planner/src/core/paging/paging_event.dart';
import 'package:movie_planner/src/core/theme/theme_cubit.dart';
import 'package:movie_planner/src/core/utils/application_bar.dart';
import 'package:movie_planner/src/core/utils/horizontal_paging_section.dart';
import 'package:movie_planner/src/features/home/data/models/movie_model.dart';
import 'package:movie_planner/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_planner/src/features/home/presentation/widgets/movie_card.dart';

class HomeScreen extends BaseView<HomeBloc, HomeState> {
  HomeScreen({super.key});

  @override
  bool isLoading(HomeState state) => state.isLoading;

  late final PagingBloc<Movie> _pagingBloc = PagingBloc<Movie>();
  final ScrollController _scrollController = ScrollController();

  void _loadInitialData() {
    final movies = TempMovieData.getPopularMovies();
    // Add the first page of movies to the PagingBloc
    _pagingBloc.add(PagingLoadNextPage<Movie>(movies));
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return ApplicationBar(
      appTitleText: 'Movie Planner',
      actions: [
        IconButton(
          icon: Icon(
            context.watch<ThemeCubit>().state == AppThemeMode.dark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
          ),
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    _loadInitialData();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              HorizontalPagingSection<Movie>(
                scrollController: _scrollController,
                title: "Popular Movies",
                loadData: _loadData,
                itemBuilder: _itemBuilder,
                pagingBloc: _pagingBloc,
              ),
            ],
          ),
        );
      },
    );
  }

  void _loadData() {
    logger.d('Load more data called');

    // Check if we can load more
    if (_pagingBloc.canLoadNextPage()) {
      // Load more movies (in real app, this would fetch from API)
      final moreMovies = TempMovieData.getTrendingMovies();

      // If there are more movies, add them
      if (moreMovies.isNotEmpty) {
        _pagingBloc.add(PagingLoadNextPage<Movie>(moreMovies));
      } else {
        // No more movies, mark as last page
        _pagingBloc.add(PagingLoadLastPage<Movie>([]));
      }
    }
  }

  Widget _itemBuilder(BuildContext context, int index, Movie item) {
    logger.d('Building item: $index, Movie: ${item.title}');
    return MovieCard(movie: item);
  }
}

class TempMovieData {
  static List<Movie> getPopularMovies() {
    return [
      Movie(
        id: 1,
        title: 'The Shawshank Redemption',
        posterPath: '/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
        overview:
            'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
        voteAverage: 8.7,
        releaseDate: '1994-09-23',
        genreIds: [18, 80],
      ),
      Movie(
        id: 2,
        title: 'The Godfather',
        posterPath: '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
        overview:
            'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
        voteAverage: 8.7,
        releaseDate: '1972-03-14',
        genreIds: [18, 80],
      ),
      Movie(
        id: 3,
        title: 'The Dark Knight',
        posterPath: '/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
        overview:
            'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests.',
        voteAverage: 8.5,
        releaseDate: '2008-07-16',
        genreIds: [18, 28, 80, 53],
      ),
      Movie(
        id: 4,
        title: 'Pulp Fiction',
        posterPath: '/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
        overview:
            'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.',
        voteAverage: 8.5,
        releaseDate: '1994-09-10',
        genreIds: [53, 80],
      ),
      Movie(
        id: 5,
        title: 'Inception',
        posterPath: '/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
        overview:
            'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea.',
        voteAverage: 8.4,
        releaseDate: '2010-07-15',
        genreIds: [28, 878, 53],
      ),
      Movie(
        id: 6,
        title: 'Forrest Gump',
        posterPath: '/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
        overview:
            'The presidencies of Kennedy and Johnson, the Vietnam War, and other historical events unfold from the perspective of an Alabama man.',
        voteAverage: 8.5,
        releaseDate: '1994-06-23',
        genreIds: [35, 18, 10749],
      ),
      Movie(
        id: 7,
        title: 'The Matrix',
        posterPath: '/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
        overview:
            'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
        voteAverage: 8.2,
        releaseDate: '1999-03-30',
        genreIds: [28, 878],
      ),
      Movie(
        id: 8,
        title: 'Interstellar',
        posterPath: '/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
        overview:
            'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
        voteAverage: 8.4,
        releaseDate: '2014-11-05',
        genreIds: [12, 18, 878],
      ),
      Movie(
        id: 9,
        title: 'Goodfellas',
        posterPath: '/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg',
        overview:
            'The story of Henry Hill and his life in the mob, covering his relationship with his wife and his partners in crime.',
        voteAverage: 8.5,
        releaseDate: '1990-09-12',
        genreIds: [18, 80],
      ),
      Movie(
        id: 10,
        title: 'The Lord of the Rings: The Return of the King',
        posterPath: '/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg',
        overview:
            'Gandalf and Aragorn lead the World of Men against Sauron\'s army to draw his gaze from Frodo and Sam.',
        voteAverage: 8.5,
        releaseDate: '2003-12-01',
        genreIds: [12, 14, 28],
      ),
      Movie(
        id: 11,
        title: 'Fight Club',
        posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
        overview:
            'An insomniac office worker and a devil-may-care soap maker form an underground fight club.',
        voteAverage: 8.4,
        releaseDate: '1999-10-15',
        genreIds: [18],
      ),
      Movie(
        id: 12,
        title: 'Parasite',
        posterPath: '/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
        overview:
            'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
        voteAverage: 8.5,
        releaseDate: '2019-05-30',
        genreIds: [35, 53, 18],
      ),
    ];
  }

  static List<Movie> getTrendingMovies() {
    return [
      Movie(
        id: 101,
        title: 'Oppenheimer',
        posterPath: '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
        overview:
            'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
        voteAverage: 8.3,
        releaseDate: '2023-07-19',
        genreIds: [18, 36],
      ),
      Movie(
        id: 102,
        title: 'Barbie',
        posterPath: '/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg',
        overview:
            'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land.',
        voteAverage: 7.2,
        releaseDate: '2023-07-19',
        genreIds: [35, 12, 14],
      ),
      Movie(
        id: 103,
        title: 'Dune: Part Two',
        posterPath: '/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
        overview:
            'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        voteAverage: 8.4,
        releaseDate: '2024-02-27',
        genreIds: [878, 12],
      ),
      Movie(
        id: 104,
        title: 'The Batman',
        posterPath: '/74xTEgt7R36Fpooo50r9T25onhq.jpg',
        overview:
            'When a sadistic serial killer begins murdering key political figures in Gotham, Batman is forced to investigate.',
        voteAverage: 7.7,
        releaseDate: '2022-03-01',
        genreIds: [80, 18, 53],
      ),
      Movie(
        id: 105,
        title: 'Avengers: Endgame',
        posterPath: '/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
        overview:
            'After the devastating events of Infinity War, the Avengers assemble once more to reverse Thanos\' actions.',
        voteAverage: 8.3,
        releaseDate: '2019-04-24',
        genreIds: [28, 12, 878],
      ),
    ];
  }

  static List<Movie> getUpcomingMovies() {
    return [
      Movie(
        id: 201,
        title: 'Deadpool 3',
        posterPath: '/placeholder1.jpg',
        overview: 'The third installment in the Deadpool franchise.',
        voteAverage: 0.0,
        releaseDate: '2024-11-08',
        genreIds: [28, 35],
      ),
      Movie(
        id: 202,
        title: 'Joker: Folie à Deux',
        posterPath: '/placeholder2.jpg',
        overview: 'The sequel to 2019\'s Joker.',
        voteAverage: 0.0,
        releaseDate: '2024-10-04',
        genreIds: [18, 53, 80],
      ),
      Movie(
        id: 203,
        title: 'Avatar 3',
        posterPath: '/placeholder3.jpg',
        overview: 'The third film in James Cameron\'s Avatar franchise.',
        voteAverage: 0.0,
        releaseDate: '2025-12-20',
        genreIds: [28, 12, 14, 878],
      ),
    ];
  }

  static List<Movie> getEmptyList() {
    return [];
  }
}
