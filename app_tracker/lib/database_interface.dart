import 'package:sqlite3/sqlite3.dart';
import 'config_parser.dart';

class DatabaseInterface {
  static final Database db =
      sqlite3.open(ConfigParser.getDBLocation() + "/appliedjobs.db");

  static void insertNewApplication(
      String company, String position, String date) {
    final String insert = '''
    INSERT INTO job (company, position, applied_date) VALUES ('?', '?', '?');
    ''';

    PreparedStatement prepped = db.prepare(insert);
    prepped.execute([company, position, date]);
    prepped.dispose();
  }

  static void deleteJobApplication(
      String company, String position, String date) {
    final String delete = '''
    DELETE FROM job WHERE company = '?', position = '?', applied_date = '?';
    ''';

    PreparedStatement prepped = db.prepare(delete);
    prepped.execute([company, position, date]);
    prepped.dispose();
  }

  static void updateJobApplication(
      String company, String position, String appliedDate,
      {String updateCompany = '',
      String updatePosition = '',
      String updateAppliedDate = '',
      String responseDate = '',
      String responseType = '',
      String decisionDate = '',
      String decision = ''}) {
    final String update = '''
    UPDATE job SET company = '?', position = '?', applied_date = '?', 
      response_date = '?', response_type = '?', decision_date = '?', 
      decision = '?' WHERE company = '?', position = '?', applied_date = '?';
    ''';

    PreparedStatement prepped = db.prepare(update);
    prepped.execute([
      updateCompany,
      updatePosition,
      updateAppliedDate,
      responseDate,
      responseType,
      decisionDate,
      decision,
      company,
      position,
      appliedDate
    ]);
    prepped.dispose();
  }
}
