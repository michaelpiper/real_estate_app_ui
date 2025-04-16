import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/core/presentation/widgets/lazy_widget.dart';
import 'package:real_estate_app/core/presentation/widgets/scale_in_widget.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/core/utils/debug.dart';
import 'package:real_estate_app/features/explore/domain/usecases/format_number_usecase.dart';
import 'package:real_estate_app/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:real_estate_app/features/explore/presentation/widgets/map_menu_button.dart';
import 'package:real_estate_app/features/explore/presentation/widgets/search_field.dart';

import 'package:real_estate_app/injection.dart';

const styles = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: BlocProvider(
        create: (context) => getIt.registerSingleton(ExploreBloc(
          getFeaturedProperties: getIt(),
          searchProperties: getIt(),
          formatNumber: FormatNumberUseCase(),
        )..add(LoadExploreData())),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            fit: StackFit.expand,
            children: [
              BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  debug.log("state.properties", state.properties);
                  debug.log("state.markers", state.markers);
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: state.cameraPosition,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    style: styles,
                    markers: state.markers,
                    onTap: (argument) => debug.log("map.latlng", argument),
                    onMapCreated: (GoogleMapController controller) {
                      getIt.registerSingletonIfAbsent(
                        () => controller,
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: LazyVisible.builder(
                            key: const ValueKey("Explore:SearchField"),
                            placeholder: const SizedBox.square(dimension: 32),
                            builder: (context, child) => const ScaleInWidget(
                              duration: Duration(seconds: 1),
                              child: SearchField(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        LazyVisible.builder(
                          key: const ValueKey("Explore:SearchFieldFilters"),
                          placeholder: const SizedBox.square(dimension: 32),
                          builder: (context, child) => ScaleInWidget(
                            duration: const Duration(seconds: 1),
                            child: IconButton(
                              onPressed: () => (),
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.background,
                              ),
                              iconSize: 32,
                              icon: const Icon(
                                Icons.filter_list_rounded,
                                color: AppColors.text,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: BlocBuilder<ExploreBloc, ExploreState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  50 + MediaQuery.of(context).padding.bottom,
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    height: 120,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              LazyVisible.builder(
                                                key: const ValueKey(
                                                    "Explore:account_balance_wallet_rounded"),
                                                placeholder:
                                                    const SizedBox.square(
                                                        dimension: 32),
                                                builder: (context, child) =>
                                                    ScaleInWidget(
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  child: IconButton(
                                                    onPressed: () => (),
                                                    style: IconButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .background
                                                          .withOpacity(0.6),
                                                    ),
                                                    icon: const Icon(
                                                      Icons
                                                          .account_balance_wallet_rounded,
                                                      color:
                                                          AppColors.background,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              LazyVisible.builder(
                                                key: const ValueKey(
                                                    "Explore:menu"),
                                                placeholder:
                                                    const SizedBox.square(
                                                        dimension: 32),
                                                builder: (context, child) =>
                                                    const ScaleInWidget(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  child: MapMenuButton(
                                                    menu: [
                                                      PopupMenuItem(
                                                        value: 1,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .safety_check_outlined,
                                                              color: AppColors
                                                                  .secondary,
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "Cosy areas",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .secondary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 2,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .account_balance_wallet_outlined,
                                                              color: AppColors
                                                                  .primary,
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "Price",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 3,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .breakfast_dining_outlined,
                                                              color: AppColors
                                                                  .secondary,
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "Infrastructure",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .secondary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 4,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.layers,
                                                              color: AppColors
                                                                  .secondary,
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "Without any layer",
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .secondary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    iconData:
                                                        Icons.eco_outlined,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 30,
                                          ),
                                          child: LazyVisible.builder(
                                            key: const ValueKey(
                                                "Explore:ListofVariants"),
                                            placeholder: const SizedBox.square(
                                                dimension: 32),
                                            builder: (context, child) =>
                                                ScaleInWidget(
                                              duration:
                                                  const Duration(seconds: 1),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.background
                                                      .withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                height: 38,
                                                margin: const EdgeInsets.only(
                                                    bottom: 4),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.list_rounded,
                                                      color:
                                                          AppColors.background,
                                                    ),
                                                    Text(
                                                      "List of variants",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .background,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          // if (state is ExploreLoading) {
                          //   return const Center(
                          //     child: CircularProgressIndicator(),
                          //   );
                          // } else if (state is ExploreLoaded) {

                          // } else if (state is ExploreError) {
                          //   return Center(child: Text(state.message));
                          // }
                          // return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
