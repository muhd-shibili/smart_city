import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:smart_city/core/provider/auth_provider.dart';

import '../../injection/injection.dart';
import '../cart_provider.dart';

abstract class MultiProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => locator<AuthProvider>(),
    ),
    ChangeNotifierProvider(
      create: (context) => locator<CartProvider>(),
    ),
  ];
}
