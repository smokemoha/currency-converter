import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Currency {
  final String code;
  final String name;

  Currency({required this.code, required this.name});

  factory Currency.fromJson(List<dynamic> json) {
    return Currency(
      code: json[0],
      name: json[1],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supported Currencies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyListScreen(),
    );
  }
}

class CurrencyListScreen extends StatefulWidget {
  @override
  _CurrencyListScreenState createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  List<Currency> _currencies = [];
  String _searchText = '';
  bool _currencyFound = true;
  bool _isLoading = false; // Add a flag to track loading state

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchCurrencies() async {
    setState(() {
      _isLoading = true; // Set loading flag to true
    });

    final url =
        'https://v6.exchangerate-api.com/v6/a841b0f976e0277a71a5b6c0/codes';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['result'] == 'success') {
          final List<dynamic> supportedCodes = jsonResponse['supported_codes'];
          if (mounted) {
            setState(() {
              _currencies = supportedCodes
                  .map((code) => Currency.fromJson(code))
                  .toList();
              _isLoading = false; // Set loading flag to false when data is loaded
            });
          }
        } else {
          // Handle error
          print('Failed to fetch currencies');
          _isLoading = false; // Set loading flag to false in case of error
        }
      } else {
        // Handle HTTP error
        print('Failed to fetch currencies: ${response.statusCode}');
        _isLoading = false; // Set loading flag to false in case of error
      }
    } catch (e) {
      print('Error fetching currencies: $e');
      _isLoading = false; // Set loading flag to false in case of error
    }
  }

  List<Currency> get _filteredCurrencies {
    if (_searchText.isEmpty) {
      _currencyFound = true;
      return _currencies;
    } else {
      final filteredList = _currencies.where((currency) {
        return currency.code.toLowerCase().contains(_searchText.toLowerCase()) ||
            currency.name.toLowerCase().contains(_searchText.toLowerCase());
      }).toList();

      _currencyFound = filteredList.isNotEmpty;
      return filteredList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supported Currencies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchText = '';
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
                : _currencyFound || _searchText.isEmpty
                    ? ListView.builder(
                        itemCount: _filteredCurrencies.length,
                        itemBuilder: (context, index) {
                          final currency = _filteredCurrencies[index];
                          return ListTile(
                            title: Text('${currency.name} (${currency.code})'),
                          );
                        },
                      )
                    : Center(
                        child: Text('Currency unavailable'),
                      ),
          ),
        ],
      ),
    );
  }
}
