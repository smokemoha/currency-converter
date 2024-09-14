
import 'package:currenseepro/currency.dart';
import 'package:currenseepro/currencylist.dart';
import 'package:currenseepro/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;
  ExchangeRateConverter exc = ExchangeRateConverter();
  

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print('Error logging out: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        actions: [
          IconButton(onPressed: () => _logout(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50, color: Colors.grey,),
              ),
              SizedBox(height: 20),
              Text(
                user?.email ?? 'No User',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  
                },
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Container(
                      height: 60,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Prefered Currency"),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: 20,
              ),


              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyListScreen()));
                },
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Container(
                      height: 60,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Supported Currencies"),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  _logout(context);
                },
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: Container(
                      height: 60,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Logout"),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    
                    ),
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


