// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// AUTHOR: Jessica Kelly, @Anatithenai

global.log4gms2_log_level_trace = 0;
global.log4gms2_log_level_debug = 1;
global.log4gms2_log_level_info = 2;
global.log4gms2_log_level_warn = 3;
global.log4gms2_log_level_error = 4;
global.log4gms2_log_level_fatal = 5;

global.log4gms2_log_can_write_to_disk = false;
global.log4gms2_log_file_created = false;
global.log4gms2_log_current_num_entries_in_file = 0;
global.log4gms2_log_max_entries_in_file = 5000;

global.log4gms2_log_filename_prefix = "log_name_not_set";
global.log4gms2_log_filename_extension = ".log";

global.log4gms2_log_filename_complete = "oops";
global.log4gms2_log_file_id = -1;

function set_log_can_write_to_disk(_bool)
{
	global.log4gms2_log_can_write_to_disk = _bool;
}

function set_log_max_entries_in_file(_int)
{
	global.log4gms2_log_max_entries_in_file = _int;
}

function set_log_filename_prefix(_prefix)
{
	global.log4gms2_log_filename_prefix = _prefix;
}

function set_log_filename_extension(_extension)
{
	global.log4gms2_log_filename_extension = _extension;
}

function set_log_filename()
{
	global.log4gms2_log_filename_complete = global.log4gms2_log_filename_prefix + string(current_year) + pad_string(string(current_month),"0",2,true) + pad_string(string(current_day),"0",2,true) + pad_string(string(current_hour),"0",2,true) + pad_string(string(current_minute),"0",2,true) + pad_string(string(current_second),"0",2,true) + global.log4gms2_log_filename_extension;
}

function can_log(_log_level){
	if (_log_level >= global.log4gms2_log_level)
	{
		return true;
	}
	return false;
}

function get_log_desc_from_level(_log_level)
{
	if (_log_level == global.log4gms2_log_level_trace)
	{
		return "TRACE";
	} else if (_log_level == global.log4gms2_log_level_debug)
	{
		return "DEBUG";
	} else if (_log_level == global.log4gms2_log_level_info)
	{
		return "INFO";
	} else if (_log_level == global.log4gms2_log_level_warn)
	{
		return "WARN";
	} else if (_log_level == global.log4gms2_log_level_error)
	{
		return "ERROR";
	} else if (_log_level == global.log4gms2_log_level_fatal)
	{
		return "FATAL";
	} else {
		return "UNKNOWN LOG LEVEL";
	}
}

function log_message(_log_level, _message){
	if (can_log(_log_level))
	{
		var log_string = get_current_real_world_time_as_timestamp() + " " + get_log_desc_from_level(_log_level) + " " + _message;
		show_debug_message(log_string);
		if (global.log4gms2_log_can_write_to_disk)
		{
			if (global.log4gms2_log_file_id < 0)
			{
				set_log_filename();
				global.log4gms2_log_file_id = file_text_open_append(global.log4gms2_log_filename_complete);
				show_debug_message("Log will be saved to: " + working_directory + "/" + global.log4gms2_log_filename_complete);
			}
			
			if (global.log4gms2_log_current_num_entries_in_file >= global.log4gms2_log_max_entries_in_file)
			{
				file_text_close(global.log_file_id);
				global.log4gms2_log_file_created = true;
				global.log4gms2_log_current_num_entries_in_file = 0;
				set_log_filename();
				global.log4gms2_log_file_id = file_text_open_append(global.log4gms2_log_filename_complete);
			}
			
			file_text_write_string(global.log4gms2_log_file_id, log_string + "\n");
			global.log4gms2_log_current_num_entries_in_file++;
		}
	}
}

function log_flush_log_file_at_game_end()
{
	if (global.log4gms2_log_can_write_to_disk == true && global.log4gms2_log_file_id > -1)
	{
		file_text_close(global.log4gms2_log_file_id);
		global.log4gms2_log_can_write_to_disk = false;
		global.log4gms2_log_file_id = -1;
	}
}
