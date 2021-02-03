// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pad_string(_string_to_pad,_pad_char,_pad_length,_pad_left){
	if (string_length(_string_to_pad) < _pad_length)
	{
		var ret_str = _string_to_pad;
		while (string_length(ret_str) < _pad_length)
		{
			if (_pad_left)
			{
				ret_str = _pad_char + ret_str;
			} else 
			{
				ret_str = ret_str + _pad_char;
			}
		}
		return ret_str;
	} else 
	{
		return _string_to_pad;
	}
}

function get_current_real_world_time_as_timestamp()
{
	var date_prefix = pad_string(string(current_month),"0",2,true) + "/" + pad_string(string(current_day),"0",2,true) + "/" + string(current_year);
	var time_suffix = pad_string(string(current_hour),"0",2,true) + ":" + pad_string(string(current_minute),"0",2,true) + ":" + pad_string(string(current_second),"0",2,true);
	return date_prefix + " " + time_suffix;
}

function convert_ms_to_timestamp(_time_ms, _include_ms_in_output){
	var time_elapsed_hours = floor(_time_ms / (1000 * 60 * 60));
	var time_elapsed_minutes = floor(_time_ms / (1000 * 60) % 60);
	var time_elapsed_seconds = floor(_time_ms / 1000) % 60; 
	var time_elapsed_ms = _time_ms % 1000;
	var fmt_time_elpased_hours = pad_string(string(time_elapsed_hours),"0",1,true);
	var fmt_time_elapsed_minutes = pad_string(string(time_elapsed_minutes),"0",2,true);
	var fmt_time_elapsed_seconds = pad_string(string(time_elapsed_seconds),"0",2,true);
	var fmt_time_elapsed_ms = pad_string(string(time_elapsed_ms),"0",3,true);
	if (_include_ms_in_output)
	{
		return fmt_time_elpased_hours + ":" + fmt_time_elapsed_minutes + ":" + fmt_time_elapsed_seconds + "." + fmt_time_elapsed_ms;
	} else 
	{
		return fmt_time_elpased_hours + ":" + fmt_time_elapsed_minutes + ":" + fmt_time_elapsed_seconds;
		
	}
}