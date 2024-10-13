import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'network.dart';
import 'dart:io' show Platform;
import 'dart:math';
class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedValue;
  String selectedValueCopy = 'USD';
  String? selectedValue1;
  String selectedValueCopy1 = 'USD';
  int? showData;
  int? showData1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNet();
    getNetETH();

  }

   Future<String> getNet() async {
     Network myNet = Network('https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=$selectedValueCopy');
     var Data = await myNet.getConnection();
    // print('inside priceScreen: ${Data[selectedValueCopy]}');
     setState((){ showData = Data[selectedValueCopy].round();
     });
     //print('Data: $showData');
     return showData.toString();

   }
  Future<String> getNetETH() async {
    Network myNet = Network('https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=$selectedValueCopy1');
    var Data = await myNet.getConnection();
    print('inside priceScreen: ${Data[selectedValueCopy1]}');
    setState((){ showData1 = Data[selectedValueCopy1].round();
    });
    print('Data: $showData1');
    return showData1.toString();

  }

  Widget forAndroid() {
    List<DropdownMenuItem<String>> myList = [];
    for (String i in currenciesList) {
      myList.add(DropdownMenuItem(child: Text(i), value: i));
    }
    return DropdownButton(
      value: selectedValue??'USD',
      items:myList,
      onChanged: (value) {
        setState(() async{
        selectedValue = value;
        selectedValueCopy = selectedValue??'USD';
        selectedValue1 = value;
        selectedValueCopy1 = selectedValue??'USD';
        await getNet();
        await getNetETH();
      });},
    );

  }
  Widget forIos(){
    List<Widget> myList =[];
    for (String i in currenciesList){
        myList.add(Text(i));
  }
   return  CupertinoPicker(
        children: myList,
        itemExtent: 35.0,
        onSelectedItemChanged: (value){
          setState(() async{
            selectedValue = currenciesList[value];
            selectedValueCopy = selectedValue??'USD';
            selectedValue1 = currenciesList[value];
            selectedValueCopy1 = selectedValue??'USD';
            await getNet();
            await getNetETH();
          });
          },);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BitCoin Ticker'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
                  child: Card(
                      color: Colors.black26,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text("1BTC = $showData $selectedValueCopy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            )),
                      )),
                ),

            //from Here Changing
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
              child: Card(
                  color: Colors.black26,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text("1ETH = $showData1 $selectedValueCopy1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        )),
                  )),
            ),
  // from here 2 changing

],),

            Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.black26,
                child: Platform.isIOS?forIos():forAndroid(),
            ),
          ],
        ));
  }
}
