
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeRateDisplay extends StatefulWidget {
  @override
  _ExchangeRateDisplayState createState() => _ExchangeRateDisplayState();
}

class _ExchangeRateDisplayState extends State<ExchangeRateDisplay> {
  String apiKey = "fca_live_MkUd57vPI1eVAntXP767xwrhNgwNulPWN37xMzzs";
  List<String> currencies = ["GBP", "JPY", "CAD", "INR"];
  List<Map<String, dynamic>> exchangeRatesList = [];
  String selectedCurrency = "";
  String selectedDate = "";
  double exchangeRate = 0.0;


  Future<void> fetchExchangeRates() async {
    DateTime currentDate = DateTime.now();

    for (int i = 1; i <= 6; i++) {
      DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month - i, 1);
      String formattedDate = "${firstDayOfMonth.year}-${_formatMonth(firstDayOfMonth.month)}-01";

      Map<String, dynamic> exchangeRates = await _fetchExchangeRatesForDate(formattedDate);
      exchangeRatesList.add({"date": formattedDate, "rates": exchangeRates});
    }

    setState(() {});
  }

  Future<Map<String, dynamic>> _fetchExchangeRatesForDate(String date) async {
    String apiUrl = "https://api.freecurrencyapi.com/v1/historical?date=$date&currencies=${currencies.join(',')}";

    var response = await http.get(Uri.parse(apiUrl), headers: {
      'apikey': apiKey,
    });

    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> data = json.decode(response.body);

      // Extract exchange rates from the response
      Map<String, dynamic> exchangeRates = data['data'][date];
      return exchangeRates;
    } else {
      // Handle API error
      print("Failed to fetch exchange rates for $date");
      return {};
    }
  }

  String _formatMonth(int month) {
    return month < 10 ? "0$month" : "$month";
  }

  Future<void> fetchExchangeRate(String currency, String date) async {
    String apiUrl = "https://api.freecurrencyapi.com/v1/historical?date=$date&currencies=$currency";

    var response = await http.get(Uri.parse(apiUrl), headers: {
      'apikey': apiKey,
    });

    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> data = json.decode(response.body);

      // Extract exchange rate from the response
      Map<String, dynamic> exchangeRates = data['data'][date];
      setState(() {
        exchangeRate = exchangeRates[currency] ?? 0.0;
      });
    } else {
      // Handle API error
      print("Failed to fetch exchange rate for $currency on $date");
      setState(() {
        exchangeRate = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historical Exchange Rates'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Enter Date (YYYY-MM-DD)'),
                    onChanged: (value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(
                value: selectedCurrency.isNotEmpty ? selectedCurrency : null,
                hint: Text('Select Currency'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                  });
                },
                items: currencies.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedDate.isNotEmpty && selectedCurrency.isNotEmpty) {
                fetchExchangeRate(selectedCurrency, selectedDate);
              } else {
                // Show a snackbar to prompt the user to enter both date and currency
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter both date and currency.'),
                  ),
                );
              }
            },
            child: Text('Get Exchange Rate'),
          ),
          SizedBox(height: 16.0),
          if (exchangeRate != 0.0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Exchange Rate for $selectedCurrency on $selectedDate: $exchangeRate',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
