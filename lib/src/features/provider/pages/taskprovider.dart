import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskProvider extends ChangeNotifier {



  final supabase = Supabase.instance.client;



  List<Map<String,dynamic>> tasklist=[];

   String priority="All";

   void changepriority(String value){
    priority=value;
    notifyListeners();
   }



    DateTime? selecteddate;

    void changedate(DateTime? value){
      selecteddate=value;
      notifyListeners();
    }



    

     Future<void> tooglepin({
      required bool currentpin,
      required String forid,
      required BuildContext context,
     }) async{

      final newpin=!currentpin;

      await supabase.from('tasks').update({'pinned':newpin}).eq('id',forid);

      final result=tasklist.indexWhere((e)=>e['id'].toString()==forid);

      if(result != -1){

        tasklist[result]['pinned']=newpin;
      }

      notifyListeners();
     }






  Future<void> addtask({
    required BuildContext context,
    required String fortitle,
    required String fordescription,
  }) async {
    try {
      final currentUser = supabase.auth.currentUser;

      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please login first")),
        );
        return;
      }

   
      final Map<String, dynamic> taskData = {
        'user_id': currentUser.id,
        'title': fortitle,
        'description': fordescription,
        'priority':priority,
        'pinned':false,
        'selecteddate':selecteddate?.toIso8601String(),
      'created_at':DateTime.now().toIso8601String(),
      
      };

    final result=  await supabase.from('tasks').insert(taskData).select();

    if(result.isNotEmpty){
      final newtask=result.first;

      tasklist.add(newtask);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Task created successfully!"),
          backgroundColor: Colors.green,
        ),
      );

       Navigator.pop(context);

      notifyListeners();
    }

      

  
      

     
     
    } 
    catch (e) {
      print("Task Add Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add task: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }




  // fetch function

  Future<void> fetchtasks()async{

   try{
     final currentuser=Supabase.instance.client.auth.currentUser;

    if(currentuser == null){
      print("No user found");
      return;
    }

    final response= await Supabase.instance.client.from("tasks").select().eq("user_id",currentuser.id )
    .order("created_at",ascending: false);

    tasklist= List<Map<String,dynamic>>.from(response);

    print("✅ Tasks successfully loaded: ${tasklist.length}");

    notifyListeners();
   }
   catch(e){
    print(" Error fetching tasks: $e");
   }
  }



  // filter function

  List<Map<String,dynamic>> filtertasks(){

    if(priority=="All"){
      return tasklist;
    }

    if(priority=="Low"){
      return tasklist.where((task)=> task["priority"]=="Low").toList();
    }

    if(priority=="Medium"){
      return tasklist.where((task)=>task["priority"]=="Medium").toList();
    }

    if(priority=="High"){
      return tasklist.where((task)=>task["priority"]=="High").toList();
    }

    return tasklist;

  }




  // function for delete task

  Future<void> deletetask({
    required BuildContext context,
    required String taskid,
  })
  async{
    try{

      final currentuser=supabase.auth.currentUser;

      if(currentuser == null){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login first")),
      );
        return;
      }

      await supabase.from('tasks').delete().eq('id', taskid).eq('user_id', currentuser.id);

      tasklist.removeWhere((task)=>task['id'].toString()==taskid);


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task deleted successfully"))
      );
    }
    catch(e){

      print("Delete Task Error: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed to delete task: ${e.toString()}"),
        backgroundColor: Colors.red,
      ),
    );

    }
    notifyListeners();
  }
}