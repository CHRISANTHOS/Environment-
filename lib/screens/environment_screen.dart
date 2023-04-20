import 'dart:io';

import 'package:flutter/material.dart';
import 'add_environment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EnvironmentScreen extends StatefulWidget {
  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  final _auth = FirebaseAuth.instance;
  final CollectionReference _reference = FirebaseFirestore.instance.collection('AllIncident');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black54,
        title: const Text('EnvHub'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Refresh"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Log Out"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              //TODO: ADD REFRESH CODE
            } else if (value == 1) {
              _auth.signOut();
              Navigator.pop(context);
            }
          }),
        ],
      ),
      body: FutureBuilder(
        future: _reference.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          final data = snapshot.data!.docs;

          if(snapshot.hasData){
            if(data.isEmpty){
              return const Center(
                child: Text('No Incidents Available'),
              );
            }else{
              return Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: List.generate(data.length, (index) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: FileImage(File(data[index].get('image_url'))), fit: BoxFit.cover)
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(data[index].get('title')),
                        )
                      ],
                    );
                  }),
                ),
              );
            }
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddEnvScreen()));
        },
        backgroundColor: Colors.black54,
        child: const Icon(Icons.add),
      ),
    );
  }
}
