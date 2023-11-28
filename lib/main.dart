// import 'package:currency_converter/currency.dart';
// import 'package:currency_converter/currency_converter.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   //def variable
//   String? usdToPkr;

//   @override
//   void initState() {
//     super.initState();
// // add in initState
//     convert();
//   }

// // call function to convert
//   void convert() async {
//     Currency myCurrency = await CurrencyConverter.getMyCurrency();
//     var usdConvert = await CurrencyConverter.convert(
//       from: Currency.usd,
//       to: Currency.pkr,
//       amount: 1,
//     );
//     setState(() {
//       usdToPkr = usdConvert.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Money Convertor Example'),
//           centerTitle: true,
//         ),
//         body: Container(
//           padding: const EdgeInsets.all(20),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Text(
//                       "1 USD = ",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                     ),
//                     Text(
//                       "$usdToPkr ${Currency.pkr.name.toUpperCase()}",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                           color: Colors.green),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  //def variables
  String? usdToPkr;
  Currency selectedCurrency = Currency.pkr; // Default currency

  @override
  void initState() {
    super.initState();
    convert();
  }

  // call function to convert
  void convert() async {
    var usdConvert = await CurrencyConverter.convert(
      from: Currency.usd,
      to: selectedCurrency, // Use the selected currency here
      amount: 1,
    );
    setState(() {
      usdToPkr = usdConvert.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Money Converter Example'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "1 USD = ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      "$usdToPkr ${selectedCurrency.name.toUpperCase()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.green),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(0.8),
                    child: DropdownButtonFormField(
                        items: items, onChanged: onChanged)),
                Padding(
                  padding: EdgeInsets.all(0.8),
                  child: TextField(
                    controller: toController,
                    decoration: InputDecoration(
                      hintText: 'to',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add some spacing between the rows
                DropdownButton<Currency>(
                  value: selectedCurrency,
                  onChanged: (Currency? newValue) {
                    setState(() {
                      selectedCurrency = newValue!;
                      convert(); // Update the conversion on currency change
                    });
                  },
                  items: Currency.values
                      .map<DropdownMenuItem<Currency>>((Currency value) {
                    return DropdownMenuItem<Currency>(
                      value: value,
                      child: Text(value.name.toUpperCase()),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
