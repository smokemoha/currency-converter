import 'package:flutter/material.dart';

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

class FAQPage extends StatelessWidget {
  final List<FAQ> faqs = [
    FAQ(
      question: 'What currencies does the converter support?',
      answer: 'The converter supports various currencies including USD, EUR, GBP, and JPY.',
    ),
    FAQ(
      question: 'Is the exchange rate updated in real-time?',
      answer: 'Yes, the exchange rates are updated regularly to provide accurate conversions.',
    ),
    FAQ(
      question: 'Can I set a default base currency?',
      answer: 'Yes, users can set their preferred base currency in the app settings.',
    ),
    FAQ(
      question: 'Are there any fees for using the currency converter?',
      answer: 'No, the currency converter is free to use without any additional fees.',
    ),
    FAQ(
      question: 'How often are the exchange rate articles updated?',
      answer: 'The exchange rate articles are updated periodically with the latest market trends and analysis.',
    ),
    // Add more FAQs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently Asked Questions'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: FAQCard(faq: faqs[index]),
          );
        },
      ),
    );
  }
}

class FAQCard extends StatelessWidget {
  final FAQ faq;

  const FAQCard({Key? key, required this.faq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              faq.answer,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
