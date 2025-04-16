import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/core/utils/debug.dart';
import 'package:real_estate_app/features/explore/domain/usecases/format_number_usecase.dart';
import 'package:real_estate_app/features/property/domain/entities/property.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_featured_properties.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_search_properties.dart';

part "explore_event.dart";
part "explore_state.dart";

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetFeaturedProperties getFeaturedProperties;
  final GetSearchProperties searchProperties;
  final FormatNumberUseCase formatNumber;
  ExploreBloc({
    required this.getFeaturedProperties,
    required this.searchProperties,
    required this.formatNumber,
  }) : super(ExploreInitial()) {
    on<LoadExploreData>(_onLoadExploreData);
    on<SearchProperties>(_onSearchProperties);
  }

  Future<void> _onLoadExploreData(
    LoadExploreData event,
    Emitter<ExploreState> emit,
  ) async {
    emit(ExploreLoading(
      markers: state.markers,
      cameraPosition: state.cameraPosition,
      properties: state.properties,
    ));
    final result = await getFeaturedProperties();
    if (result.isErr()) {
      emit(ExploreError(
        result.err().toString(),
        cameraPosition: state.cameraPosition,
        properties: state.properties,
        markers: state.markers,
      ));
      return;
    }
    Set<Marker> markers = {};
    await Future.microtask(
      () async => await Future.wait(
        result.ok().map(
          (property) async {
            final marker = Marker(
              markerId: MarkerId("property-${property.id}"),
              position: LatLng(property.latitude, property.longitude),
              icon: await createCustomMarkerBitmap(
                text: "${formatNumber(property.price)} \$",
                width: 180,
                height: 80,
              ),
            );
            markers = {...markers, marker};
            emit(
              ExploreLoaded(
                properties: result.ok(),
                cameraPosition: state.cameraPosition,
                markers: markers,
              ),
            );
          },
        ),
      ).then((v) => v.toSet()),
    );
    debug.log("Markers ${markers.length} Properties ${result.ok().length}");
  }

  Future<void> _onSearchProperties(
    SearchProperties event,
    Emitter<ExploreState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(LoadExploreData());
      return;
    }

    emit(ExploreLoading(
      cameraPosition: state.cameraPosition,
      properties: state.properties,
      markers: state.markers,
    ));
    final result = await searchProperties(event.query);
    if (result.isErr()) {
      emit(
        ExploreError(
          result.err().toString(),
          cameraPosition: state.cameraPosition,
          properties: state.properties,
          markers: state.markers,
        ),
      );
      return;
    }
    final markers = await Future.microtask(
      () async => await Future.wait(
        result.ok().map(
              (property) async => Marker(
                markerId: MarkerId("property-${property.id}"),
                position: LatLng(property.latitude, property.longitude),
                // icon: await createCustomMarkerBitmap(
                //   text: formatNumber(property.price),
                //   icon: Icons.attach_money,
                // ),
              ),
            ),
      ).then((v) => v.toSet()),
    );
    debug.log("markers ${markers.length}");
    emit(
      ExploreLoaded(
        properties: result.ok(),
        cameraPosition: state.cameraPosition,
        markers: markers,
      ),
    );
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap({
    required String text,
    IconData? icon,
    double width = 300,
    double height = 100,
    double borderRadius = 24,
    double fontSize = 26,
    double iconSize = 40,
    Color bgColor = AppColors.primary,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
  }) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    // Draw background with border radius
    final paint = Paint()..color = bgColor;
    final rect = Rect.fromLTRB(
      0,
      0,
      width,
      height,
    );
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomRight: const Radius.circular(20),
      bottomLeft: Radius.zero,
    );
    canvas.drawRRect(rrect, paint);

    if (icon != null) {
      // Draw Icon
      final iconPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontSize: iconSize,
            fontFamily: icon.fontFamily,
            color: iconColor,
            package: icon.fontPackage,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      iconPainter.paint(canvas, Offset(20, (height - iconSize) / 2));
    }
    // Draw Text
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - (icon != null ? iconSize - 60 : 0));

    textPainter.paint(canvas,
        Offset(icon != null ? iconSize + 40 : 10, (height - fontSize) / 2));

    // Convert to Image
    final img =
        await recorder.endRecording().toImage(width.toInt(), height.toInt());
    final data = await img.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.bytes(data!.buffer.asUint8List());
  }
}
