import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_1/src/features/home/pages/home_screen.dart';
import 'package:supabase_1/src/features/provider/pages/authprovider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {

  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passowrdcontroller=TextEditingController();

  final _formkey=GlobalKey<FormState>();



  Future<void> checkuser()async{
    final User? currentuser=Supabase.instance.client.auth.currentUser;

    if(currentuser != null){

      WidgetsBinding.instance.addPostFrameCallback((_){
        if(mounted){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
        }
      });
    }
  }

  @override
  void initState(){
    super.initState();
    checkuser();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formkey,
            child: Consumer<AuthProvider>(
              builder: (context, authprovider, child) {
                return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      size: 40,
                      color: Colors.black87,
                    ),
                  ),
              
                  const SizedBox(height: 24),
              
                  // Title
                  const Text(
                    "Mindful Curator",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
              
                  const SizedBox(height: 8),
              
                  const Text(
                    "Capture your thoughts in digital stationery.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
              
                  const SizedBox(height: 50),
              
                  // Full Name
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "FULL NAME",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                   SizedBox(height: 8),
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      
                      contentPadding:  EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
              
                      
                    ),
                    validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Full name is required";
                  }
                  if (value.trim().length < 3) {
                    return "Name must be at least 3 characters";
                  }
                  return null;
                },
                    
                    
                    
                  ),
              
                  const SizedBox(height: 20),
              
                  // Email Address
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "EMAIL ADDRESS",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                   SizedBox(height: 8),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: "hello@curator.com",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                    ),
                    validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  // Simple email validation
                  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegExp.hasMatch(value.trim())) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                  ),
              
                  const SizedBox(height: 20),
              
                  // Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "PASSWORD",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passowrdcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "••••••••••",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                    ),
                    validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return "Password must contain at least 1 uppercase letter";
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return "Password must contain at least 1 lowercase letter";
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return "Password must contain at least 1 number";
                  }
                  return null;
                },
                  ),
              
                   SizedBox(height: 40),
              
                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async{
                        if(_formkey.currentState!.validate()){

                 final result= await authprovider.signupuser(namecontroller.text,emailcontroller.text,passowrdcontroller.text);

                 if(result != null && result.user != null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Account created successfully"),backgroundColor: Colors.green,)
                  );

                   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                 }
                 else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Signup failed $e"),backgroundColor: Colors.red,)
                  );
                 }
                          
              
                          
                          
              
                         
              
                        }
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Create Account →",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 30),
              
                  // Sign In Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
              },
              
            ),
          ),
        ),
      ),
    );
  }
}