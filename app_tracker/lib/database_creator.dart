import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

class DatabaseCreator {
  static void generateDatabaseIfNotExitst(String databaseLocation) {
    if (!File(databaseLocation + "/appliedjobs.db").existsSync()) {
      generateDatabase(databaseLocation);
    }
  }

  static void generateDatabase(String databaseLocation) {
    final Database db = sqlite3.open(databaseLocation + "/appliedjobs.db");

    generateTables(db);
    db.dispose();
  }

  static void generateTables(Database db) {
    String createAppliedTable = '''
    CREATE TABLE IF NOT EXISTS job (
      company varchar(40),
      position varchar(40),
      applied_date date,
      response_date date NULL,
      response_type varchar(20) NULL,
      decision_date date NULL,
      decision varchar(20) NULL,
      PRIMARY KEY (company, position, applied_date)
    );''';

    db.execute(createAppliedTable);
  }
}
