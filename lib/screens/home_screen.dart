import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/models/profileImage.dart';
import 'package:quiz_app/screens/no_internet.dart';
import 'package:quiz_app/screens/start.dart';
import 'package:quiz_app/services/auth/authentication.dart';
import 'package:quiz_app/widgets/my_clipper.dart';
import 'package:quiz_app/widgets/quiz_options.dart';
import 'package:quiz_app/widgets/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = categories;
  final List<ProfileImage> profileItem = [];
  bool isLoading = false;
  bool isProfileLoading = false;
  String? displayName, photoUrl;

  late StreamSubscription subscription;
  ConnectivityResult result = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loadProfile();
      loadData();
    });

    subscription = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future loadProfile() async {
    setState(() {
      isProfileLoading = true;
    });

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedName = sharedPreferences.getString("displayName");
    var obtainedPhotoUrl = sharedPreferences.getString("photoUrl");
    setState(() {
      photoUrl = obtainedPhotoUrl;
      displayName = obtainedName;
    });

    profileItem.add(ProfileImage(
        photoUrl: photoUrl.toString(), name: displayName.toString()));
    await Future.wait(profileItem.map((e) => cacheProfileImage(context, e)));

    setState(() {
      isProfileLoading = false;
    });
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });

    await Future.wait(
        items.map((urlImage) => cacheImage(context, urlImage)).toList());

    setState(() {
      isLoading = false;
    });
  }

  Future cacheImage(BuildContext context, Category urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage.imgUrl), context);

  Future cacheProfileImage(BuildContext context, ProfileImage photoUrl) =>
      precacheImage(CachedNetworkImageProvider(photoUrl.photoUrl), context);

  Widget _buildShimmerItem(BuildContext context, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(children: <Widget>[
        ShimmerWidget.rectangular(
          height: index % 2 == 0 ? 250 : 200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                children: const <Widget>[
                  ShimmerWidget.rectangular(
                      height: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  ShimmerWidget.rectangular(
                      height: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Shimmer.fromColors(
                child: const FaIcon(FontAwesomeIcons.play),
                highlightColor: Colors.grey.shade300,
                baseColor: Colors.grey.shade400,
              ),
            )
          ],
        )
      ]),
    );
  }

  Widget _buildShimmerProfileItem(BuildContext context, Size size) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
          color: const Color(0xFFFAD410),
          width: size.width,
          height: size.height * 0.225,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ShimmerWidget.rectangular(
                          height: 5,
                          width: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      ShimmerWidget.rectangular(
                          height: 4,
                          width: 70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                    ],
                  ),
                  GestureDetector(
                    onDoubleTap: logOut,
                    child: const ShimmerWidget.rectangular(
                        height: 60, width: 60, shape: CircleBorder()),
                  ),
                ]),
          )),
    );
  }

  Widget _buildProfileImage(ProfileImage profileImage, Size size) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
          color: const Color(0xFFFAD410),
          width: size.width,
          height: size.height * 0.225,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome ${profileImage.name}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        profileImage.name,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onDoubleTap: logOut,
                    child: CircleAvatar(
                      radius: 25,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl: profileImage.photoUrl,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                ]),
          )),
    );
  }

  Widget _buildCategoryItem(Category category) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: const Color(0xFFFAD410),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: category.imgUrl,
                  fit: BoxFit.cover,
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Questions: 10",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  iconSize: 20,
                  color: const Color(0xFF1E1B17),
                  icon: const FaIcon(FontAwesomeIcons.play),
                  onPressed: () => _categoryPressed(context, category),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _categoryPressed(BuildContext context, Category category) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuizOptionsDialog(
          category: category,
        ),
        onClosing: () {},
      ),
    );
  }

  Future logOut() async {
    await Provider.of<Authentication>(context, listen: false)
        .logout()
        .whenComplete(() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Start())));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: result == ConnectivityResult.none
          ? NoInternet().noInternet(context)
          : CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (isProfileLoading) {
                      return _buildShimmerProfileItem(context, size);
                    } else {
                      final items = profileItem[index];
                      return _buildProfileImage(items, size);
                    }
                  },
                  childCount: 1,
                )),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Select a category and have fun!!!",
                      style: TextStyle(
                          color: Color(0xFF1E1B17),
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverStaggeredGrid.countBuilder(
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    itemCount: isLoading == true ? 24 : categories.length,
                    itemBuilder: (context, index) {
                      if (isLoading) {
                        return _buildShimmerItem(context, index);
                      } else {
                        final item = items[index];
                        return _buildCategoryItem(item);
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
