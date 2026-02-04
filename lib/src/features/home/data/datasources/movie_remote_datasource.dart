import 'package:movie_planner/src/core/base/base_remote_datasource.dart';
import 'package:movie_planner/src/core/constants/app_strings.dart';
import 'package:movie_planner/src/features/home/data/models/movie_list_response.dart';

class MovieRemoteDatasource extends BaseRemoteDatasource {
  Future<MovieListResponse> fetchMovies({
    required String category,
    required int page,
  }) async {
    final endpoint = "$baseUrl${AppStrings.urlGetMovieList}/$category";
    final api = dioClient.get(endpoint, queryParameters: {"page": page});
    final response = await callApi(api);
    final json = response.data;
    logger.d(json);
    return MovieListResponse.fromJson(json);
  }
}
