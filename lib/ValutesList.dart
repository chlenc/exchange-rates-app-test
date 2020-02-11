import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/Data.dart';
import 'dart:convert';

class ValutesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ValutesListState();
  }
}

class ValutesListState extends State<ValutesList> {
  @override
  List<Data> data = [];

 initState() {
    super.initState();
    _loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Курс валют"),
        
      ),
      body: Container(child: ListView(children: _buildList())),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _loadData,
      ),
    );
  }

  List<Widget> _buildList() {
    return data
        .map((Data f) => ListTile(
              title: Text(f.name),
              subtitle: Text(f.symbol),
              leading: CircleAvatar(child: Text(f.rank.toString())),
              trailing: Text(f.price.toString() + ' Руб.'),
            ))
        .toList();
  }

  _loadData() async {
    final response = await http.get('https://www.cbr-xml-daily.ru/daily_json.js');
    if(response.statusCode == 200){
      var allData = (json.decode(response.body) as Map)['Valute'] as Map<String, dynamic>;
      var list = List<Data>();
      allData.forEach((String key, dynamic val) {
        var record = Data(name: val['Name'], symbol: val['CharCode'], rank: val['Nominal'], price: val['Value']);
        list.add(record);
      });

      setState(() {
        data = list;
      });
    }
  }
}
