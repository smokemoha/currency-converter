import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currenseepro/database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeRateConverter extends StatefulWidget {
  @override
  _ExchangeRateConverterState createState() => _ExchangeRateConverterState();
}

class _ExchangeRateConverterState extends State<ExchangeRateConverter> {
  String baseCurrency = 'USD';
  String targetCurrency = 'EUR';
  double amount = 0;
  double convertedAmount = 0;
  DatabaseMethods databaseMethods = DatabaseMethods();

  Future<void> convertCurrency() async {
    String apiUrl =
        'https://v6.exchangerate-api.com/v6/a841b0f976e0277a71a5b6c0/pair/$baseCurrency/$targetCurrency/$amount';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double conversionResult = data['conversion_result'];
        setState(() {
          convertedAmount = conversionResult;
        });

        // Add transaction details to Firestore
        Map<String, dynamic> transactionData = {
          'base_currency': baseCurrency,
          'target_currency': targetCurrency,
          'amount': amount,
          'converted_amount': convertedAmount,
          'timestamp': DateTime.now(), // Add timestamp for sorting
        };
        await databaseMethods.addTransaction(transactionData);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error: Display error message to user
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Text("Currency Converter",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
        
                    Padding(
                      padding: const EdgeInsets.only(right:20.0),
                      child: Icon(Icons.notifications, size: 35,),
                    ),
                    
              ],
              ),
            ),
        
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:30.0, left: 21, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFFececf8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: baseCurrency,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  baseCurrency = newValue;
                                });
                              }
                            },
                            items: <String>['USD', 'EUR', 'GBP', 'JPY'] // Add your list of currencies here
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                                  dropdownColor: Colors.white,
                                  
                                  iconSize: 30,
                                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        
                        
                              
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFFececf8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: targetCurrency,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  targetCurrency = newValue;
                                });
                              }
                            },
                            items: <String>['USD', 'EUR', 'GBP', 'JPY'] // Add your list of currencies here
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                                  dropdownColor: Colors.white,
                                  
                                  iconSize: 30,
                                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                
                    
                    Center(child: Icon(Icons.compare_arrows_rounded, size: 30,),),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 150,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0xFFececf8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  amount = double.tryParse(value) ?? 0;
                                },
                                decoration: InputDecoration(
                                  hintText: "Amount",
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold,),
                                  border: InputBorder.none,
                                ) ,
                              ),
                            ),
                          ),
                        ),
            
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 150,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0xFFececf8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0, left: 8),
                              child: Text(
                                convertedAmount.toString(),
                              
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )
                    ],
                    ),
                    
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: convertCurrency,
                      child: Center(
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: 130,
                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Convert',
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 10),
        
                    Center(
                      child: Text("Conversion History"),
                    ),

                    ConversionHistory(),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConversionHistory extends StatelessWidget {
  final DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390, // Fixed height
      width: 800,
      child: StreamBuilder<QuerySnapshot>(
        stream: databaseMethods.getUserTransactionHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final transactions = snapshot.data!.docs;
            if (transactions.isEmpty) {
              return Center(child: Text('No conversion history available'));
            } else {
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final data = transaction.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text('From: ${data['base_currency']} To: ${data['target_currency']}'),
                    subtitle: Text('Amount: ${data['amount']}, Converted Amount: ${data['converted_amount']}'),
                    trailing: SizedBox(
                      width: 100, // Adjust the width as needed
                      child: Text(data['timestamp'].toString()), // Display timestamp
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}



