import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_1/src/features/auth/pages/signup_screen.dart';
import 'package:supabase_1/src/features/home/pages/home_screen.dart';
import 'package:supabase_1/src/features/notes/pages/addnotes_screen.dart';
import 'package:supabase_1/src/features/provider/pages/authprovider.dart';
import 'package:supabase_1/src/features/provider/pages/taskprovider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hqvaajuewsdhyimgnivy.supabase.co',
    anonKey: 'sb_publishable_2Vlju9zZmp7Ts5juuhBv2w_UooqMCWI',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AuthProvider()),
        ChangeNotifierProvider(create: (context)=>TaskProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        
        home: SignupScreen (),
      ),
    );
  }
}

