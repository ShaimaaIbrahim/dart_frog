
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

extension HashStringExtensions on String{

  String get hashValue {
    return sha256.convert(utf8.encode(this)).toString();
  }
  
}