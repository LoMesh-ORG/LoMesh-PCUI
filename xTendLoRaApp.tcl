#############################################################################
# Generated by PAGE version 5.2
#  in conjunction with Tcl version 8.6
#  May 16, 2020 08:41:11 AM EDT  platform: Windows NT
set vTcl(timestamp) ""


if {!$vTcl(borrow) && !$vTcl(template)} {

set vTcl(actual_gui_bg) #d9d9d9
set vTcl(actual_gui_fg) #000000
set vTcl(actual_gui_analog) #ececec
set vTcl(actual_gui_menu_analog) #ececec
set vTcl(actual_gui_menu_bg) #d9d9d9
set vTcl(actual_gui_menu_fg) #000000
set vTcl(complement_color) #d9d9d9
set vTcl(analog_color_p) #d9d9d9
set vTcl(analog_color_m) #ececec
set vTcl(active_fg) #000000
set vTcl(actual_gui_menu_active_bg)  #ececec
set vTcl(pr,menufgcolor) #000000
set vTcl(pr,menubgcolor) #d9d9d9
set vTcl(pr,menuanalogcolor) #ececec
set vTcl(pr,treehighlight) firebrick
set vTcl(pr,autoalias) 1
set vTcl(pr,relative_placement) 1
set vTcl(mode) Relative
}




