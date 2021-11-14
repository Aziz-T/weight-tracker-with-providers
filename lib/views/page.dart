import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:numberpicker/src/decimal_numberpicker.dart';
import 'package:providers/models/weight.dart';
import 'package:providers/state/weight_state.dart';
import 'package:provider/provider.dart';

class WeightPage extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Weight tracker"),
          ),
          body: Consumer<WeightState>(builder: (context, state, a) {
            var weights = state.weights;

            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Current Weight: "),
                            Text(
                              state.currentWeight.value.toString() + " kg",
                              textScaleFactor: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var weight = weights[index];
                      return ListTile(
                        title: Text(
                          "${weight.date.day}.${weight.date.month}.${weight.date.year}",
                          textScaleFactor: 0.9,
                        ),
                        trailing: Text(
                          weight.value.toString() + " kg",
                          textScaleFactor: 2.0,
                        ),
                      );
                    },
                    itemCount: state.weights.length,
                  ),
                )
              ],
            );
          }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              _displayTextInputDialog(context);
            },
          ),
        ));
  }


//   Future<double?> _showAddWeightDialog(
//       BuildContext context, double currentWeight) async {
//     return await showDialog<double>(
//         context: context,
//         builder: (BuildContext context) {
//           return DecimalNumberPicker(
//             minValue: 1,
//             maxValue: 200,
//             value: currentWeight, onChanged: (double value) {  }, //weights.first.value,
//           );
//         });
// }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                print(_textEditingController.text);
                var state = Provider.of<WeightState>(context, listen: false);

                var result = _textEditingController.text;
                if (result != null ) {
                  state.add(Weight(value: double.parse(result), date: DateTime.now()));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


}

