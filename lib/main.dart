import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:post_flutter/responsive/responsive_layout_screen.dart';
import 'package:post_flutter/ulils/colors.dart';
import 'package:post_flutter/responsive/mobile_screen_layout.dart';
import 'package:post_flutter/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:post_flutter/screens/login_screen.dart';
import 'package:post_flutter/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:post_flutter/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAPAh0jvD3XdfxbOq_s9eRzj3xvzcXP4Qs",
        appId: "1:517718336628:web:36198b9bb90d95eca11d21",
        messagingSenderId: "517718336628",
        projectId: "mini-project-4e988",
        storageBucket: "mini-project-4e988.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
           ChangeNotifierProvider(create: (_) => UserProvider(),)
          
        ],
        child: MaterialApp(
            title: 'post_clone',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark()
                .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
            // home: const ResponsiveLayoutScreen(
            //   mobileScreenLayout: mobileScreenLayout(),
            //   webScreenLayout: WebScreenLayout(),
            // ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                if (snapshot.hasError == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                return const LoginScreen();
              }),
            )));
  }
}
