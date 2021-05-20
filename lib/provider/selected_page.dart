import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPageProvider = StateProvider.autoDispose<int>((ref) => 0);
