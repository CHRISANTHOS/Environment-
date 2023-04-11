import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:environment_app/view_models/add_env_view_model.dart';

class AddEnvScreen extends StatefulWidget {
  @override
  State<AddEnvScreen> createState() => _AddEnvScreenState();
}

class _AddEnvScreenState extends State<AddEnvScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddEnvViewModel>(context);

    return Container(
      color: const Color(0xff757575),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Add Incident',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23.0, color: Colors.black54, fontWeight: FontWeight.w900),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: Image.network(
                            'https://cdn.windowsreport.com/wp-content/uploads/2020/04/Best-software-for-abstract-art.jpg'),
                      ),
                      TextButton(
                        onPressed: null,
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
                          vm.title = value;
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
                          vm.description = value;
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
                      TextButton(
                        onPressed: () {
                          vm.saveIncident();
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.black54)),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
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