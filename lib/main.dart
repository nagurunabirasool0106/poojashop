// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mera_upsc/app.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'app_state.dart';
import 'my_app.dart';
// import 'home_page.dart';
// import 'homePage/screen.dart';
// import 'package:mera_upsc/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, build) => const AppMain()),
  ));
}

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context);
    // print(appState.loggedIn);
    //Add GoRouter configuration outside the App class
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            if (appState.loggedIn) {
              return const MyApp();
            } else {
              return SignInScreen(
                actions: [
                  ForgotPasswordAction(((context, email) {
                    final uri = Uri(
                      path: '/sign-in/forgot-password',
                      queryParameters: <String, String?>{
                        'email': email,
                      },
                    );
                    context.push(uri.toString());
                  })),
                  AuthStateChangeAction(((context, state) {
                    final user = switch (state) {
                      SignedIn state => state.user,
                      UserCreated state => state.credential.user,
                      _ => null
                    };
                    if (user == null) {
                      return;
                    }
                    if (state is UserCreated) {
                      user.updateDisplayName(user.email!.split('@')[0]);
                    }
                    if (!user.emailVerified) {
                      user.sendEmailVerification();
                      const snackBar = SnackBar(
                          content: Text(
                              'Please check your email to verify your email address'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    context.pushReplacement('/home');
                  })),
                ],
              );
            }
          },
          routes: [
            GoRoute(
              path: 'sign-in',
              builder: (BuildContext context, GoRouterState state) {
                return SignInScreen(
                  actions: [
                    ForgotPasswordAction(((context, email) {
                      final uri = Uri(
                        path: '/sign-in/forgot-password',
                        queryParameters: <String, String?>{
                          'email': email,
                        },
                      );
                      context.push(uri.toString());
                    })),
                    AuthStateChangeAction(((context, state) {
                      final user = switch (state) {
                        SignedIn state => state.user,
                        UserCreated state => state.credential.user,
                        _ => null
                      };
                      if (user == null) {
                        return;
                      }
                      if (state is UserCreated) {
                        user.updateDisplayName(user.email!.split('@')[0]);
                      }
                      if (!user.emailVerified) {
                        user.sendEmailVerification();
                        const snackBar = SnackBar(
                            content: Text(
                                'Please check your email to verify your email address'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      context.pushReplacement('/home');
                    })),
                  ],
                );
              },
              routes: [
                GoRoute(
                  path: 'forgot-password',
                  builder: (context, state) {
                    final arguments = state.queryParameters;
                    return ForgotPasswordScreen(
                      email: arguments['email'],
                      headerMaxExtent: 200,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) {
                return ProfileScreen(
                  providers: const [],
                  actions: [
                    SignedOutAction((context) {
                      context.pushReplacement('/');
                    }),
                  ],
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const MyApp();
          },
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        if (!appState.loggedIn) {
          return '/sign-in';
        } else {
          return '/';
        }
      },
    );
// end of GoRouter configuration
    // Change MaterialApp to MaterialApp.router and add the routerConfig
    return MaterialApp.router(
      title: 'Mera UPSC',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.white70,
            ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
