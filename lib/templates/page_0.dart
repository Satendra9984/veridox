import 'package:flutter/material.dart';

class Page0 extends StatefulWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  late List<Map<String, dynamic>> _values;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Form'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                setState(() {
                  _count++;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                setState(() {
                  _count = 0;
                });
              },
            )
          ],
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _count,
          itemBuilder: (context, index) {
            return _row(index);
          },
        ),
      ),
    );
  }

  _row(int index) {
    return Row(
      children: [
        Text('ID: $index'),
        const SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            onChanged: (val) {
              _onUpdate(index, val);
            },
          ),
        ),
      ],
    );
  }

  _onUpdate(int index, String val) async {
    int foundKey = -1;
    for (var map in _values) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _values.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
    };
    _values.add(json);
  }
}
