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
  // Duration? searchTimeBinary_Cont;
  Duration? searchTimeLinear;
  // Duration? searchTimeLinear_Cont;
  Duration? sortTime_M;
  Duration? sortTime_Q;
  Duration? sortTime_B;
  Duration? sortTime_S;
  Duration? sortTime_H;
  // Duration? sortTime_Cont;
  String selectedSearch = 'Linear Search';
  String selectedSort = 'Selection Sort';
  bool showSortedCustomers = false;
 
  bool showTimeSearah_L = false;

  // ignore: non_constant_identifier_names
  bool showTimeSearah_M = false;
  // ignore: non_constant_identifier_names
  bool showTimeSearah_Q = false;
  bool showTimeSearah_B = false;
  bool showTimeSearah_S = false;
  bool showTimeSearah_H = false;

  // @override
  // void initState() {
  //   super.initState();
  //   searchCustomerBinary();
  // }
  // Selection Sort
  void selectionSort(int n) {
    final stopwatch = Stopwatch()..start(); // Start stopwatch

    for (int i = 0; i < n - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < n; j++) {
        if (customersData[j]["اسمالعميل"]
                .compareTo(customersData[minIndex]["اسمالعميل"]) <
            0) {
          minIndex = j;
        }
      }
      if (minIndex != i) {
        Map<String, dynamic> temp = customersData[i];
        customersData[i] = customersData[minIndex];
        customersData[minIndex] = temp;
      }
    }

    sortTime_S = stopwatch.elapsed; // Stop stopwatch
  }

