

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
User? currentFirebaseUser;