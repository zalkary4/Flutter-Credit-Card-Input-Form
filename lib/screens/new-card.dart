import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card_input_form/constains.dart';

class AddnewCardScreen extends StatefulWidget {
  const AddnewCardScreen({Key? key}) : super(key: key);

  @override
  State<AddnewCardScreen> createState() => _AddnewCardScreenState();
}

class _AddnewCardScreenState extends State<AddnewCardScreen> {
  TextEditingController cardNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('New card'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPaddin),
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                      hintText: 'Card number',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Icon(Icons.credit_card),
                      )),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();
    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;
      if (index % 4 == 0 && inputData.length != index) {
        buffer.write('   ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}




/// 3-09