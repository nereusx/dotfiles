#!/bin/bash

# steam client
# resized theme

scale='1.333'
gui=0
web=1
skin_name='bigger'

#
st_css=`locate -w steam.styles | grep $USER | head -1`
st_dir=`dirname $st_css`
skin_dir="$st_dir/../../skins/$skin_name"

mkdir -p $skin_dir
mkdir -p $skin_dir/resource/styles/
cp $st_dir/* $skin_dir/resource/styles/

echo "BEGIN { scale_f=${scale}; }
/Arial|Helvetica/ { sub(/Arial|Helvetica/,\"Roboto\") }
/font\\-size=/ { sub(/\"|\\r/, \"\"); split(\$0,a,\"=\"); print a[1],\"=\",a[2]*scale_f; next; }
{ sub(/\"|\\r/, \"\"); print; }
" > resize.awk

new_css="$skin_dir/resource/styles/steam.styles"
if [ $gui -eq 1 ]; then
	awk -f resize.awk $st_css > $new_css
fi

#echo ":root { zoom: ${scale}; }" > $skin_dir/resource/webkit.css

echo ":root { zoom: ${scale}; }
.breadcrumbs, #application_root, .store_tooltip, 
.queue_reason_description, .queue_btn_ignore_menu, 
.mature_content_notice, .queue_controls_description
{ display: none !important; }
#store_controls
{ position: fixed !important; top: 0px; right: 0px; }
#store_nav_area { top: 0px !important; }
div#store_header, div#store_header .content
{ height: 40px !important; }
.html5_video_overlay { zoom: 0.666; }
" > webkit.css

if [ $gui -eq 1 ]; then
	mv webkit.css $skin_dir/resource/webkit.css
fi

rm -f resize.awk

#
echo "Select the theme '$skin_name' from Steam and restart"
echo "done"

