# log4gms2
Scripts to promote log4XYZ logging for GameMaker Studio 2.3

Use of the log4gms2 code is provided under the **MIT license**.  Please cite me as *Jessica Kelly, @Anatithenai*.

# Usage

In your *Game Start* object, use the following functions to configure log4gms2 for your project.

```
// initialize LOG4GMS23
global.log4gms2_log_level = global.log4gms2_log_level_debug;
set_log_can_write_to_disk(true);
set_log_filename_prefix("wizard-game-");
set_log_filename_extension(".log");
set_log_max_entries_in_file(5000);

// sample log usage
log_message(global.log4gms2_log_level_debug, "Hello World!");
log_message(global.log4gms2_log_level_info, "Happy Funtime Logging!!!");
```

The `global.log4gms2_log_level` describes the *threshold* of which messages are logged.  You can choose from TRACE, DEBUG, INFO, WARN, ERROR, FATAL.  So if you choose `WARN` then only messages of the types WARN, ERROR, and FATAL will be logged while the game is running.

If you want to use file-based logging, use the `set_log_can_write_to_disk(true)` function.  From there you can configure the prefix of the file and the file extension as well as how many entries each log should contain.

To clean up and flush the file contents to disk, add the following to your *Game End* object:

```
log_flush_log_file_at_game_end();
```

This will flush any messages held in memory to the file whose pattern is specified by `set_log_filename_prefix(...)` and `set_log_filename_extension`.

See the GMS2.3 documentation for the `working_directory` that these log files will be saved in.

