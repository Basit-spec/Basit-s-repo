import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_1/src/features/notes/pages/addnotes_screen.dart';
import 'package:supabase_1/src/features/provider/pages/taskprovider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {


 

 


  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<TaskProvider>(context,listen: false).fetchtasks();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mindful Curator",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.black87, size: 20),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Title
            const Text(
              "My Notes",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Text(
              "Refining thoughts into clarity.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // Filter Chips
            Consumer<TaskProvider>(
              builder: (context, provider, child) {
                return Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      provider.changepriority("All");
                      
                    },
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color:provider.priority=="All"?Colors.orange[100]:Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:  Text(
                        "All",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: provider.priority=="All"?Colors.orange:Colors.black,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(width: 8),
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:  Text(
                      "Pinned",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                padding:  EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Low
                    TextButton(
                      onPressed: () {
                        provider.changepriority("Low");
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: provider.priority=="Low"?Colors.orange[100]:Colors.grey.shade100,
                      
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child:  Text(
                        "Low",
                        style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: provider.priority=="Low"?Colors.orange:Colors.black,
                        ),
                      ),
                    ),
              
                    // Medium
                    TextButton(
                      onPressed: () {
                        provider.changepriority("Medium");
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: provider.priority=="Medium"?Colors.orange[100]:Colors.grey.shade100,
                       
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child:  Text(
                        "Medium",
                        style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: provider.priority=="Medium"?Colors.orange:Colors.black,
                        ),
                      ),
                    ),
              
                    // High
                    TextButton(
                      onPressed: () {
                        provider.changepriority("High");
                      },
                      style: TextButton.styleFrom(

                        backgroundColor: provider.priority=="High"?Colors.orange[100]:Colors.grey.shade100,
                      
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child:  Text(
                        "High",
                        style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: provider.priority=="High"?Colors.orange:Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                ],
              );
                
              },
               
            ),

            const SizedBox(height: 25),

            // Notes List using ListView.builder
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, provider, child) {

                    final task=provider.filtertasks();


                return  ListView.builder(

                


                  itemCount: task.length, 
                  itemBuilder: (context, index) {
                    return Dismissible(
  key: Key(task[index]["id"].toString()),
  direction: DismissDirection.endToStart,

  onDismissed: (direction) {
    Provider.of<TaskProvider>(context, listen: false).deletetask(
      context: context,
      taskid: task[index]["id"].toString(),
    );
  },

  background: Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(Icons.delete, color: Colors.white),
  ),

  child: Card(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task[index]["title"] ?? "No Title",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
               Consumer<TaskProvider>(
                builder: (context, provider, child) {

                  return  GestureDetector(
                  onTap: () {
                   provider.tooglepin(currentpin: task[index]['pinned']?? false, forid: task[index]['id'].toString(), context: context);
                  },
                  child: Icon(Icons.push_pin, color: (task[index]["pinned"]?? false)?Colors.purple:Colors.grey, size: 20));
                  
                },
                 
               ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            task[index]["description"] ?? "No Description",
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                task[index]["selecteddate"] ?? "No Date",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task[index]["priority"] ?? "No",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
                    
                  },
                );
                  
                },
                 
              ),

            ),

            SizedBox(
              height: 40,
            )
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNoteScreen()));
        },
        backgroundColor: Colors.black87,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      
    
    );
  }
}