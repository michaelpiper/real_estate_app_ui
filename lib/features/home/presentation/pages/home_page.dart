import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/core/presentation/widgets/swipe_detect.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/features/explore/presentation/widgets/property_grid.dart';
import 'package:real_estate_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:real_estate_app/core/presentation/widgets/count_up_animation.dart';
import 'package:real_estate_app/core/presentation/widgets/grow_height_animation.dart';
import 'package:real_estate_app/core/presentation/widgets/reveal_text.dart';
import 'package:real_estate_app/core/presentation/widgets/scale_in_widget.dart';
import 'package:real_estate_app/core/presentation/widgets/scroll_up.dart';
import 'package:real_estate_app/injection.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final topMargin = 28.0;
  final scrollController = ScrollController();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double _currentHeight = 0;
  double _lastOffset = 0;
  double maxHeight = 0;
  double minHeight = 370;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(
      () => _onScroll(widget.scrollController),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        maxHeight = MediaQuery.of(context).size.height - 270;
        _currentHeight = maxHeight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: BlocProvider(
        create: (context) => getIt.registerSingletonIfAbsent<HomeBloc>(() {
          final bloc = HomeBloc(getFeaturedProperties: getIt());
          Future.microtask(() {
            bloc.add(LoadHomeData());
            bloc.stream.listen((state) {
              if (state is HomeLoaded && context.mounted) {
                bloc.add(PreCachePropertyImages(context));
              }
            });
          });
          return bloc;
        }),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.main.lightest,
            // AppColors.main.lighter,
            // AppColors.main.light,
            AppColors.primary.light,
            // AppColors.primary,
            // AppColors.background,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: SizedBox(
              height: 55,
              child: _buildAppBar(),
            ),
          ),
          Expanded(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScrollUpWidthAnimation(
            delay: const Duration(milliseconds: 500),
            child: Container(
              // height: 30,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: AppColors.secondary,
                  ),
                  _Title(
                    "Saint Petersburg",
                    fontSize: 14,
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ),
          ),

          // titleTextStyle: TextStyle(),

          ScaleInWidget(
            duration: const Duration(milliseconds: 400),
            child: ClipOval(
              child: Image.asset(
                "assets/images/profile.png",
                width: 45,
                height: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll(ScrollController controller) {
    final offset = controller.offset;
    final delta = offset - _lastOffset;

    setState(() {
      _currentHeight = (_currentHeight - delta).clamp(minHeight, maxHeight);
      _lastOffset = offset;
    });
    // final offset = controller.offset;
    // final delta = offset - _lastOffset;

    // setState(() {
    //   _currentHeight =
    //       (_currentHeight + delta * -1.5).clamp(minHeight, maxHeight);
    // });

    // _lastOffset = offset;
  }

  _buildBody(BuildContext context) {
    final cardWidth = ((MediaQuery.of(context).size.width / 2) - (8 + 16));

    return Padding(
      padding: EdgeInsets.only(
        top: widget.topMargin,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _Title(
                  "Hi, Marina",
                  color: AppColors.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  animate: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _Title(
                  "let's select your\nperfect place",
                  color: AppColors.text,
                  animate: true,
                  delay: Duration(milliseconds: 1400),
                ),
              ),
              // const RevealTextAnimation(),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: widget.topMargin),
                child: Row(
                  children: [
                    Expanded(
                      child: ScaleInWidget(
                        duration: const Duration(milliseconds: 3000),
                        delay: const Duration(milliseconds: 2000),
                        child: _Card(
                          title: const _Title(
                            "BUY",
                            fontSize: 14,
                            color: AppColors.background,
                          ),
                          subtitle: const _Title(
                            "Offers",
                            fontSize: 14,
                            color: AppColors.background,
                          ),
                          content: const CountUpAnimation(
                            target: 1034,
                            duration: Duration(seconds: 3),
                            delay: Duration(milliseconds: 500),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.background,
                            ),
                          ),
                          radius: cardWidth / 2,
                          width: cardWidth,
                          height: cardWidth,
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ScaleInWidget(
                        duration: const Duration(milliseconds: 3000),
                        delay: const Duration(milliseconds: 2000),
                        child: _Card(
                          title: const _Title(
                            "RENT",
                            fontSize: 14,
                          ),
                          content: const CountUpAnimation(
                            target: 2212,
                            duration: Duration(seconds: 3),
                            delay: Duration(milliseconds: 500),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),

                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.main.lighter,
                              AppColors.background,
                            ],
                          ),
                          subtitle: const _Title(
                            "Offers",
                            fontSize: 14,
                            color: AppColors.secondary,
                          ),
                          radius: 18,
                          width: cardWidth,
                          height: cardWidth,
                          // backgroundColor: AppColors.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  // AnimatedContainer(
                  //   // collapsible top section
                  //   height: _currentHeight,
                  //   duration: Duration(milliseconds: 300),
                  //   // child: _TopCards(),
                  // ),
                  const Expanded(child: SizedBox.expand()),
                  SwipeDetector(
                    onSwipeUp: () => setState(() {
                      _currentHeight = maxHeight;
                    }),
                    onSwipeDown: () => setState(() {
                      _currentHeight = minHeight;
                    }),
                  ),
                  GrowHeightAnimation(
                    duration: const Duration(milliseconds: 1000),
                    delay: const Duration(milliseconds: 4000),
                    height: _currentHeight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 8,
                          bottom: 80 + MediaQuery.of(context).padding.bottom,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) =>
                                  PropertyGrid(properties: state.properties),
                            ),
                          ],
                        ),
                        // property listings
                      ),
                    ),
                  ),
                ],
              )

              //  SingleChildScrollView(
              //   // padding: EdgeInsets.zero,
              //   // physics: const AlwaysScrollableScrollPhysics(),
              //   controller: widget.scrollController,
              //   child: SizedBox(
              //     height: maxHeight,
              //     child: GrowHeightAnimation(
              //       duration: const Duration(milliseconds: 1000),
              //       delay: const Duration(milliseconds: 4000),
              //       child: Container(
              //         decoration: BoxDecoration(
              //           color: AppColors.background,
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //         height: maxHeight,
              //         child: Padding(
              //           padding: EdgeInsets.only(
              //             left: 8,
              //             right: 8,
              //             top: 8,
              //             bottom: 80 + MediaQuery.of(context).padding.bottom,
              //           ),
              //           child: BlocBuilder<HomeBloc, HomeState>(
              //             builder: (context, state) =>
              //                 PropertyGrid(properties: state.properties),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget title;
  final Widget subtitle;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Widget content;
  final double radius;
  const _Card({
    this.height,
    this.width,
    required this.title,
    required this.subtitle,
    required this.content,
    this.backgroundColor,
    this.gradient,
    this.radius = 8,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.01),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: title,
          ),
          Center(
            child: content,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: subtitle,
            ),
          ),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String label;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool animate;
  final Duration delay;
  const _Text(
    this.label, {
    this.color,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.animate = false,
    this.delay = Duration.zero,
  });
  @override
  Widget build(BuildContext context) {
    if (!animate) {
      return Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
    }
    return RevealTextAnimation(
      label,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      delay: delay,
    );
  }
}

class _Title extends _Text {
  const _Title(
    super.label, {
    super.color,
    super.fontSize = 30,
    super.fontWeight = FontWeight.normal,
    super.animate = false,
    super.delay,
  });
}
