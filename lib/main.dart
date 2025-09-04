import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'provider/user_provider.dart';
import 'provider/notes_provider.dart';
import 'auth/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://keoqvlvoyjzoxobmgqms.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtlb3F2bHZveWp6b3hvYm1ncW1zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYzNjAwNTgsImV4cCI6MjA3MTkzNjA1OH0.pUguPcAepmVyb_QqjX7UUSkn7AW5LisN7X1rPHXLrV4",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        home: const SignInPage(),
      ),
    );
  }
}
