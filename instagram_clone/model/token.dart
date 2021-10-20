import 'package:sqflite/sqflite.dart';

class Token {
  final int id;
  final String token;

  Token({required this.token, required this.id});

  Future<void> insertToken(Token token, database) async {
    final db = await database;

    await db.insert(
      'tokens',
      token.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token
    };
  }

  @override
  String toString() {
    return 'id: $id, token: $token';
  }
}
