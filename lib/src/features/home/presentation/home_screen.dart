import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../components/competition_card.dart';
import '../providers/carousel_provider.dart';
import '../providers/competition_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competitions = ref.watch(competitionProvider);
    final carousels = ref.watch(carouselBannerProvider);

    return Scaffold(
      backgroundColor: Color(0XFFF1F1F1),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0XFF165F23),
        foregroundColor: Colors.white,
        toolbarHeight: 160,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40.0),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Selamat Datang,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Dimas Andrian',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child:
                          // search bar
                          TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          hintText: 'Cari ...',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    // notification icon button
                    IconButton(
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10.0),
                    // circle avatar
                    InkWell(
                      onTap: () {
                        // * Go route to "/profile"
                        GoRouter.of(context).go('/profile');
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          'DA',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(competitionProvider);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 5.0,
                bottom: 5.0,
              ),
              child: Text("Rekomendasi untuk kamu",
                  style: TextStyle(color: Color(0XFF165F23))),
            ),
            FlutterCarousel(
              options: CarouselOptions(
                height: 100,
                slideIndicator: CircularSlideIndicator(),
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 7),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                enlargeCenterPage: true,
              ),
              items: carousels.map((carousel) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          carousel,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 5.0,
                bottom: 5.0,
              ),
              child: Text("Lomba ini cocok untuk kamu",
                  style: TextStyle(color: Color(0XFF165F23))),
            ),
            competitions.when(
              data: (data) {
                if (data.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final competition = data[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 5.0),
                          child: CompetitionCard(competition: competition),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text('No competitions found'),
                  );
                }
              },
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }
}
