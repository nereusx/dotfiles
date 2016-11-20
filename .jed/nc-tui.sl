%%
%%
%%
%%

%namespace tui;

require("slsmg");

typedef struct {
	x, y, w, h,
	title
	} tui_win_t;

private variable windows = tui_win_t[16];
private variable curwin = 0;

% SCREEN_WIDTH;
% SCREEN_HEIGHT;

%% ------------------------------------------------------------------------

define tui_trim(s, maxlen)
{
	variable len = strlen(s);
	if ( len > maxlen )
		return substr(s, 1, maxlen);
	return s;
}

define tui_refresh()
{
	update(1);
}

define tui_openwin(left, top, width, height, title)
{
	variable x, i, sp, w = curwin;
	curwin ++;
	windows[w].x = left;
	windows[w].y = top;
	windows[w].w = width;
	windows[w].h = height;
	windows[w].title = title;

	variable row = top - 1;
	variable col = left - 2;
	if ( row < 0 ) row = 0;
	if ( col < 0 ) col = 0;
	if ( left + width > SCREEN_WIDTH )	width  = SCREEN_WIDTH - left;
	if ( top + height > SCREEN_HEIGHT )	height = SCREEN_HEIGHT - top;
	
%	slsmg_set_color(17); % window color
	slsmg_reverse_video();
	slsmg_draw_box(top - 1, left - 1, height + 2, width + 2);

    ifnot ( NULL == windows[w].title ) {
		variable wtitle = tui_trim(windows[w].title, width - 4);
        x = strlen(wtitle) + 2;
        x = ((width - x) / 2) + left;
        slsmg_gotorc(top - 1, x);
        slsmg_write_string(" " + wtitle + " ");
	    }

	sp = "";
	for ( i = 0; i < width; i ++ )
		sp = strcat(sp, " ");
	
	for ( i = top; i < (top + height + 1); i ++ ) {
		slsmg_gotorc(i, left);
		slsmg_write_string(sp);
		}
	slsmg_refresh();
	getkey();
}

%%
define tui_centwin(width, height, title) {
	variable	top, left;
	
	top  = ((SCREEN_HEIGHT - height) / 2) - 1;
    left = (SCREEN_WIDTH - width) / 2;

	tui_openwin(left, top, width, height, title);
}

%%
define tui_popwin()
{
	curwin --;
	tui_refresh();
}

%% ------------------------------------------------------------------------


