import 'package:currenseepro/FAQs.dart';
import 'package:currenseepro/userguide.dart';
import 'package:flutter/material.dart';
import 'package:currenseepro/currency.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserSupportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Support',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => UserSupportScreen(),
        '/contact': (context) => ContactFormScreen(),
        '/confirmation': (context) => ConfirmationScreen(),
      },
    );
  }
}

class UserSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Support'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()));
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
                            Text("FAQs"),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserGuideScreen()));
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
                          Text("User Guides"),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactFormScreen()));
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
                          Text("Customer Support"),
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
            ],
          ),
        ),
      ),
    );
  }
}

class FAQList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your FAQ list implementation
    return Container();
  }
}

class UserGuideList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your user guide list implementation
    return Container();
  }
}

class ContactFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Customer Support'),
      ),
      body: ContactForm(),
    );
  }
}

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fill out the form below to contact customer support:'),
          // Your form fields implementation
          ElevatedButton(
            onPressed: () {
              // Navigate to the confirmation screen after form submission
              Navigator.pushNamed(context, '/confirmation');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Center(
        child: Text('Thank you for contacting us!'),
      ),
    );
  }
}
