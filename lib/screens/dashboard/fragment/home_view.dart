import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/category_model.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/category/category_services_screen.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/home_fake_data.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/home_widgets.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeData {
  final List<CategoryData> categories;
  final List<ServiceData> topRated;
  final List<ServiceData> services;
  final List<dynamic> banners;

  HomeData({this.categories = const [], this.topRated = const [], this.services = const [], this.banners = const []});
}

Future<HomeData> fetchHomeData() async {
  List<CategoryData> categories = [];
  List<ServiceData> topRated = [];
  List<ServiceData> services = [];
  List<dynamic> banners = [];
  try {
    final catRes = await getCategoryList('1');
    categories = catRes.categoryList.validate();
  } catch (_) {}
  try {
    final dash = await userDashboard(isCurrentLocation: false);
    topRated = dash.featuredServices.validate();
    services = dash.service.validate();
    final promo = dash.promotionalBanner.validate();
    final bannerList = (promo.isNotEmpty && appConfigurationStore.isPromotionalBanner) ? promo : dash.slider.validate();
    banners.addAll(bannerList);
  } catch (_) {}
  // Use fake demo data when API returns empty so you can see the redesigned home
  if (categories.isEmpty) categories.addAll(getFakeCategories());
  if (services.isEmpty) services.addAll(getFakeServices());
  if (topRated.isEmpty) topRated.addAll(services.take(6));
  if (banners.isEmpty) banners.addAll(getFakeBanners());
  return HomeData(categories: categories, topRated: topRated, services: services, banners: banners);
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<HomeData>? _future;
  int _selectedCategoryIndex = 0;
  int? selectedCategoryId;
  String? selectedCategoryName;
  bool isCategoryLoading = false;
  List<ServiceData> filteredServices = [];

  /// Load home data only once; skip refetch when returning from Profile/Chat tab.
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _load();
    LiveStream().on(LIVESTREAM_UPDATE_DASHBOARD, (_) => _load(force: true));
  }

  void _load({bool force = false}) {
    if (_isDataLoaded && !force) return;
    if (force) _isDataLoaded = false;
    final f = fetchHomeData();
    f.whenComplete(() {

      if (mounted) setState(() => _isDataLoaded = true);
    });
    setState(() {
      _future = f;
    });
  }

  Future<void> _loadServicesForCategory(int categoryId, String categoryName) async {
    setState(() {
      selectedCategoryId = categoryId;
      selectedCategoryName = categoryName;
      isCategoryLoading = true;
      filteredServices = [];
    });

    try {
      final list = <ServiceData>[];
      await searchServiceAPI(
        categoryId: categoryId.toString(),
        latitude: getDoubleAsync(LATITUDE).toString(),
        longitude: getDoubleAsync(LONGITUDE).toString(),
        page: 1,
        list: list,
      );

      if (!mounted) return;
      setState(() {
        filteredServices = List<ServiceData>.from(list);
        isCategoryLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        filteredServices = [];
        isCategoryLoading = false;
      });
    }
  }

  void _onCategorySelected(int index, List<CategoryData> categories) {
    setState(() => _selectedCategoryIndex = index);

    // index 0 = "For you" (no filter)
    if (index == 0) {
      setState(() {
        selectedCategoryId = null;
        selectedCategoryName = null;
        isCategoryLoading = false;
        filteredServices = [];
      });
      return;
    }

    final cat = categories[index - 1];
    _loadServicesForCategory(cat.id.validate(), cat.name.validate());
  }

  Widget _buildDefaultBottom(BuildContext context, HomeData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: rh(context, 12)),
        homeTopRated(context, data.topRated),
        SizedBox(height: rh(context, 12)),
        HomeSectionDivider(),
        SizedBox(height: rh(context, 8)),
        ...List.generate(data.categories.length, (i) {
          final cat = data.categories[i];
          final list = data.services.where((s) => s.categoryId == cat.id).toList();
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: rh(context, 16)),
                child: homeCategoryServicesSection(
                  context,
                  '${cat.name.validate()}',
                  list,
                  cat.id,
                  categoryName: cat.name,
                ),
              ),
              if (i != data.categories.length - 1) ...[
                SizedBox(height: rh(context, 12)),
                HomeSectionDivider(),
              ],
            ],
          );
        }),
      ],
    );
  }

  Widget _buildFilteredBottom(BuildContext context) {
    final title = selectedCategoryName.validate();
    final categoryId = selectedCategoryId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: rh(context, 12)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: boldTextStyle(
                    size: (rs(context, TEXT_SIZE_TITLE)).round(),
                    fontFamily: 'Inter',
                    color: appStore.isDarkMode ? Colors.white : primaryColor,
                  ),
                ),
              ),
              if (categoryId != null)
                GestureDetector(
                  onTap: () => CategoryServicesScreen(
                    categoryId: categoryId,
                    categoryName: title,
                  ).launch(context),
                  child: Text(
                    'See all',
                    style: secondaryTextStyle(
                      size: (rs(context, LABEL_TEXT_SIZE.toDouble())).round(),
                      fontFamily: 'Inter',
                      color: appStore.isDarkMode ? Colors.white70 : primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: rh(context, 8)),
        if (isCategoryLoading)
          SizedBox(
            height: rh(context, 330),
            child: Center(
              child: CircularProgressIndicator(color: primaryColor),
            ),
          )
        else if (filteredServices.isEmpty)
          SizedBox(
            height: rh(context, 330),
            child: Center(
              child: homePlaceholderCard(
                context,
                icon: Icons.search_off_rounded,
                message: 'No services available',
              ),
            ),
          )
        else
          SizedBox(
            height: rh(context, 330),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
              itemCount: filteredServices.length,
              itemBuilder: (ctx, i) => homeActivityCard(ctx, filteredServices[i]),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeData>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting && !snap.hasData) {
          return SizedBox.expand(child: Center(child: CircularProgressIndicator(color: primaryColor)));
        }
        if (snap.hasError) {
          return SizedBox.expand(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('${snap.error}', textAlign: TextAlign.center),
              ),
            ),
          );
        }
        final data = snap.data ?? HomeData();
        return RefreshIndicator(
          onRefresh: () async {
            setValue(LAST_APP_CONFIGURATION_SYNCED_TIME, 0);
            _load(force: true);
            await 2.seconds.delay;
          },
          color: primaryColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: rh(context, 24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homeHeroBanner(context,
                  data.banners,
                  data.categories,
                  _selectedCategoryIndex,
                  (i) => _onCategorySelected(i, data.categories),

                ),
                SizedBox(height: rh(context, 16)),
                // homeCategoryChips(
                //   context,
                //   data.categories,
                //   selectedIndex: _selectedCategoryIndex,
                //   onSelected: (i) => _onCategorySelected(i, data.categories),
                // ),
                if (selectedCategoryId == null) _buildDefaultBottom(context, data) else _buildFilteredBottom(context),
              ],
            ),
          ),
        );
      },
    );
  }
}
