import 'package:flutter_riverpod/flutter_riverpod.dart';

final carouselBannerProvider = StateProvider<List<String>>((ref) => [
  'assets/image/Banner 1.png',
  'assets/image/Banner 2.png',
  'assets/image/Banner 3.png',
]);