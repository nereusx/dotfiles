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

	assign_to_key("<Alt-F10>", "make");
}

