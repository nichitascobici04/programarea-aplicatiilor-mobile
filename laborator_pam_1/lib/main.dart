import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversie Monedă',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();

  String _sourceCurrency = 'MDL';
  String _destCurrency = 'EUR';
  String _resultText = 'Rezultat: 0.00';

  final List<String> _currencies = ['MDL', 'EUR', 'USD'];

  final Map<String, double> _ratesToMDL = {
    'MDL': 1.0,
    'USD': 17.50,
    'EUR': 19.20,
  };

  void _convertCurrency() {
    double? amount = double.tryParse(_amountController.text.replaceAll(',', '.'));

    if (amount == null) {
      setState(() {
        _resultText = 'Introduceți o sumă numerică validă!';
      });
      return;
    }

    double sourceRate = _ratesToMDL[_sourceCurrency]!;
    double destRate = _ratesToMDL[_destCurrency]!;

    double amountInMDL = amount * sourceRate;
    double convertedAmount = amountInMDL / destRate;

    setState(() {
      _resultText = '${amount.toStringAsFixed(2)} $_sourceCurrency = ${convertedAmount.toStringAsFixed(2)} $_destCurrency';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convertor Valutar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Introduceți suma',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: _sourceCurrency,
                    items: [
                      for (String currency in _currencies)
                        DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        )
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _sourceCurrency = newValue;
                        });
                      }
                    },
                  ),
                  const Icon(Icons.arrow_forward_outlined),
                  DropdownButton<String>(
                    value: _destCurrency,
                    items: [
                      for (String currency in _currencies)
                        DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        )
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _destCurrency = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _convertCurrency,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('CONVERTEȘTE', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 40),

              Text(
                _resultText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}