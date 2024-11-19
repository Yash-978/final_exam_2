import 'package:final_exam_2/controller/home_controller.dart';
import 'package:final_exam_2/modal/modal.dart';
import 'package:final_exam_2/service/auth_service.dart';
import 'package:final_exam_2/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Expanse'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: homeController.txtTitle,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    SizedBox(
                      height: h * 0.007,
                    ),
                    TextFormField(
                      controller: homeController.txtCategory,
                      decoration: InputDecoration(
                          hintText: 'Category',
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    SizedBox(
                      height: h * 0.007,
                    ),
                    TextFormField(
                      controller: homeController.txtAmount,
                      decoration: InputDecoration(
                          hintText: 'Amount',
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    SizedBox(
                      height: h * 0.007,
                    ),

                    TextFormField(
                      controller: homeController.txtDate,
                      decoration: InputDecoration(
                          hintText: 'Date',
                          labelText: 'Date',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    // ListTile(
                    //   title: Text('Select Date'),
                    //   leading: Icon(Icons.date_range),
                    //   onTap: () async {
                    //     DateTime? date = await showDatePicker(
                    //         context: context,
                    //         firstDate: DateTime(1900),
                    //         lastDate: DateTime(2030));
                    //     if (date != null) date;
                    //   },
                    // )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ExpanseModal expanse = ExpanseModal(
                        title: homeController.txtTitle.text,
                        amount: homeController.txtCategory.text,
                        date: homeController.txtAmount.text,
                        category: homeController.txtDate.text,
                      );
                      DbHelper.dbHelper.insertData(expanse);
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().logout();
                Get.offAllNamed('/login');
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: FutureBuilder(
        future: homeController.readDataDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ExpanseModal> expanse = [];
            expanse = homeController.expanseList
                .map(
                  (e) => ExpanseModal.fromJson(e),
                )
                .toList();
            return ListView.builder(
              itemCount: homeController.expanseList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  /*providerTrue.id = notesModal[index].id;
                        providerTrue.txtTitle.text = notesModal[index].title;
                        providerTrue.txtCategory.text =
                            notesModal[index].category;
                        providerTrue.txtAmount.text = notesModal[index].amount;*/
                  title: Text(homeController.txtTitle.text),
                  subtitle: Text(homeController.txtTitle.text),
                  leading: Text(homeController.txtTitle.text +
                      homeController.txtTitle.text),
                  trailing: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog();
                              },
                            );
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
/*
import 'package:adv_flutter_final_exam/modal/expense_modal.dart';
import 'package:adv_flutter_final_exam/provider/expense_provider.dart';
import 'package:adv_flutter_final_exam/services/auth.dart';
import 'package:adv_flutter_final_exam/views/component/my_text_field.dart';
import 'package:adv_flutter_final_exam/views/search_screen.dart';
import 'package:adv_flutter_final_exam/views/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ExpenseProvider>(context);
    var providerFalse = Provider.of<ExpenseProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () async {
              await providerFalse.syncCloudToLocal();
            },
            child: const Text(
              'Save to local',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              List<ExpenseModal> notes;
              notes = providerTrue.notesList
                  .map(
                    (e) => ExpenseModal.fromMap(e),
                  )
                  .toList();
              for (int i = 0; i < providerTrue.notesList.length; i++) {
                providerFalse.addDataInStore(
                  id: notes[i].id,
                  title: notes[i].title,
                  amount: double.parse(notes[i].amount),
                  category: notes[i].category,
                  date: notes[i].date,
                );
              }
            },
            child: const Text(
              'Backup',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await AuthServices.userServices.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: MyTextField(
          //     onChanged: (value) {},
          //     controller: providerTrue.txtSearch,
          //     label: 'Search',
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: height * 0.06,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Search'),
            ),
          ),
          FutureBuilder(
            future: providerFalse.readDataFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ExpenseModal> notesModal = [];

                notesModal = providerTrue.notesList
                    .map(
                      (e) => ExpenseModal.fromMap(e),
                    )
                    .toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: notesModal.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        providerTrue.id = notesModal[index].id;
                        providerTrue.txtTitle.text = notesModal[index].title;
                        providerTrue.txtCategory.text =
                            notesModal[index].category;
                        providerTrue.txtAmount.text = notesModal[index].amount;

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Update Expense'),
                            actions: [
                              MyTextField(
                                controller: providerTrue.txtTitle,
                                label: 'Title',
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              MyTextField(
                                controller: providerTrue.txtCategory,
                                label: 'Category',
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              MyTextField(
                                controller: providerTrue.txtAmount,
                                label: 'Amount',
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      providerTrue.date =
                                          '${DateTime.now().hour}:${DateTime.now().minute}';
                                      providerFalse.updateNoteInDatabase(
                                        id: notesModal[index].id,
                                        title: providerTrue.txtTitle.text,
                                        date: providerTrue.date,
                                        amount: double.parse(
                                            providerTrue.txtAmount.text),
                                        category: providerTrue.txtCategory.text,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      leading: Text(notesModal[index].id.toString()),
                      title: Text(notesModal[index].title),
                      subtitle: Text(notesModal[index].category),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(notesModal[index].amount),
                          const VerticalDivider(),
                          Text(notesModal[index].date),
                          const VerticalDivider(),
                          IconButton(
                            onPressed: () async {
                              await providerFalse.deleteNoteInDatabase(
                                  id: notesModal[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Expense'),
              actions: [
                MyTextField(
                  controller: providerTrue.txtTitle,
                  label: 'Title',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                MyTextField(
                  controller: providerTrue.txtCategory,
                  label: 'Category',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                MyTextField(
                  controller: providerTrue.txtAmount,
                  label: 'Amount',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        providerTrue.id = providerTrue.notesList.length + 1;
                        providerTrue.date =
                            '${DateTime.now().hour}:${DateTime.now().minute}';
                        providerFalse.insertExpenseToDatabase(
                          id: providerTrue.id,
                          title: providerTrue.txtTitle.text,
                          date: providerTrue.date,
                          amount: double.parse(providerTrue.txtAmount.text),
                          category: providerTrue.txtCategory.text,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/
