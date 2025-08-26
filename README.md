# firebase_crud

```
**Begineer friendly Crud Operation performed in Flutterfire**
```

## Steps

1. curl -sL https://firebase.tools | bash //install firebase CLI
2. firebase --version //verification
3. firebase login //login to firebase
4. dart pub global activate flutterfire_cli //Initialize Firebase in Your Flutter Project
   and make sure you have created project in firebase
5. flutterfire configure //configure firebase for flutter app
6. dependencies: //Add Firebase Dependencies
   firebase_core:
   firebase_auth:
   cloud_firestore:

# Add other Firebase packages as needed

7. flutter pub get
8. now change ndk to "27.0.12077973" or just remove and minsdk to 23 or higher
9. import 'package:firebase_core/firebase_core.dart'; //Initialization in main.dart
   import 'firebase_options.dart';
10. void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
    }
11. <script src="/__/firebase/init.js"></script> //web
12. Ctrl + F5
