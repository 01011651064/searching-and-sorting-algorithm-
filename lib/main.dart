import 'package:flutter/material.dart';
import 'componet/button.dart';
import 'componet/searchField.dart';
import 'package:algo/componet/data.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// var customer = 0;

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> customersData = data.customersData;
  Map<String, dynamic>? customerData;
  Map<String, dynamic>? sortingData;
  // Map<String, dynamic>? customer;
  // Nullable type
  TextEditingController textController = TextEditingController();
  Duration? searchTime;

  @override
  void initState() {
    super.initState();
    // Sort the customersData list by customer ID using merge sort
    mergeSort(0, customersData.length - 1);
  }

  void mergeSort(int left, int right) {
    if (left < right) {
      int mid = (left + right) ~/ 2;
      mergeSort(left, mid);
      mergeSort(mid + 1, right);
      merge(left, mid, right);
    }
  }

  void merge(int left, int mid, int right) {
    List<Map<String, dynamic>> temp = List.filled(right - left + 1, {});
    int i = left;
    int j = mid + 1;
    int k = 0;

    while (i <= mid && j <= right) {
      if (customersData[i]["رقمالحساب"] <= customersData[j]["رقمالحساب"]) {
        temp[k++] = customersData[i++];
      } else {
        temp[k++] = customersData[j++];
      }
    }

    while (i <= mid) {
      temp[k++] = customersData[i++];
    }

    while (j <= right) {
      temp[k++] = customersData[j++];
    }

    for (int p = 0; p < temp.length; p++) {
      customersData[left + p] = temp[p];
    }
  }

  void searchCustomer() {
    int? id = int.tryParse(textController.text);
    if (id != null) {
      final stopwatch = Stopwatch()..start();
      setState(() {
        customerData = binarySearchFunction(id);
        searchTime = stopwatch.elapsed;
      });
    }
  }

  Map<String, dynamic>? binarySearchFunction(int id) {
    int left = 0;
    int right = customersData.length - 1;
    while (left <= right) {
      int mid = left + ((right - left) ~/ 2);
      if (customersData[mid]["رقمالحساب"] == id) {
        return customersData[mid];
      } else if (customersData[mid]["رقمالحساب"] < id) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
    return null; // If not found
  }

  void sortCustomers() {
    setState(() {
      mergeSort(0, customersData.length - 1);

      sortingData = {
        "اسمالعميل": "Gayel Klewi",
        "رقمالحساب": 585057877,
        "رقمالشقة": 533,
        "استهلاكالكهرباء": 409,
        "قيمةالفاتورة": 2045,
        "تاريخالاستحقاق": "5/15/2024",
        "حالةالدفع": "مسددة"
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF11998E),
                Color(0xFF38EF7D),
                Color(0xFF11998E),
                Color(0xFF11998E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        
                        Text(
                          "Invoice App",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Enter your id ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SearchInput(
                                      hintText: "Search id",
                                      textController: textController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: 
                                  BouncingButton(
                                    onTap: searchCustomer,
                                    myText: "Search",
                                  ),
                                  ),
                                  //  SizedBox(width: 5);
                                  Expanded(
                                    child: 
                                  BouncingButton(
                                    onTap: sortCustomers,
                                    myText: "Sort",
                                  ),
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                        ),

                        // SizedBox(height: 5),
                        searchTime != null
                            ? Text(
                                "Search time: ${searchTime!.inMicroseconds} microseconds",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              )
                            : SizedBox(),
                        SizedBox(height: 5),

                        customerData != null
                            ? Container(
                              // padding: EdgeInsets.fromLTRB(20, , 20, bottom),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color.fromARGB(255, 252, 252, 252),
                                ),
                                 width: 345,
                                height: 420,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "اسم العميل: ${customerData!["اسمالعميل"]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: const Color.fromARGB(
                                                      255, 3, 109, 7)),
                                            ),
                                            Divider(color: Colors.blue),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "رقم الحساب: ${customerData!["رقمالحساب"]}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "رقم الشقة: ${customerData!["رقمالشقة"]}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "استهلاك الكهرباء: ${customerData!["استهلاكالكهرباء"]}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "قيمة الفاتورة: ${customerData!["قيمةالفاتورة"]}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "تاريخ الاستحقاق: ${customerData!["تاريخالاستحقاق"]}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "حالة الدفع: ${customerData!["حالةالدفع"]}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(height: 10),

//#######################################################################
                        //  int customer;
                        //  sortingData =  customersData as Map<String, dynamic>? ;

                        sortingData != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                width: 345,
                                height: 420,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        for (var customer in customersData) ...[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "اسم العميل: ${customer["اسمالعميل"]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: const Color.fromARGB(
                                                      255, 3, 109, 7)),
                                              ),
                                          Divider(color: Colors.blue),
                                              SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "رقم الحساب: ${customer["رقمالحساب"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "رقم الشقة: ${customer["رقمالشقة"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "استهلاك الكهرباء: ${customer["استهلاكالكهرباء"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "قيمة الفاتورة: ${customer["قيمةالفاتورة"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "تاريخ الاستحقاق: ${customer["تاريخالاستحقاق"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "حالة الدفع: ${customer["حالةالدفع"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                Divider(color: Colors.blue),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}


