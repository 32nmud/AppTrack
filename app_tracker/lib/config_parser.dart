import 'dart:io';

class ConfigParser {
  static File configFile =
      File(Platform.environment["HOME"]! + "/.appTrack/config.conf");

  static bool checkIfConfigFileExists() => configFile.existsSync();

  static void createConfigFile(String databaseLocation) {
    if (!checkIfConfigFileExists()) {
      configFile.createSync(recursive: true);
      fillEmptyFile();
      updateDatabaseLocation(databaseLocation);
    } else {
      updateDatabaseLocation(databaseLocation);
    }
  }

  static void fillEmptyFile() {
    String contents = """
# This is the configuration file for the AppTrack job applicaiton tracking
# program.

# Set the following line to the path of your databse file. (Note: the
# application should handle this automatically)\
database_location=NULL
""";

    configFile.writeAsStringSync(contents);
  }

  static void updateDatabaseLocation(String databasseLocation) {
    List<String> contents = configFile.readAsLinesSync();

    String updated = """""";

    contents.forEach((line) {
      if (line.isEmpty || line.substring(0, 1) == "#") {
        updated.isEmpty ? updated = line : updated = updated + "\n" + line;
      } else if (line.split("=")[0] == "database_location") {
        updated = updated + "\n" + line.split("=")[0] + "=" + databasseLocation;
      }
    });
    configFile.writeAsStringSync(updated);
  }

  static String getDBLocation() {
    List<String> contents = configFile.readAsLinesSync();

    for (String line in contents) {
      if (line.split("=")[0] == "database_location") {
        return line.split("=")[1];
      }
    }
    //TODO: Implement and throw an error here.
    return "Location not found!";
  }
}
