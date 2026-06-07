import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // NEWLY ADDED

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. UPDATE: A new object is no longer created, "instance" is used
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // NEWLY ADDED: Firestore object for database operations
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 2. UPDATE: Initialization of the library is now required before the process
      await _googleSignIn.initialize();

      // 3. UPDATE: The signIn method has been replaced by authenticate
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 4. UPDATE: accessToken is no longer returned by Google.
      // For Firebase authentication, providing only idToken is sufficient.
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);

    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // --- NEWLY ADDED PROFILE SYNCHRONIZATION FUNCTION ---
  // --- UPDATED PROFILE SYNCHRONIZATION AND LIMIT FUNCTION ---
  // Now it returns a message depending on the situation, not just success/failure
  Future<String> syncUserName(String newName) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) return "error";

      final String uid = user.uid;
      final DocumentReference userDocRef = _db.collection('users').doc(uid);

      // Fetch the user's existing data
      final DocumentSnapshot doc = await userDocRef.get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        int changeCount = data['nameChangeCount'] ?? 0;
        Timestamp? lastChange = data['lastNameChangeDate'];

        // 14-DAY RESET CHECK
        if (lastChange != null) {
          final daysPassed = DateTime.now().difference(lastChange.toDate()).inDays;
          if (daysPassed >= 14) {
            changeCount = 0; // Reset the count if 14 days have passed
          }
        }

        // LIMIT CHECK (Max 2 changes in 14 days)
        if (changeCount >= 2) {
          return "limit_reached"; // Notify UI if limit is reached
        }

        // UPDATE USER DATABASE (Increase count by 1 and save the date)
        await userDocRef.set({
          'displayName': newName,
          'nameChangeCount': changeCount + 1,
          'lastNameChangeDate': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

      } else {
        // If first time, save directly
        await userDocRef.set({
          'displayName': newName,
          'nameChangeCount': 1,
          'lastNameChangeDate': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      // UPDATE LEADERBOARD (Using SetOptions(merge: true) prevents crashes)
      await _db.collection('leaderboard').doc(uid).set({
        'displayName': newName,
      }, SetOptions(merge: true));

      await user.updateDisplayName(newName); // Also update Auth as backup
      return "success";

    } catch (e) {
      print("An error occurred while updating the name: $e");
      return "error";
    }
  }
}
