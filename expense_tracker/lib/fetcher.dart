import 'package:expense_tracker/expense.dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class ExpenseDatabase {
  static final ExpenseDatabase _instance = ExpenseDatabase._internal();

  factory ExpenseDatabase() {
    return _instance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  ExpenseDatabase._internal();

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final pathToDb = path.join(dbPath, 'expense_database.db');

    return await openDatabase(
      pathToDb,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE expenses ('
            'id INTEGER PRIMARY KEY, '
            'category TEXT, '
            'date TEXT, '
            'amount REAL'
            ')');
      },
    );
  }

  Future<List<ExpenseDto>> getExpenses() async {
    final db = await database;
    final result = await db.query('expenses');

    return ExpenseDto.fromList(result);
  }

  Future<void> addExpense(ExpenseDto expense) async {
    final db = await database;

    await db.insert('expenses', expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateExpense(ExpenseDto expense) async {
    final db = await database;

    await db.update('expenses', expense.toMap(),
        where: 'id = ?', whereArgs: [expense.id]);
  }

  Future<void> deleteExpense(int id) async {
    final db = await database;

    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