proc vTclWindow.top42 {base} {
    global vTcl
    if {$base == ""} {
        set base .top42
    }
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    set top $base
    ###################
    # CREATING WIDGETS
    ###################
    vTcl::widgets::core::toplevel::createCmd $top -class Toplevel \
        -menu "$top.m51" -background $vTcl(actual_gui_bg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black 
    wm focusmodel $top passive
    wm geometry $top 600x450+527+133
    update
    # set in toplevel.wgt.
    global vTcl
    global img_list
    set vTcl(save,dflt,origin) 0
    wm maxsize $top 1370 749
    wm minsize $top 120 1
    wm overrideredirect $top 0
    wm resizable $top 1 1
    wm deiconify $top
    wm title $top "xTendLoRa"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    set vTcl(real_top) {}
    vTcl:withBusyCursor {
    ttk::style configure TNotebook -background $vTcl(actual_gui_bg)
    ttk::style configure TNotebook.Tab -background $vTcl(actual_gui_bg)
    ttk::style configure TNotebook.Tab -foreground $vTcl(actual_gui_fg)
    ttk::style configure TNotebook.Tab -font "$vTcl(actual_gui_font_dft_desc)"
    ttk::style map TNotebook.Tab -background [list disabled $vTcl(actual_gui_bg) selected $vTcl(pr,guicomplement_color)]
    ttk::notebook $top.tNo43 \
        -width 294 -height 396 -takefocus {} 
    vTcl:DefineAlias "$top.tNo43" "TNotebook1" vTcl:WidgetProc "Toplevel1" 1
    frame $top.tNo43.t0 \
        -background $vTcl(actual_gui_bg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black 
    vTcl:DefineAlias "$top.tNo43.t0" "TNotebook1_t1" vTcl:WidgetProc "Toplevel1" 1
    $top.tNo43 add $top.tNo43.t0 \
        -padding 0 -sticky nsew -state normal -text Wireless -image {} \
        -compound left -underline -1 
    set site_4_0  $top.tNo43.t0
    label $site_4_0.lab55 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Network Address:} 
    vTcl:DefineAlias "$site_4_0.lab55" "Label3" vTcl:WidgetProc "Toplevel1" 1
    entry $site_4_0.ent56 \
        -background white -disabledforeground #a3a3a3 -font TkFixedFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -insertbackground black -justify center -selectbackground #c4c4c4 \
        -selectforeground black -textvariable NADDR_Text 
    vTcl:DefineAlias "$site_4_0.ent56" "Entry_NetworkAddress" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab59 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {TX Power:} 
    vTcl:DefineAlias "$site_4_0.lab59" "Label4" vTcl:WidgetProc "Toplevel1" 1
    ttk::combobox $site_4_0.tCo61 \
        -font TkTextFont -justify center -textvariable combobox_TXpowerText \
        -foreground {} -background {} -takefocus {} 
    vTcl:DefineAlias "$site_4_0.tCo61" "Combobox_TXPower" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab63 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Mode: 
    vTcl:DefineAlias "$site_4_0.lab63" "Label5" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab64 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Unknown -textvariable mode_Text 
    vTcl:DefineAlias "$site_4_0.lab64" "Label_Mode" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab65 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {RF Channel:} 
    vTcl:DefineAlias "$site_4_0.lab65" "Label7" vTcl:WidgetProc "Toplevel1" 1
    ttk::combobox $site_4_0.tCo66 \
        -font TkTextFont -justify center -textvariable combobox_RFChannel \
        -foreground {} -background {} -takefocus {} 
    vTcl:DefineAlias "$site_4_0.tCo66" "Combobox_RFCH" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab67 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Hop Count:} 
    vTcl:DefineAlias "$site_4_0.lab67" "Label8" vTcl:WidgetProc "Toplevel1" 1
    entry $site_4_0.ent68 \
        -background white -disabledforeground #a3a3a3 -font TkFixedFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -insertbackground black -justify center -selectbackground #c4c4c4 \
        -selectforeground black -textvariable HopCount_Text 
    vTcl:DefineAlias "$site_4_0.ent68" "Entry_HopCount" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab69 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {CAD Counter:} 
    vTcl:DefineAlias "$site_4_0.lab69" "Label9" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab70 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Unknown -textvariable CADCounter_Text 
    vTcl:DefineAlias "$site_4_0.lab70" "Label_CADCounter" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab71 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {CAD RSSI Level:} 
    vTcl:DefineAlias "$site_4_0.lab71" "Label11" vTcl:WidgetProc "Toplevel1" 1
    entry $site_4_0.ent72 \
        -background white -disabledforeground #a3a3a3 -font TkFixedFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -insertbackground black -justify center -selectbackground #c4c4c4 \
        -selectforeground black -textvariable RSSILevel_Text 
    vTcl:DefineAlias "$site_4_0.ent72" "Entry_RSSILevel" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab73 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {AES Key:} 
    vTcl:DefineAlias "$site_4_0.lab73" "Label12" vTcl:WidgetProc "Toplevel1" 1
    entry $site_4_0.ent74 \
        -background white -disabledforeground #a3a3a3 -font TkFixedFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -insertbackground black -justify right -selectbackground #c4c4c4 \
        -selectforeground black -textvariable AES_Text 
    vTcl:DefineAlias "$site_4_0.ent74" "Entry_AES" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_0.but76 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command resetCADCounter \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text {Reset CAD} 
    vTcl:DefineAlias "$site_4_0.but76" "Button_ResetCAD" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab77 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {CAD Reset:} 
    vTcl:DefineAlias "$site_4_0.lab77" "Label13" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab57 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Soft Reset:} 
    vTcl:DefineAlias "$site_4_0.lab57" "Label10" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_0.but58 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command softReset \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text {Reset Device} 
    vTcl:DefineAlias "$site_4_0.but58" "Button_SoftReset" vTcl:WidgetProc "Toplevel1" 1
    place $site_4_0.lab55 \
        -in $site_4_0 -x 10 -y 10 -anchor nw -bordermode ignore 
    place $site_4_0.ent56 \
        -in $site_4_0 -x 120 -y 10 -anchor nw -bordermode ignore 
    place $site_4_0.lab59 \
        -in $site_4_0 -x 30 -y 40 -anchor nw -bordermode ignore 
    place $site_4_0.tCo61 \
        -in $site_4_0 -x 120 -y 40 -width 163 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_0.lab63 \
        -in $site_4_0 -x 40 -y 70 -anchor nw -bordermode ignore 
    place $site_4_0.lab64 \
        -in $site_4_0 -x 120 -y 70 -width 164 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_0.lab65 \
        -in $site_4_0 -x 20 -y 100 -anchor nw -bordermode ignore 
    place $site_4_0.tCo66 \
        -in $site_4_0 -x 120 -y 100 -width 163 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_0.lab67 \
        -in $site_4_0 -x 20 -y 130 -anchor nw -bordermode ignore 
    place $site_4_0.ent68 \
        -in $site_4_0 -x 120 -y 130 -anchor nw -bordermode ignore 
    place $site_4_0.lab69 \
        -in $site_4_0 -x 20 -y 160 -anchor nw -bordermode ignore 
    place $site_4_0.lab70 \
        -in $site_4_0 -x 120 -y 160 -width 164 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_0.lab71 \
        -in $site_4_0 -x 10 -y 190 -anchor nw -bordermode ignore 
    place $site_4_0.ent72 \
        -in $site_4_0 -x 120 -y 190 -anchor nw -bordermode ignore 
    place $site_4_0.lab73 \
        -in $site_4_0 -x 30 -y 220 -width 44 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_0.ent74 \
        -in $site_4_0 -x 120 -y 220 -anchor nw -bordermode ignore 
    place $site_4_0.but76 \
        -in $site_4_0 -x 120 -y 250 -width 167 -relwidth 0 -height 24 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_0.lab77 \
        -in $site_4_0 -x 20 -y 250 -anchor nw -bordermode ignore 
    place $site_4_0.lab57 \
        -in $site_4_0 -x 30 -y 290 -anchor nw -bordermode ignore 
    place $site_4_0.but58 \
        -in $site_4_0 -x 120 -y 290 -width 167 -height 24 -anchor nw \
        -bordermode ignore 
    frame $top.tNo43.t1 \
        -background $vTcl(actual_gui_bg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black 
    vTcl:DefineAlias "$top.tNo43.t1" "TNotebook1_t2" vTcl:WidgetProc "Toplevel1" 1
    $top.tNo43 add $top.tNo43.t1 \
        -padding 0 -sticky nsew -state normal -text Information -image {} \
        -compound left -underline -1 
    set site_4_1  $top.tNo43.t1
    label $site_4_1.lab78 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {MAC ID:} 
    vTcl:DefineAlias "$site_4_1.lab78" "Label14" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab79 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Unknown -textvariable MAC_Text 
    vTcl:DefineAlias "$site_4_1.lab79" "Label_MAC" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab81 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Short Address:} 
    vTcl:DefineAlias "$site_4_1.lab81" "Label16" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab84 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Unknown -textvariable ADDR_Text 
    vTcl:DefineAlias "$site_4_1.lab84" "Label_ADDR" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab85 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Firmware Version:} 
    vTcl:DefineAlias "$site_4_1.lab85" "Label18" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab86 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {AT Command Set:} 
    vTcl:DefineAlias "$site_4_1.lab86" "Label19" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab87 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Unknown -textvariable Firmware_Text 
    vTcl:DefineAlias "$site_4_1.lab87" "Label_Firmware" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab89 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Unknown -textvariable ATSet_Text 
    vTcl:DefineAlias "$site_4_1.lab89" "Label_ATSet" vTcl:WidgetProc "Toplevel1" 1
    place $site_4_1.lab78 \
        -in $site_4_1 -x 40 -y 10 -anchor nw -bordermode ignore 
    place $site_4_1.lab79 \
        -in $site_4_1 -x 130 -y 10 -width 154 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_1.lab81 \
        -in $site_4_1 -x 20 -y 30 -anchor nw -bordermode ignore 
    place $site_4_1.lab84 \
        -in $site_4_1 -x 130 -y 30 -width 157 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_1.lab85 \
        -in $site_4_1 -x 20 -y 50 -anchor nw -bordermode ignore 
    place $site_4_1.lab86 \
        -in $site_4_1 -x 20 -y 70 -anchor nw -bordermode ignore 
    place $site_4_1.lab87 \
        -in $site_4_1 -x 130 -y 50 -width 154 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_1.lab89 \
        -in $site_4_1 -x 130 -y 70 -width 147 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    frame $top.tNo43.t2 \
        -background $vTcl(actual_gui_bg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black 
    vTcl:DefineAlias "$top.tNo43.t2" "TNotebook1_t3" vTcl:WidgetProc "Toplevel1" 1
    $top.tNo43 add $top.tNo43.t2 \
        -padding 0 -sticky nsew -state normal -text Communication -image {} \
        -compound none -underline -1 
    set site_4_2  $top.tNo43.t2
    label $site_4_2.lab47 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Short ID:} 
    vTcl:DefineAlias "$site_4_2.lab47" "Label2" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_2.lab48 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Data: 
    vTcl:DefineAlias "$site_4_2.lab48" "Label6" vTcl:WidgetProc "Toplevel1" 1
    entry $site_4_2.ent49 \
        -background white -disabledforeground #a3a3a3 -font TkFixedFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -insertbackground black -selectbackground #c4c4c4 \
        -selectforeground black -textvariable RXTXShortID 
    vTcl:DefineAlias "$site_4_2.ent49" "EntryShortIDRXTX" vTcl:WidgetProc "Toplevel1" 1
    entry $site_4_2.ent50 \
        -background white -disabledforeground #a3a3a3 -font TkFixedFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -insertbackground black -selectbackground #c4c4c4 \
        -selectforeground black -textvariable Packet 
    vTcl:DefineAlias "$site_4_2.ent50" "EntryPacket" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_2.but51 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command sendMessage \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text Send 
    vTcl:DefineAlias "$site_4_2.but51" "Button_SendData" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_2.but53 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command recvMessage \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text Recieve 
    vTcl:DefineAlias "$site_4_2.but53" "Button_RecvData" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_2.but54 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command bcastMessage \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text Broadcast 
    vTcl:DefineAlias "$site_4_2.but54" "Button_BcastData" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_2.but55 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command setSink \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text {Set Sink} 
    vTcl:DefineAlias "$site_4_2.but55" "Button_SetSinkData" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_2.but56 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command sendSinkMessage \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text {Send Sink} 
    vTcl:DefineAlias "$site_4_2.but56" "Button_sendSink" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_2.but49 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command get_rx_queue \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text {RX Queue} 
    vTcl:DefineAlias "$site_4_2.but49" "Button_RXQ" vTcl:WidgetProc "Toplevel1" 1
    place $site_4_2.lab47 \
        -in $site_4_2 -x 20 -y 30 -width 54 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_2.lab48 \
        -in $site_4_2 -x 0 -relx 0.069 -y 0 -rely 0.162 -width 0 \
        -relwidth 0.114 -height 0 -relheight 0.057 -anchor nw \
        -bordermode ignore 
    place $site_4_2.ent49 \
        -in $site_4_2 -x 100 -y 30 -anchor nw -bordermode ignore 
    place $site_4_2.ent50 \
        -in $site_4_2 -x 10 -y 90 -width 274 -relwidth 0 -height 60 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_2.but51 \
        -in $site_4_2 -x 10 -y 190 -width 67 -relwidth 0 -height 44 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_2.but53 \
        -in $site_4_2 -x 110 -y 190 -width 67 -relwidth 0 -height 44 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_2.but54 \
        -in $site_4_2 -x 0 -relx 0.724 -y 0 -rely 0.514 -width 67 -relwidth 0 \
        -height 44 -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_2.but55 \
        -in $site_4_2 -x 10 -y 260 -width 67 -height 44 -anchor nw \
        -bordermode ignore 
    place $site_4_2.but56 \
        -in $site_4_2 -x 110 -y 260 -width 67 -height 44 -anchor nw \
        -bordermode ignore 
    place $site_4_2.but49 \
        -in $site_4_2 -x 0 -relx 0.724 -y 0 -rely 0.703 -width 67 -relwidth 0 \
        -height 44 -relheight 0 -anchor nw -bordermode ignore 
    frame $top.tNo43.t3 \
        -background $vTcl(actual_gui_bg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black 
    vTcl:DefineAlias "$top.tNo43.t3" "TNotebook1_t4" vTcl:WidgetProc "Toplevel1" 1
    $top.tNo43 add $top.tNo43.t3 \
        -padding 0 -sticky nsew -state normal -text Bootloader -image {} \
        -compound none -underline -1 
    set site_4_3  $top.tNo43.t3
    label $site_4_3.lab43 \
        -activebackground #f0f0f0 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {Bootloader Version:} 
    vTcl:DefineAlias "$site_4_3.lab43" "Label_bootloaderversion" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_3.lab44 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -textvariable bl_version_number 
    vTcl:DefineAlias "$site_4_3.lab44" "Label_version_number_bl" vTcl:WidgetProc "Toplevel1" 1
    button $site_4_3.but45 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command bootload \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text Button 
    vTcl:DefineAlias "$site_4_3.but45" "Button_start_bl" vTcl:WidgetProc "Toplevel1" 1
    ttk::progressbar $site_4_3.tPr46 \
        -length 100 
    vTcl:DefineAlias "$site_4_3.tPr46" "TProgressbar1" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_3.lab47 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text Progress 
    vTcl:DefineAlias "$site_4_3.lab47" "Label20" vTcl:WidgetProc "Toplevel1" 1
    place $site_4_3.lab43 \
        -in $site_4_3 -x 10 -y 20 -width 124 -relwidth 0 -height 31 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_3.lab44 \
        -in $site_4_3 -x 140 -y 20 -width 134 -relwidth 0 -height 31 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_3.but45 \
        -in $site_4_3 -x 20 -y 60 -width 257 -relwidth 0 -height 34 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_3.tPr46 \
        -in $site_4_3 -x 20 -y 150 -width 260 -relwidth 0 -height 22 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $site_4_3.lab47 \
        -in $site_4_3 -x 20 -y 120 -width 64 -relwidth 0 -height 21 \
        -relheight 0 -anchor nw -bordermode ignore 
    ttk::combobox $top.tCo45 \
        -font TkTextFont -textvariable Combobox_COMText -foreground {} \
        -background {} -takefocus {} 
    vTcl:DefineAlias "$top.tCo45" "Combobox_COM" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab46 \
        -activebackground #f9f9f9 -activeforeground black \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -text {COM Port} 
    vTcl:DefineAlias "$top.lab46" "Label1" vTcl:WidgetProc "Toplevel1" 1
    button $top.but49 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command readData \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text Read 
    vTcl:DefineAlias "$top.but49" "Button_Read" vTcl:WidgetProc "Toplevel1" 1
    ttk::style configure TButton -background $vTcl(actual_gui_bg)
    ttk::style configure TButton -foreground $vTcl(actual_gui_fg)
    ttk::style configure TButton -font "$vTcl(actual_gui_font_dft_desc)"
    ttk::button $top.tBu50 \
        -command refreshCOMPorts -takefocus {} -text Refresh 
    vTcl:DefineAlias "$top.tBu50" "TButton1" vTcl:WidgetProc "Toplevel1" 1
    set site_3_0 $top.m51
    menu $site_3_0 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(pr,menubgcolor) -font TkMenuFont \
        -foreground $vTcl(pr,menufgcolor) -tearoff 0 
    button $top.but43 \
        -activebackground $vTcl(analog_color_m) -activeforeground #000000 \
        -background $vTcl(actual_gui_bg) -command writeData \
        -disabledforeground #a3a3a3 -font TkDefaultFont \
        -foreground $vTcl(actual_gui_fg) \
        -highlightbackground $vTcl(actual_gui_bg) -highlightcolor black \
        -pady 0 -text Write 
    vTcl:DefineAlias "$top.but43" "Button_Write" vTcl:WidgetProc "Toplevel1" 1
    ttk::combobox $top.tCo44 \
        -font TkTextFont -textvariable combobox_paritytext -foreground {} \
        -background {} -takefocus {} 
    vTcl:DefineAlias "$top.tCo44" "Combobox_parity" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab45 \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) -text Parity 
    vTcl:DefineAlias "$top.lab45" "Label15" vTcl:WidgetProc "Toplevel1" 1
    ttk::combobox $top.tCo47 \
        -font TkTextFont -textvariable combobox_baudtext -foreground {} \
        -background {} -takefocus {} 
    vTcl:DefineAlias "$top.tCo47" "Combobox_baud" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab48 \
        -background $vTcl(actual_gui_bg) -disabledforeground #a3a3a3 \
        -font TkDefaultFont -foreground $vTcl(actual_gui_fg) \
        -text {Baud Rate} 
    vTcl:DefineAlias "$top.lab48" "Label17" vTcl:WidgetProc "Toplevel1" 1
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.tNo43 \
        -in $top -x 0 -y 0 -rely 0.022 -width 0 -relwidth 0.49 -height 0 \
        -relheight 0.88 -anchor nw -bordermode ignore 
    place $top.tCo45 \
        -in $top -x 300 -y 60 -width 253 -relwidth 0 -height 21 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.lab46 \
        -in $top -x 300 -y 30 -anchor nw -bordermode ignore 
    place $top.but49 \
        -in $top -x 440 -y 350 -width 117 -relwidth 0 -height 54 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.tBu50 \
        -in $top -x 470 -y 90 -anchor nw -bordermode ignore 
    place $top.but43 \
        -in $top -x 300 -y 350 -width 117 -relwidth 0 -height 54 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.tCo44 \
        -in $top -x 0 -relx 0.5 -y 0 -rely 0.667 -width 0 -relwidth 0.205 \
        -height 0 -relheight 0.047 -anchor nw -bordermode ignore 
    place $top.lab45 \
        -in $top -x 0 -relx 0.5 -y 0 -rely 0.6 -width 0 -relwidth 0.057 \
        -height 0 -relheight 0.047 -anchor nw -bordermode ignore 
    place $top.tCo47 \
        -in $top -x 0 -relx 0.733 -y 0 -rely 0.667 -width 0 -relwidth 0.205 \
        -height 0 -relheight 0.047 -anchor nw -bordermode ignore 
    place $top.lab48 \
        -in $top -x 0 -relx 0.733 -y 0 -rely 0.6 -width 0 -relwidth 0.098 \
        -height 0 -relheight 0.047 -anchor nw -bordermode ignore 
    } ;# end vTcl:withBusyCursor 

    vTcl:FireEvent $base <<Ready>>
}

set btop ""
if {$vTcl(borrow)} {
    set btop .bor[expr int([expr rand() * 100])]
    while {[lsearch $btop $vTcl(tops)] != -1} {
        set btop .bor[expr int([expr rand() * 100])]
    }
}
set vTcl(btop) $btop
Window show .
Window show .top42 $btop
if {$vTcl(borrow)} {
    $btop configure -background plum
}