// Bubble Sort
  void bubbleSort(int n) {
    final stopwatch = Stopwatch()..start(); // Start stopwatch

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (customersData[j]["اسمالعميل"]
                .compareTo(customersData[j + 1]["اسمالعميل"]) >
            0) {
          Map<String, dynamic> temp = customersData[j];
          customersData[j] = customersData[j + 1];
          customersData[j + 1] = temp;
        }
      }
    }

    sortTime_B = stopwatch.elapsed; // Stop stopwatch
  }

  void mergeSort(int left, int right) {
    final stopwatch = Stopwatch()..start(); // Start stopwatch
    if (left < right) {
      int mid = (left + right) ~/ 2;
      mergeSort(left, mid);
      mergeSort(mid + 1, right);
      merge(left, mid, right);
    }
    sortTime_M = stopwatch.elapsed; // Stop stopwatch
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
    final stopwatch = Stopwatch()..start(); // Start stopwatch
    if (low < high) {
      int pi = partition(low, high);

      quickSort(low, pi - 1);
      quickSort(pi + 1, high);
    }
    sortTime_Q = stopwatch.elapsed; // Stop stopwatch
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

  void heapSort(int n) {
    final stopwatch = Stopwatch()..start(); // Start stopwatch

    // Build max heap
    for (int i = (n ~/ 2) - 1; i >= 0; i--) {
      heapify(n, i);
    }

    // Extract elements from heap one by one
    for (int i = n - 1; i > 0; i--) {
      // Swap root (max element) with last element
      Map<String, dynamic> temp = customersData[0];
      customersData[0] = customersData[i];
      customersData[i] = temp;

      // Heapify the reduced heap
      heapify(i, 0);
    }

    sortTime_H = stopwatch.elapsed; // Stop stopwatch
  }

  void heapify(int n, int i) {
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1; // Left child
    int right = 2 * i + 2; // Right child

    // If left child is larger than root
    if (left < n &&
        customersData[left]["اسمالعميل"]
                .compareTo(customersData[largest]["اسمالعميل"]) >
            0) {
      largest = left;
    }

    // If right child is larger than largest so far
    if (right < n &&
        customersData[right]["اسمالعميل"]
                .compareTo(customersData[largest]["اسمالعميل"]) >
            0) {
      largest = right;
    }

    // If largest is not root
    if (largest != i) {
      // Swap root with largest
      Map<String, dynamic> temp = customersData[i];
      customersData[i] = customersData[largest];
      customersData[largest] = temp;

      // Recursively heapify the affected sub-tree
      heapify(n, largest);
    }
  }

  void searchCustomerLinear() {
    int? id = int.tryParse(textController.text);
    if (id != null) {
      setState(() {
        customerData_L = linearSearchFunction(id);
        searchTimeLinear;
        showTimeSearah_L = true;
      });
    }
  }

  Map<String, dynamic>? linearSearchFunction(int id) {
    final stopwatch = Stopwatch()..start(); // Start stopwatch
    for (var customer in customersData) {
      if (customer["رقمالحساب"] == id) {
        searchTimeLinear = stopwatch.elapsed; // Stop stopwatch
        return customer;
      }
    }
    return null; // If not found
  }
  // void searchCustomerBinary() {

  //     int? id = int.tryParse(textController.text);
  //     if (id != null) {
  //       mergeSort(0, customersData.length - 1); // customersData are sorted
  //       setState(() {
  //         final stopwatch = Stopwatch()..start();

  //         customerData_B = binarySearchFunction(id);
  //         // stopwatch.stop();
  //         searchTimeBinary = stopwatch.elapsed;
  //         print(searchTimeBinary);
  //         showTimeSearah_B = true;
  //       });
  //     }
  //   }
  //     Map<String, dynamic>? binarySearchFunction(int id) {
  //   // final stopwatch = Stopwatch()..start();
  //   int left = 0;
  //   int right = customersData.length - 1;
  //   while (left <= right) {
  //     int mid = left + ((right - left) ~/ 2);
  //     if (customersData[mid]["رقمالحساب"] == id) {
  //       return customersData[mid];
  //     } else if (customersData[mid]["رقمالحساب"] < id) {
  //       left = mid + 1;
  //     } else {
  //       right = mid - 1;
  //     }
  //   }
  //   // searchTimeBinary = stopwatch.elapsed;
  //   return null; // If not found
  // }

  void sortCustomers() {
    // final stopwatch = Stopwatch()..start();
    setState(() {
      if (selectedSort == 'Selection Sort') {
        selectionSort(customersData.length - 1);
        sortTime_S;
        showTimeSearah_S = true;
      } else if (selectedSort == 'Bubble Sort') {
        bubbleSort(customersData.length - 1);
        sortTime_B;
        showTimeSearah_B = true;
      } else if (selectedSort == 'Merge Sort') {
        mergeSort(0, customersData.length - 1);
        sortTime_M;
        showTimeSearah_M = true;
      } else if (selectedSort == 'Quick Sort') {
        quickSort(0, customersData.length - 1);
        sortTime_Q;
        showTimeSearah_Q = true;
      } else {
        heapSort(customersData.length - 1);
        sortTime_H;
        showTimeSearah_H = true;
      }
    });
  }

  // Map<String, dynamic>? binarySearchFunction(int id, int left, int right) {
  //   if (left < right) {
  //     int mid = left + ((right - left) ~/ 2);

  //     if (customersData[mid]["رقمالحساب"] == id) {
  //       return customersData[mid];
  //     } else if (customersData[mid]["رقمالحساب"] < id) {
  //       return binarySearchFunction(id, mid + 1, right);
  //     } else {
  //       return binarySearchFunction(id, left, mid - 1);
  //     }
  //   }

  //   return null; // If not found
  // }

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
                            color: Color.fromARGB(255, 127, 125, 125),
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
                                      iconEnabledColor:
                                          Color.fromARGB(255, 232, 35, 235),
                                      isExpanded: true,
                                      // icon: Icon(Icons.flutter_dash_sharp),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 49, 241),
                                          fontSize: Checkbox.width),

                                      items: <String>[
                                        // 'Binary Search',
                                        // //  '------------------',
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
                                      onTap: searchCustomerLinear,
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
                                      iconEnabledColor:
                                          Color.fromARGB(255, 232, 35, 235),
                                      isExpanded: true,
                                      // icon: Icon(Icons.flutter_dash_sharp),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 49, 241),
                                          fontSize: Checkbox.width),
                                      // focusColor: Colors.black87,
                                      // autofocus: true,

                                      items: <String>[
                                        'Selection Sort',
                                        'Bubble Sort',
                                        'Merge Sort',
                                        'Quick Sort',
                                        'Heap Sort'
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
                              if (showTimeSearah_S == true)
                                Text(
                                  "Selection Sort time: ${sortTime_S!.inMicroseconds} microseconds",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 233, 161, 7),
                                    fontSize: 18,
                                  ),
                                ),
                              if (showTimeSearah_B == true)
                                Text(
                                  "Bubble Sort time: ${sortTime_B!.inMicroseconds} microseconds",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 233, 161, 7),
                                    fontSize: 18,
                                  ),
                                ),

                              if (showTimeSearah_M == true)
                                Text(
                                  "Merge Sort time: ${sortTime_M!.inMicroseconds} microseconds",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 233, 161, 7),
                                    fontSize: 18,
                                  ),
                                ),
                              // const  searchTimeBinary = Duration(int microseconds: = 0);
                              if (showTimeSearah_Q == true)
                                Text(
                                  "Quick Sort time: ${sortTime_Q!.inMicroseconds} microseconds",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 233, 161, 7),
                                    fontSize: 18,
                                  ),
                                ),
                                 if (showTimeSearah_H == true)
                                Text(
                                  "Heap Sort time: ${sortTime_H!.inMicroseconds} microseconds",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 233, 161, 7),
                                    fontSize: 18,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        // if (showTimeSearah_B == true &&
                        //     searchTimeBinary != null)
                        //   Text(
                        //     "Binary Search time: ${searchTimeBinary!.inMicroseconds} microseconds",
                        //     style: TextStyle(
                        //       color: Color.fromARGB(255, 233, 161, 7),
                        //       fontSize: 18,
                        //     ),
                        //   ),
                        if (showTimeSearah_L == true &&
                            searchTimeLinear != null)
                          Text(
                            "Linear Search time: ${searchTimeLinear!.inMicroseconds} microseconds",
                            style: TextStyle(
                              color: Color.fromARGB(255, 233, 161, 7),
                              fontSize: 18,
                            ),
                          ),
                        SizedBox(height: 10),

                        // if(showSearahCustomer)

                        // customerData_B != null
                        //     ? Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(20),
                        //           color: Colors.grey[200],
                        //         ),
                        //         width: 350,
                        //         height: 420,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(20),
                        //           child: SingleChildScrollView(
                        //             child: Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.end,
                        //               children: [
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.end,
                        //                   children: [
                        //                     Text(
                        //                       "اسم العميل: ${customerData_B!["اسمالعميل"]}",
                        //                       style: TextStyle(
                        //                           fontSize: 20,
                        //                           color: Color.fromARGB(
                        //                               255, 0, 8, 255)),
                        //                     ),
                        //                     Divider(color: Colors.blue),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 15),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.end,
                        //                   children: [
                        //                     Text(
                        //                       "رقم الحساب: ${customerData_B!["رقمالحساب"]}",
                        //                       style: TextStyle(fontSize: 20),
                        //                     ),
                        //                     Divider(),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 15),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.end,
                        //                   children: [
                        //                     Text(
                        //                       "رقم الشقة: ${customerData_B!["رقمالشقة"]}",
                        //                       style: TextStyle(fontSize: 20),
                        //                     ),
                        //                     Divider(),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 15),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.end,
                        //                   children: [
                        //                     Text(
                        //                       "استهلاك الكهرباء: ${customerData_B!["استهلاكالكهرباء"]}",
                        //                       style: TextStyle(fontSize: 20),
                        //                     ),
                        //                     Divider(),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 15),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.end,
                        //                   children: [
                        //                     Text(
                        //                       "قيمة الفاتورة: ${customerData_B!["قيمةالفاتورة"]}",
                        //                       style: TextStyle(fontSize: 20),
                        //                     ),
                        //                     Divider(),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 15),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.end,
                        //                   children: [
                        //                     Text(
                        //                       "تاريخ الاستحقاق: ${customerData_B!["تاريخالاستحقاق"]}",
                        //                       style: TextStyle(fontSize: 20),
                        //                     ),
                        //                     Divider(),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 15),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.end,
                        //                   children: [
                        //                     Text(
                        //                       "حالة الدفع: ${customerData_B!["حالةالدفع"]}",
                        //                       style: TextStyle(fontSize: 20),
                        //                     ),
                        //                     Divider(),
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     : SizedBox(),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // // ####################

                        // if(showSearahCustomer)
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
                        SizedBox(
                          height: 5,
                        ),

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
