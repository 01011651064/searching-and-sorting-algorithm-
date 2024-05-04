import 'package:flutter/material.dart';
import 'componet/button.dart';
import 'componet/searchField.dart';
import 'package:algo/componet/data.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> customersData = data.customersData;
  // ignore: non_constant_identifier_names
  Map<String, dynamic>? customerData_L;
  // ignore: non_constant_identifier_names
  Map<String, dynamic>? customerData_B;
  TextEditingController textController = TextEditingController();
  Duration? searchTimeBinary;
  Duration? searchTimeLinear;
  Duration? sortTime;
  String selectedSearch = 'Binary Search';
  String selectedSort = 'Merge Sort';
  bool showSortedCustomers = false;

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
      if (customersData[i]["اسمالعميل"]
              .compareTo(customersData[j]["اسمالعميل"]) <=
          0) {
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

  void quickSort(int low, int high) {
    if (low < high) {
      int pi = partition(low, high);

      quickSort(low, pi - 1);
      quickSort(pi + 1, high);
    }
  }

  int partition(int low, int high) {
    Map<String, dynamic> pivot = customersData[high];
    int i = (low - 1);

    for (int j = low; j < high; j++) {
      if (customersData[j]["اسمالعميل"].compareTo(pivot["اسمالعميل"]) <= 0) {
        i++;

        Map<String, dynamic> temp = customersData[i];
        customersData[i] = customersData[j];
        customersData[j] = temp;
      }
    }

    Map<String, dynamic> temp = customersData[i + 1];
    customersData[i + 1] = customersData[high];
    customersData[high] = temp;

    return i + 1;
  }

  void searchCustomerBinary() {
    int? id = int.tryParse(textController.text);
    if (id != null) {
      final stopwatch = Stopwatch()..start();
      setState(() {
        customerData_B = binarySearchFunction(id);
        searchTimeBinary = stopwatch.elapsed;
      });
    }
  }

  void searchCustomerLinear() {
    int? id = int.tryParse(textController.text);
    if (id != null) {
      final stopwatch = Stopwatch()..start();
      setState(() {
        customerData_L = linearSearchFunction(id);
        searchTimeLinear = stopwatch.elapsed;
      });
    }
  }

  void sortCustomers() {
    final stopwatch = Stopwatch()..start();
    setState(() {
      if (selectedSort == 'Merge Sort') {
        mergeSort(0, customersData.length - 1);
      } else {
        quickSort(0, customersData.length - 1);
      }
      sortTime = stopwatch.elapsed;
    });
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

  Map<String, dynamic>? linearSearchFunction(int id) {
    for (var customer in customersData) {
      if (customer["رقمالحساب"] == id) {
        return customer;
      }
    }
    return null; // If not found
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFFFFFFFF),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
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
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Enter your id ",
                          style: TextStyle(
                            color:  Color.fromARGB(255, 127, 125, 125),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                                    child: DropdownButton<String>(
                                    //  iconEnabledColor: Color.fromARGB(2, 182, 22, 222),
                                      // style: TextStyle(color: const Color.fromARGB(255, 1, 17, 240)) ,iconSize:BorderSide.strokeAlignCenter,
                                      borderRadius: BorderRadius.circular(15),
                                      value: selectedSearch,
                                    
                                      onChanged: (String? newValue) {
                                        
                                        setState(() {
                                          selectedSearch = newValue!;
                                          
                                        });
                                      },
                                      iconSize: 25,
                                      iconEnabledColor: Color.fromARGB(255, 232, 35, 235),
                                      isExpanded: true,
                                      // icon: Icon(Icons.flutter_dash_sharp),
                                      style: TextStyle(color: Color.fromARGB(255, 28, 49, 241),fontSize:  Checkbox.width),

                                      
                                      items: <String>[
                                        'Binary Search',
                                        'Linear Search'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: BouncingButton(
                                      onTap: selectedSearch == 'Binary Search'
                                          ? searchCustomerBinary
                                          : searchCustomerLinear,
                                      myText: "Search",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(15),
                                      
                                      value: selectedSort,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedSort = newValue!;
                                          // sortCustomers();
                                        });
                                      },
                                        iconSize: 25,
                                      iconEnabledColor: Color.fromARGB(255, 232, 35, 235),
                                      isExpanded: true,
                                      // icon: Icon(Icons.flutter_dash_sharp),
                                      style: TextStyle(color: Color.fromARGB(255, 28, 49, 241),fontSize: Checkbox.width),
                                      // focusColor: Colors.black87,
                                      // autofocus: true,

                                      items: <String>[
                                        'Merge Sort',
                                        'Quick Sort'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: BouncingButton(
                                      onTap: () {
                                        sortCustomers();
                                        setState(() {
                                          showSortedCustomers = true;
                                        });
                                      },
                                      myText: "Sort",
                                    ),
                                  ),
                                ],
                              ),
                              if (sortTime != null)
                                Text(
                                  "Sort time: ${sortTime!.inMicroseconds} microseconds",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 233, 161, 7),
                                    fontSize: 18,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        if (selectedSearch == 'Binary Search' &&
                            searchTimeBinary != null)
                          Text(
                            "Binary Search time: ${searchTimeBinary!.inMicroseconds} microseconds",
                            style: TextStyle(
                              color: Color.fromARGB(255, 233, 161, 7),
                              fontSize: 18,
                            ),
                          ),
                        if (selectedSearch == 'Linear Search' &&
                            searchTimeLinear != null)
                          Text(
                            "Linear Search time: ${searchTimeLinear!.inMicroseconds} microseconds",
                            style: TextStyle(
                              color: Color.fromARGB(255, 233, 161, 7),
                              fontSize: 18,
                            ),
                          ),
                        SizedBox(height: 10),
                        customerData_B != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[200],
                                ),
                                width: 350,
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
                                              "اسم العميل: ${customerData_B!["اسمالعميل"]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 0, 8, 255)),
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
                                              "رقم الحساب: ${customerData_B!["رقمالحساب"]}",
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
                                              "رقم الشقة: ${customerData_B!["رقمالشقة"]}",
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
                                              "استهلاك الكهرباء: ${customerData_B!["استهلاكالكهرباء"]}",
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
                                              "قيمة الفاتورة: ${customerData_B!["قيمةالفاتورة"]}",
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
                                              "تاريخ الاستحقاق: ${customerData_B!["تاريخالاستحقاق"]}",
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
                                              "حالة الدفع: ${customerData_B!["حالةالدفع"]}",
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
                            // ####################
                             customerData_L != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[200],
                                ),
                                width: 350,
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
                                              "اسم العميل: ${customerData_L!["اسمالعميل"]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 0, 8, 255)),
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
                                              "رقم الحساب: ${customerData_L!["رقمالحساب"]}",
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
                                              "رقم الشقة: ${customerData_L!["رقمالشقة"]}",
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
                                              "استهلاك الكهرباء: ${customerData_L!["استهلاكالكهرباء"]}",
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
                                              "قيمة الفاتورة: ${customerData_L!["قيمةالفاتورة"]}",
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
                                              "تاريخ الاستحقاق: ${customerData_L!["تاريخالاستحقاق"]}",
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
                                              "حالة الدفع: ${customerData_L!["حالةالدفع"]}",
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
                            

                        // Display sorted customers
                        if (showSortedCustomers)
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sorted Customers:',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                   decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey[200],
                                ),
                                width: 335,
                                height: 420,
                                  // padding: EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: customersData.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        '${customersData[index]["اسمالعميل"]}',
                                        // semanticsLabel: '${customersData[index]["حالة الدفع"]}',
                                        style: const TextStyle(fontSize: 16),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
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
