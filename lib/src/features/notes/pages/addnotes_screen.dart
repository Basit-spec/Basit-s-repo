import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_1/src/features/provider/pages/taskprovider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {


 

  TextEditingController titlecontroller=TextEditingController();
  TextEditingController descriptioncontroller=TextEditingController();

 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Add Notes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
       
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Consumer<TaskProvider>(
          builder: (context, taskprovider, child) {
            return SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                        
                TextFormField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                        
                SizedBox(
                  height: 10,
                ),
                
                TextFormField(
                  controller: descriptioncontroller,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                        
                SizedBox(
                  height: 30,
                ),
                        
                        
                // Date and Pinned Row
                Consumer<TaskProvider>(
                  builder: (context, provider, child) {
                    return Row(
                    children: [
                       GestureDetector(
                        onTap: ()async {
                          DateTime? pickeddate = await showDatePicker(context: context, firstDate: DateTime(2000),
                           lastDate: DateTime(2100),initialDate:provider.selecteddate ??  DateTime.now());
                  
                           if(pickeddate != null){
                            provider.changedate(pickeddate);
                            
                           }
                        },
                        child: Icon(Icons.calendar_today, size: 18, color: Colors.grey)),
                     SizedBox(width: 8),
                       Text(
                       provider.selecteddate !=null?
                        "${provider.selecteddate!.day} ${provider.selecteddate!.month}, ${provider.selecteddate!.year}":"No Date",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      
                    ],
                  );
                  },
                
                ),
                        
                const SizedBox(height: 20),
                        
                // Untitled Thought
                const Text(
                  "Untitled Thought",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                        
                const SizedBox(height: 30),
                        
                // Priority Level
                const Text(
                  "PRIORITY LEVEL",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
                 SizedBox(height: 10),



                Consumer<TaskProvider>(
                  builder: (context, provider, child) {

                    return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.changepriority("Low");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color:provider.priority=="Low"?Color(0xFFFFE4C4):Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child:  Center(
                              child: Text(
                                "LOW",
                                style: TextStyle(fontWeight: FontWeight.w500,color:provider.priority=="Low"?Colors.orange:Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                           provider.changepriority("Medium");
                          },
                          child: Container(
                            padding:  EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: provider.priority=="Medium"?Color(0xFFFFE4C4):Colors.grey.shade100, // light orange
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                "MEDIUM",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:provider.priority=="Medium"?Colors.orange:Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                           provider.changepriority("High");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color:provider.priority=="High"?Color(0xFFFFE4C4):Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child:  Center(
                              child: Text(
                                "HIGH",
                                style: TextStyle(fontWeight: FontWeight.w500,color:provider.priority=="High"?Colors.orange:Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                    
                  },
                  
                ),
                        
               
               
                        
               
                        
                const SizedBox(height: 320),
                        
                
                    
                  ElevatedButton(
                        onPressed: () async{
                          await taskprovider.addtask(context: context, fortitle: titlecontroller.text,
                           fordescription: descriptioncontroller.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(120, 60)
                          
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save Note",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    
                 
              ],
                        ),
            );
            
          },
         
        ),
      ),
    );
  }
}