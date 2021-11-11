import 'dart:io';

class ConfigParser {
  File configFile =
      File(Platform.environment["HOME"]! + "/.appTrack/config.conf");

  bool checkIfConfigFileExists() => configFile.existsSync();

  void createConfigFile(File databaseLocation) {
    if (!checkIfConfigFileExists()) {
      configFile.createSync(recursive: true);
      fillEmptyFile();
      updateDatabaseLocation(databaseLocation);
    } else {
      updateDatabaseLocation(databaseLocation);
    }
  }

  void fillEmptyFile() {
    String contents = """
# This is the configuration file for the AppTrack job applicaiton tracking
# program.

# Set the following line to the path of your databse file. (Note: the
# application should handle this automatically)\
database_location=NULL
""";

    configFile.writeAsStringSync(contents);
  }

  void updateDatabaseLocation(File databasseLocation) {
    List<String> contents = configFile.readAsLinesSync();

    String updated = """""";

    contents.forEach((line) {
      if (line.isEmpty || line.substring(0, 1) == "#") {
        updated.isEmpty ? updated = line : updated = updated + "\n" + line;
      } else if (line.split("=")[0] == "database_location") {
        updated =
            updated + "\n" + line.split("=")[0] + "=" + databasseLocation.path;
      }
    });
    configFile.writeAsStringSync(updated);
  }
}
