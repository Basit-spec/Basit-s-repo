import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier{

  final supabase=Supabase.instance.client;



  Future<AuthResponse?> signupuser(
    
    String name,
    String foremail,
    String forpassword,
  )async{

   try{

    final AuthResponse response=await supabase.auth.signUp(password: forpassword,email: foremail,);

    if(response.user != null){

      await supabase.from("profile").insert({
        "id":response.user!.id,
        "name":name,
        "email":foremail,
        
        "created_at":DateTime.now().toIso8601String(),

      });
    }

    return response;
   }
   on AuthException catch(e){
    print("Signup error ${e.message}");
   }
   catch(e){
    print("Unknown error $e");
   }
   notifyListeners();

  }
 



}