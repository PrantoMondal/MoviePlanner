import 'package:movie_planner/src/core/base/base_remote_datasource.dart';
import 'package:movie_planner/src/core/constants/app_strings.dart';
import 'package:movie_planner/src/features/movie_details/data/models/movie_details_model.dart';

class MovieDetailsRemoteDatasource extends BaseRemoteDatasource {
  Future<MovieDetailsModel> fetchMovieDetails(int movieId) async {
    final endpoint = "$baseUrl${AppStrings.urlGetMovieList}/$movieId";
    final api = dioClient.get(endpoint);
    final response = await callApi(api);
    final json = response.data as Map<String, dynamic>;
    return MovieDetailsModel.fromJson(json);
  }
}
