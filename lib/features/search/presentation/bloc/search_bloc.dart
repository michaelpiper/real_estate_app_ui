import 'package:bloc/bloc.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/search/domain/entities/search_filters.dart';
import 'package:real_estate_app/features/search/domain/usecases/get_filtered_properties.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchedFilteredProperties searchProperties;

  SearchBloc({required this.searchProperties}) : super(SearchInitial()) {
    on<SearchWithFilters>((event, emit) async {
      emit(SearchLoading());
      final result = await searchProperties(event.filters);
      // Handle result
      if (result.isErr()) {
        emit(SearchError(
          message: result.err().toString(),
          filters: event.filters,
        ));
      } else {
        emit(SearchLoaded(
          properties: result.ok(),
          filters: event.filters,
        ));
      }
    });
  }
}
