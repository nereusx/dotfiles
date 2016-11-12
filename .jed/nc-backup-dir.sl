%%	backup filenames on directory
%%	Example:
%%	% keep backup files at this directory
%%	Backup_Directory = getenv("HOME") + "/.backup/jed/";
%%	define make_backup_filename(dir, file) { return backup_dir_filename(dir, file); }

custom_variable("Backup_Directory", "");

public define backup_dir_filename(dir, file)
{
	variable f = Backup_Directory;
	
	if ( strlen(f) ) {
		f = strcat(f, strtrans(dir, "/", "_"));
		f = strcat(f, "_");
		f = strcat(f, file);
		}
	else 
		f = strcat(dir, "/", file, "~");

	return f;
}

% install it
public define make_backup_filename(dir, file)
{
	return backup_dir_filename(dir, file);
}
