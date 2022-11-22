import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_flutter/screens/add_post_screen.dart';
import 'package:post_flutter/screens/feed_screen.dart';
import 'package:post_flutter/screens/search_screen.dart';
import 'package:post_flutter/screens/profile_screen.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
 
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];
