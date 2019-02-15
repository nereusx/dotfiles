/* -*- mode: cr; indent-width: 4; -*- */

void main(void)
{
}

void _startup_complete(int mode)
{
	assign_to_key("<Ctrl-C>", "copy");
	assign_to_key("<Ctrl-X>", "cut");
	assign_to_key("<Ctrl-V>", "paste");
	
	assign_to_key("<Ctrl-Up>", inq_assignment("<PgUp>"));
	assign_to_key("<Ctrl-Down>", inq_assignment("<PgDn>"));
	
	assign_to_key("<Ctrl-Left>", inq_assignment("<Home>"));
	assign_to_key("<Ctrl-Right>", inq_assignment("<End>"));

/* Borland's BCB6 keys */
/*	assign_to_key("<Ctrl-F1>", "topic help"); */
/*	assign_to_key("<Ctrl-F2>", "program reset"); */
/*	assign_to_key("<Alt-F2>", "window zoom"); */
	assign_to_key("<Ctrl-F9>", "make");
/*	assign_to_key("<Alt-F7>", "previous error"); */
/*	assign_to_key("<Alt-F8>", "next error"); */
/*	assign_to_key("<F9>", "run"); Borland's default */
/*	assign_to_key("<Ctrl-F10>", "run"); */
}

void showkey(string val)
{
	message(val + ": [" + inq_assignment(val) + "]");
}

