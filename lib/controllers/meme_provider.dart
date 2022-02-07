import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Meme generator API controller
class MemeProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool _badIntenet = false;

  bool get badIntenet => _badIntenet;

  bool get isLoading => _isLoading;

  List? _memes;

  int? _memeIndex;

  int? get memeIndex => _memeIndex;

  /// memes samples
  /// [
  ///   {"id":"181913649","name":"Drake Hotline Bling","url":"https:\/\/i.imgflip.com\/30b1gx.jpg","width":1200,"height":1200,"box_count":2},
  ///   {"id":"87743020","name":"Two Buttons","url":"https:\/\/i.imgflip.com\/1g8my4.jpg","width":600,"height":908,"box_count":3},
  ///   {"id":"112126428","name":"Distracted Boyfriend","url":"https:\/\/i.imgflip.com\/1ur9b0.jpg","width":1200,"height":800,"box_count":3},
  ///   {"id":"131087935","name":"Running Away Balloon","url":"https:\/\/i.imgflip.com\/261o3j.jpg","width":761,"height":1024,"box_count":5},
  ///   {"id":"124822590","name":"Left Exit 12 Off Ramp","url":"https:\/\/i.imgflip.com\/22bdq6.jpg","width":804,"height":767,"box_count":3},
  /// ]
  List? get memes => _memes;

  Future<void> loadMemes() async {
    String url = 'https://api.imgflip.com/get_memes';
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body["success"] == true) {
          _memes = jsonDecode(response.body)['data']['memes'];
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint("$e");

      _badIntenet = true;
      notifyListeners();
    }
  }

  Future<void> getMeme() async {
    _isLoading = true;
    notifyListeners();
    if (_memes == null) {
      await loadMemes();
    }
    if (_badIntenet) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    Random rng = Random();
    int? randomIndex;
    while (true) {
      randomIndex = rng.nextInt(_memes!.length);
      if (randomIndex != _memeIndex) break;
    }
    _memeIndex = randomIndex;
    _isLoading = false;
    notifyListeners();
  }
}
