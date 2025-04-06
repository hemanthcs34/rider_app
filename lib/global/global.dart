import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");

User? currentFirebaseUser = FirebaseAuth.instance.currentUser;
