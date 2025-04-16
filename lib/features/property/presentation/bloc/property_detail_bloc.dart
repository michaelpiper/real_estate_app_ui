import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_property_detail.dart';
// part "property_event.dart";
// part "property_state.dart";

abstract class PropertyDetailState extends Equatable {
  final String propertyId;
  const PropertyDetailState({required this.propertyId});

  @override
  List<Object?> get props => [propertyId];
}

class PropertyDetailLoading extends PropertyDetailState {
  const PropertyDetailLoading({required super.propertyId});
}

abstract class PropertyDetailEvent {
  final String propertyId;

  PropertyDetailEvent({required this.propertyId});
}

class LoadPropertyDetail extends PropertyDetailEvent {
  LoadPropertyDetail({required super.propertyId});
}

class PropertyDetailError extends PropertyDetailState {
  final String message;

  const PropertyDetailError({
    required super.propertyId,
    required this.message,
  });
}

class PropertyDetailLoaded extends PropertyDetailState {
  final Property property;
  const PropertyDetailLoaded({
    required super.propertyId,
    required this.property,
  });
}

class PropertyDetailBloc
    extends Bloc<PropertyDetailEvent, PropertyDetailState> {
  final GetPropertyDetail getPropertyDetails;

  PropertyDetailBloc({
    required this.getPropertyDetails,
    required String propertyId,
  }) : super(PropertyDetailLoading(propertyId: propertyId)) {
    on<LoadPropertyDetail>(_onLoadProperties);
  }
  Future<void> _onLoadProperties(
    LoadPropertyDetail event,
    Emitter<PropertyDetailState> emit,
  ) async {
    emit(PropertyDetailLoading(propertyId: event.propertyId));
    final result = await getPropertyDetails(event.propertyId);
    if (result.isErr()) {
      emit(PropertyDetailError(
        message: result.err().toString(),
        propertyId: event.propertyId,
      ));
    } else {
      emit(PropertyDetailLoaded(
        property: result.ok(),
        propertyId: event.propertyId,
      ));
    }
  }
}
