// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:template_flutter/features/product/presentation/products.dart';
import '../features/auth/presentation/login.dart';
import '../features/auth/presentation/signup.dart';
import '../features/product/presentation/product_details.dart';
import '../features/product/presentation/products_with_pagination.dart'
    as products_pagination;
import '../features/user_profile/presentation/profile.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  // Auth Routes
  static const String loginScreen = '/logIn';
  static const String signUpScreen = '/signUp';
  static const String forgotPWScreen = '/ForgotPWScreen';
  static const String otpScreen = '/OtpScreen';
  static const String setPassword = '/SetPassword';
  //products_with_pagination
  static const String productsWithPagination = '/ProductsWithPagination';
  //ProductsScreen
  static const String productsScreen = '/ProductsScreen';
  //ProductDetailsScreen
  static const String productDetailsScreen = '/ProductDetailsScreen';

  // Main App Routes
  static const String homeScreen = '/home_screen';
  static const String navigationScreen = '/NavigationScreen';
  static const String profile = '/Profile';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case Routes.loginScreen:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(builder: (context) => const LoginScreen())
            : _FadedTransitionRoute(
                widget: const LoginScreen(), settings: settings);

      case Routes.signUpScreen:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(builder: (context) => const SignUpScreen())
            : _FadedTransitionRoute(
                widget: const SignUpScreen(), settings: settings);

      case Routes.productsWithPagination:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(
                builder: (context) =>
                    const products_pagination.ProductsScreen())
            : _FadedTransitionRoute(
                widget: const products_pagination.ProductsScreen(),
                settings: settings);
      case Routes.productsScreen:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(builder: (context) => const ProductsScreen())
            : _FadedTransitionRoute(
                widget: const ProductsScreen(), settings: settings);
      case Routes.productDetailsScreen:
        final args = settings.arguments as Map;
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(productId: args['productId']))
            : _FadedTransitionRoute(
                widget: ProductDetailsScreen(productId: args['productId']),
                settings: settings);

      // case Routes.forgotPWScreen:
      //   return defaultTargetPlatform == TargetPlatform.iOS
      //       ? CupertinoPageRoute(builder: (context) => const ForgotPWScreen())
      //       : _FadedTransitionRoute(widget: const ForgotPWScreen(), settings: settings);

      // case Routes.otpScreen:
      //   final args = settings.arguments as Map;
      //   return defaultTargetPlatform == TargetPlatform.iOS
      //       ? CupertinoPageRoute(builder: (context) => OtpScreen(isFromLogin: args['isFromLogin']))
      //       : _FadedTransitionRoute(
      //           widget: OtpScreen(isFromLogin: args['isFromLogin']),
      //           settings: settings
      //         );

      // case Routes.setPassword:
      //   final args = settings.arguments as Map;
      //   return defaultTargetPlatform == TargetPlatform.iOS
      //       ? CupertinoPageRoute(builder: (context) => SetPasswordScreen(name: args['name'], email: args['email']))
      //       : _FadedTransitionRoute(
      //           widget: SetPasswordScreen(name: args['name'], email: args['email']),
      //           settings: settings
      //         );

      // // Main App Routes
      // case Routes.homeScreen:
      //   return defaultTargetPlatform == TargetPlatform.iOS
      //       ? CupertinoPageRoute(builder: (context) => const HomeScreen())
      //       : _FadedTransitionRoute(widget: const HomeScreen(), settings: settings);

      // case Routes.navigationScreen:
      //   return defaultTargetPlatform == TargetPlatform.iOS
      //       ? CupertinoPageRoute(builder: (context) => const NavigationScreen())
      //       : _FadedTransitionRoute(widget: const NavigationScreen(), settings: settings);

      case Routes.profile:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(builder: (context) => const ProfileScreen())
            : _FadedTransitionRoute(
                widget: const ProfileScreen(), settings: settings);

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
