import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:environment_app/view_models/add_env_view_model.dart';
import 'package:environment_app/widgets/pick_file.dart';

class AddEnvScreen extends StatefulWidget {
  String? title;
  String? description;
  String? imagePath;

  @override
  State<AddEnvScreen> createState() => _AddEnvScreenState();
}

class _AddEnvScreenState extends State<AddEnvScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final vm = Provider.of<AddEnvViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xff757575),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text(
                'Add Incident',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.black54, fontWeight: FontWeight.w900),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: widget.imagePath != null ? Image.file(File(widget.imagePath!)) : Image.network(
                            'https://cdn.windowsreport.com/wp-content/uploads/2020/04/Best-software-for-abstract-art.jpg'),
                      ),
                      TextButton(
                        onPressed: (){
                          pickImage().then((value) {
                            setState(() {
                              widget.imagePath = value;
                            });
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey)),
                        child: const Text(
                          'Take Photo',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (value){
                          setState(() {
                            widget.title = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (value){
                          setState(() {
                            widget.description = value;
                          });
                        },
                        textInputAction: TextInputAction.done,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Enter description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<AddEnvViewModel>(
                        builder: (context, vm, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if(vm.message != ''){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(vm.message)));
                              vm.resetMessage();
                            }
                          });
                          return TextButton(
                            onPressed: ()async {
                              if(widget.imagePath != null){
                              await vm.addIncident(incidentImage: File(widget.imagePath!), uid: _auth.currentUser?.uid, title: widget.title, description: widget.description);
                              Navigator.pop(context);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload image')));
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(vm.loading? Colors.grey : Colors.black54)),
                            child: Text(
                              vm.loading ? 'Saving' : 'Save',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}