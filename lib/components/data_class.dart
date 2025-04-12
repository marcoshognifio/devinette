import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String url = "http://192.168.100.23:3030";
String accessToken = "";
String refreshToken = "";
Map currentUser = {};
double screenWidth = 0;
double screenHeight = 0;
int during = 400;
String token="";


List<String> listRoutes = [];



Color colorApp = Colors.black;
List<Color> listColor = [Colors.black, Colors.black54];

class CounterPage {
  int value;
  CounterPage(this.value);
}

class ChooseCori {
  int x;
  int y;
  ChooseCori(this.x,this.y);
}

List<Map> listPay = [
  {
    'name' : 'MTN Money',
    'image' :'assets/methods_pay/mp2.png',
    'detail' :  'Default payment'
  },
  {
    'name' : 'MOOV Money',
    'image' :'assets/methods_pay/mp3.png',
    'detail' :  'Not default payment'
  },
  {
    'name' : 'Celtis Cash',
    'image' :'assets/methods_pay/mp4.png',
    'detail' :  'Not default payment'
  },
  {
    'name' : 'MastersCard',
    'image' :'assets/methods_pay/mp1.png',
    'detail' :  'Not default payment'
  },
];

List<Map> listAlphabets = [],listDivinities = [], listSigns = [],listDetails = [];

ValueNotifier<bool> listSignsNotifier = ValueNotifier(false),
    listAlphabetsNotifier = ValueNotifier(false),
    listDivinitiesNotifier = ValueNotifier(false);

class DatabaseHelper {
  final databaseName = 'database.db';
  Database? _database;

  Future get database async {
    if (_database != null) {
      return _database;
    }
    else {
      _database = await initDB();
      return _database;
    }
  }

  Future<Database> initDB() async {
    print('---------INITIALISATION DB-----------');

    final directory = await getDatabasesPath();;
    final path = join(directory, databaseName);
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    print('---------CREATE DB-----------');

    await db.execute('''CREATE TABLE IF NOT EXISTS user(
      accessToken TEXT NOT NULL,
      refreshToken TEXT NOT NULL
      )'''
    );

    print('Batabase is create of success');
  }


  Future insertToken(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert("user", user);

    print('add project success');
  }

  Future<List<Map>> getTokenUser() async {
    final db = await database;
    return await db!.query('user');
  }

  Future<List<Map>> getSignsAll() async {
    final uri = Uri.parse("$url/signe");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    listSigns = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listSignsNotifier.value = listSignsNotifier.value == false;
    return [];
  }

  Future<List<Map>> searchSign(String item) async {

    final uri = Uri.parse("$url/signe/search");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });
    listSigns = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listSignsNotifier.value = listSignsNotifier.value == false;
    return [];
  }

  Future<List<Map>> searchSign2(List<int>list) async {

    List<int> tableauImpair = [];
    List<int> tableauPair = [];
    for (int i = 0; i < list.length; i++) {
      if (i % 2 == 0) {
        tableauImpair.add(list[i]);
      } else {
        tableauPair.add(list[i]);
      }
    }
    Map<String,dynamic> request = {
      'value1' : tableauPair,
      'value2' : tableauImpair
    };

    print(jsonEncode(request));

    final uri = Uri.parse("$url/signe/search/table/verify");
    final response = await http.post(uri,
      body: jsonEncode(request),
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });
    print('coucocu');
    print(response.body);
    listSigns = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listSignsNotifier.value = listSignsNotifier.value == false;
    return [];
  }

  Future<List<Map>> getDivinitiesAll() async {
    final uri = Uri.parse("$url/divinity");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    listDivinities = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listDivinitiesNotifier.value = listDivinitiesNotifier.value == false;
    return [];
  }

  Future<List<Map>> searchDivinity(String item) async {
    final uri = Uri.parse("$url/divinity/search/$item");
    final response = await http.get(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        }
    );
    listDivinities = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listDivinitiesNotifier.value = listDivinitiesNotifier.value == false;
    return [];
  }

  Future<List<Map>> getAlphabetsAll() async {
    final uri = Uri.parse("$url/alphabet");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    listAlphabets = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listAlphabetsNotifier.value = listAlphabetsNotifier.value == false;
    return [];
  }

  Future<List<Map>> searchAlphabet(String item) async {

    final uri = Uri.parse("$url/alphabet/search/$item");
    final response = await http.get(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        }
    );

    listAlphabets = json.decode(response.body).cast<Map<dynamic, dynamic>>();
    listAlphabetsNotifier.value = listAlphabetsNotifier.value == false;
    return [];
  }


  Future getUserProfile() async {
    final uri = Uri.parse("$url/user/profile");
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    Map currentUser  = json.decode(response.body);
  }
}


class Group {

  List<List<Map>> getGroupList(List<Map> list) {

    List<List<Map>> result = [];
    int n = list.length;
    int a = 5,b=0;
    int c = n ~/ a ;
    List<Map> E = [];
    if(c>0){
      for(int i=0;i<c;i++){
        E=[];
        for(int j =0;j<a;j++){

          E.add(list[b]);
          b++;
        }
        result.add(E);
      }
    }

    c = c*a;
    n = n-c;
    E = [];
    for(int i=0;i<n;i++){
      E.add(list[b]);
      b++;
    }

    result.add(E);

    return result;
  }
}
