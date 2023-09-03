// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pooja_shop/my_app.dart';
// import 'package:mera_upsc/app_state.dart';
// import 'package:provider/provider.dart';
// import '../main.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !loggedIn
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: StyledButton(
                  onPressed: () {
                    context.push('/sign-in');
                  },
                  child: const Center(
                    child: Text('Get started'),
                  ),
                ),
              )
            : SizedBox(
                height: 100,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Card(
                      color: darkBlue,
                      child: ListTile(
                        textColor: Colors.white,
                        leading: const Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Logout',
                          // selectionColor: Colors.white,
                        ),
                        onTap: () {
                          final router = GoRouter.of(context);
                          // ignore: avoid_print
                          print(router);
                          while (router.canPop()) {
                            router.pop();
                          }
                          router.go('/sign-in');
                          signOut(); // Navigate to the 'sign-in' route
                        },
                      ),
                    )
                  ],
                ),
              ),

        // const Image(
        //   image: AssetImage(
        //     "images/appLogo.png",
        //   ),
        //   height: 250,
        //   width: 150,
        // ),
      ],
    );
  }
}
