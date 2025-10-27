prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>17062793957969100
,p_default_application_id=>138
,p_default_id_offset=>17513279999319301
,p_default_owner=>'CMF'
);
end;
/
 
prompt APPLICATION 138 - PKX
--
-- Application Export:
--   Application:     138
--   Name:            PKX
--   Date and Time:   19:25 Monday October 27, 2025
--   Exported By:     KAREL
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 29734975957629210
--   Manifest End
--   Version:         24.2.0
--   Instance ID:     800104173856312
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/lib4x_axt_ig_singlerow
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(29734975957629210)
,p_plugin_type=>'REGION TYPE'
,p_name=>'LIB4X.AXT.IG.SINGLEROW'
,p_display_name=>'LIB4X - IG Single Row'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function get_attr_as_boolean(',
'    p_region in apex_plugin.t_region,',
'    p_attribute in varchar2',
')',
'return boolean',
'is',
'    l_attribute varchar2(10);',
'begin',
'    l_attribute := p_region.attributes.get_varchar2(p_attribute);',
'    return (l_attribute is not null and l_attribute = ''Y'');',
'end;',
'',
'procedure render (',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_region in            apex_plugin.t_region,',
'    p_param  in            apex_plugin.t_region_render_param,',
'    p_result in out nocopy apex_plugin.t_region_render_result )',
'is ',
'    l_region_id             varchar2(50);  ',
'    l_columns_layout        varchar2(20);',
'    l_span_width            varchar2(20);',
'    l_form_label_width      varchar2(20);',
'    l_max_one_new_row       boolean;',
'    l_buttons_conf          varchar2(400);',
'    l_row_action_buttons    boolean;',
'    l_pagination_buttons    boolean;',
'begin',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_region(p_plugin => p_plugin, p_region => p_region);',
'    end if;',
'    l_region_id := apex_escape.html_attribute(p_region.static_id);',
'    l_columns_layout := p_region.attributes.get_varchar2(''attr_columns_layout'');',
'    l_span_width := p_region.attributes.get_varchar2(''attr_span_width'');',
'    l_form_label_width := p_region.attributes.get_varchar2(''attr_form_label_width'');',
'    l_max_one_new_row := get_attr_as_boolean(p_region, ''attr_max_one_new_row'');',
'',
'    l_row_action_buttons := get_attr_as_boolean(p_region, ''attr_row_action_buttons'');',
'    l_buttons_conf := ''{'' || apex_javascript.add_attribute(''rowActionButtons'', l_row_action_buttons);',
'    if (l_row_action_buttons) then',
'        l_buttons_conf := l_buttons_conf || apex_javascript.add_attribute(''addRow'', get_attr_as_boolean(p_region, ''attr_add_row_button'')) ||',
'            apex_javascript.add_attribute(''duplicateRow'', get_attr_as_boolean(p_region, ''attr_duplicate_row_button'')) ||',
'            apex_javascript.add_attribute(''deleteRow'', get_attr_as_boolean(p_region, ''attr_delete_row_button'')) ||',
'            apex_javascript.add_attribute(''refreshRow'', get_attr_as_boolean(p_region, ''attr_refresh_row_button'')) ||',
'            apex_javascript.add_attribute(''revertRow'', get_attr_as_boolean(p_region, ''attr_revert_row_button''));',
'    end if;',
'    l_pagination_buttons := get_attr_as_boolean(p_region, ''attr_pagination_buttons'');',
'    l_buttons_conf := l_buttons_conf || apex_javascript.add_attribute(''edit'', get_attr_as_boolean(p_region, ''attr_edit_button'')) ||',
'        apex_javascript.add_attribute(''paginationButtons'', l_pagination_buttons, false, false);',
'    if (l_pagination_buttons) then',
'        l_buttons_conf := l_buttons_conf || '','' || apex_javascript.add_attribute(''firstLast'', get_attr_as_boolean(p_region, ''attr_first_last_buttons''), false, false);',
'    end if;',
'    l_buttons_conf := l_buttons_conf || ''}'';',
' ',
'    -- When specifying the library declaratively, it fails to load the minified version. So using the API:',
'    apex_javascript.add_library(',
'          p_name      => ''ig-singlerow'',',
'          p_check_to_add_minified => true,',
'          --p_directory => ''#WORKSPACE_FILES#javascript/'',          ',
'          p_directory => p_plugin.file_prefix || ''js/'',',
'          p_version   => NULL',
'    );  ',
'',
'    apex_css.add_file (',
'        p_name => ''ig-singlerow'',',
'        --p_directory => ''#WORKSPACE_FILES#css/''',
'        p_directory => p_plugin.file_prefix || ''css/'' ',
'    );    ',
'',
'    apex_javascript.add_onload_code(',
'        p_code => apex_string.format(',
'            ''lib4x.axt.ig.singleRow._init("%s", "%s", "%s", "%s", %s, ''',
'            , l_region_id',
'            , l_columns_layout',
'            , l_span_width',
'            , l_form_label_width',
'            , case l_max_one_new_row when true then ''true'' else ''false'' end',
'        ) || l_buttons_conf ||'');''',
'    );    ',
'end;'))
,p_api_version=>3
,p_render_function=>'render'
,p_substitute_attributes=>true
,p_version_scn=>413715959
,p_subscribe_plugin_settings=>true
,p_help_text=>'Region to render a single row of data in a simple form layout, enabling editing, navigating and refreshing data without page submits. Define the query and fields to be used in an IG and make the IG a sub region.'
,p_version_identifier=>'1.0.1'
,p_about_url=>'https://github.com/kekema/apex-ig-single-row'
,p_files_version=>77
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(28918435218270593)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_title=>'Toolbar'
,p_display_sequence=>10
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29735526359629223)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'attr_columns_layout'
,p_prompt=>'Columns Layout'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_show_in_wizard=>false
,p_default_value=>'NONE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Enables to distribute the fields to a number of columns.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29735970387629223)
,p_plugin_attribute_id=>wwv_flow_imp.id(29735526359629223)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'NONE'
,p_help_text=>'No columns layout.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29736442858629225)
,p_plugin_attribute_id=>wwv_flow_imp.id(29735526359629223)
,p_display_sequence=>20
,p_display_value=>'Field Columns Span'
,p_return_value=>'FIELD_COLUMNS_SPAN'
,p_help_text=>'Achieve a columns layout by specifying a span width which will be applied to each field. The fields are put side by side as per this width. So the distribution of fields is horizontally.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29736986497629225)
,p_plugin_attribute_id=>wwv_flow_imp.id(29735526359629223)
,p_display_sequence=>30
,p_display_value=>'Field Group Columns'
,p_return_value=>'FIELD_GROUP_COLUMNS'
,p_help_text=>'Achieve a columns layout by utilizing Field Groups which can be defined as Column Groups in the IG. Each group will be a column in which the related fields are distributed vertically.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29737477691629226)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'attr_form_label_width'
,p_prompt=>'Form Label Width'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Gives a number of options, both in percentage as well as in pixels, for the width of the label part of all fields.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29740332297629229)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>10
,p_display_value=>'20%'
,p_return_value=>'20p'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29740812146629229)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>20
,p_display_value=>'25%'
,p_return_value=>'25p'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29741388515629229)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>30
,p_display_value=>'30%'
,p_return_value=>'30p'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29737856486629226)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>40
,p_display_value=>'35%'
,p_return_value=>'35p'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29738376044629226)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>50
,p_display_value=>'40%'
,p_return_value=>'40p'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29738890766629228)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>60
,p_display_value=>'100px'
,p_return_value=>'100'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29739301779629228)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>70
,p_display_value=>'150px'
,p_return_value=>'150'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29739882757629229)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>80
,p_display_value=>'200px'
,p_return_value=>'200'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29741806107629231)
,p_plugin_attribute_id=>wwv_flow_imp.id(29737477691629226)
,p_display_sequence=>90
,p_display_value=>'250px'
,p_return_value=>'250'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29743150192629232)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>30
,p_static_id=>'attr_span_width'
,p_prompt=>'Span Width'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_show_in_wizard=>false
,p_default_value=>'6'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(29735526359629223)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'FIELD_COLUMNS_SPAN'
,p_lov_type=>'STATIC'
,p_help_text=>'The span width effectively determines the number of columns. Normally, the span width of a field is 12. By specifying a width of 6, 4 or 3, the number of resulting columns will be 2, 3 or 4.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29743545393629234)
,p_plugin_attribute_id=>wwv_flow_imp.id(29743150192629232)
,p_display_sequence=>10
,p_display_value=>'3'
,p_return_value=>'3'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29744037029629234)
,p_plugin_attribute_id=>wwv_flow_imp.id(29743150192629232)
,p_display_sequence=>20
,p_display_value=>'4'
,p_return_value=>'4'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(29744592422629234)
,p_plugin_attribute_id=>wwv_flow_imp.id(29743150192629232)
,p_display_sequence=>30
,p_display_value=>'6'
,p_return_value=>'6'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29825799377229260)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>50
,p_static_id=>'attr_row_action_buttons'
,p_prompt=>'Row Action Buttons'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29826321430238245)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>60
,p_static_id=>'attr_add_row_button'
,p_prompt=>'Add Row Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(29825799377229260)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29826958350241778)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>70
,p_static_id=>'attr_duplicate_row_button'
,p_prompt=>'Duplicate Row Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(29825799377229260)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29827569840245517)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>80
,p_static_id=>'attr_delete_row_button'
,p_prompt=>'Delete Row Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(29825799377229260)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29828188584249442)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>90
,p_static_id=>'attr_refresh_row_button'
,p_prompt=>'Refresh Row Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(29825799377229260)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29828791956253326)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>100
,p_static_id=>'attr_revert_row_button'
,p_prompt=>'Revert Row Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(29825799377229260)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29829326650255606)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>110
,p_static_id=>'attr_edit_button'
,p_prompt=>'Edit Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29829958735257665)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>120
,p_static_id=>'attr_pagination_buttons'
,p_prompt=>'Pagination Buttons'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(29830511621261153)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>130
,p_static_id=>'attr_first_last_buttons'
,p_prompt=>'First/Last Buttons'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(29829958735257665)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(28918435218270593)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(28928727170353414)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>170
,p_static_id=>'attr_max_one_new_row'
,p_prompt=>'Max 1 new Row per Save'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Enable in case you want to allow max one new row to be added at a time.'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6C696234782D73617276202E612D52562D626F6479207B2D2D612D72762D626F64792D70616464696E672D783A20302E3572656D3B7D2E6C696234782D73617276202E612D546F6F6C626172202E612D546F6F6C6261722D737461746963207B666F6E';
wwv_flow_imp.g_varchar2_table(2) := '742D73697A653A20313270783B6C696E652D6865696768743A20313270783B70616464696E673A2030203870783B7D2E6C696234782D73617276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D7769';
wwv_flow_imp.g_varchar2_table(3) := '6474682D323570290D0A7B77696474683A203235253B7D2E6C696234782D73617276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D353070290D0A7B77696474683A203530253B7D2E';
wwv_flow_imp.g_varchar2_table(4) := '6C696234782D73617276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D373570290D0A7B77696474683A203735253B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D32';
wwv_flow_imp.g_varchar2_table(5) := '3070207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203230253B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D323570207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D7769647468';
wwv_flow_imp.g_varchar2_table(6) := '3A203235253B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D333070207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203330253B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D333570';
wwv_flow_imp.g_varchar2_table(7) := '207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203335253B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D343070207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A20';
wwv_flow_imp.g_varchar2_table(8) := '3430253B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D313030207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2031303070783B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D313530';
wwv_flow_imp.g_varchar2_table(9) := '207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2031353070783B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D323030207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D7769647468';
wwv_flow_imp.g_varchar2_table(10) := '3A2032303070783B7D2E6C696234782D666F726D2D6C6162656C2D77696474682D323530207B2D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2032353070783B7D2E6C696234782D73617276202E752D466F726D2D67726F';
wwv_flow_imp.g_varchar2_table(11) := '757048656164696E6720627574746F6E207B77696474683A20313030253B746578742D616C69676E3A2073746172743B626F726465723A20303B666F6E742D73697A653A202E3635656D3B70616464696E673A203470783B7D2E6C696234782D73617276';
wwv_flow_imp.g_varchar2_table(12) := '202E752D466F726D2D67726F757048656164696E67202E612D49636F6E207B766572746963616C2D616C69676E3A20746578742D626F74746F6D3B7D2E6C696234782D736172762068332E752D466F726D2D67726F757048656164696E67207B6D617267';
wwv_flow_imp.g_varchar2_table(13) := '696E2D626C6F636B2D73746172743A20302E35656D3B6D617267696E2D626C6F636B2D656E643A20302E34656D3B7D2E6C696234782D73617276202E612D52562D626F64792E752D666C6578202E612D416C657274207B6D61782D77696474683A203230';
wwv_flow_imp.g_varchar2_table(14) := '253B7D';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(28771289623711771)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_file_name=>'css/ig-singlerow.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6C696234782D73617276202E612D52562D626F6479207B0D0A202020202D2D612D72762D626F64792D70616464696E672D783A20302E3572656D3B0D0A7D0D0A0D0A2E6C696234782D73617276202E612D546F6F6C626172202E612D546F6F6C626172';
wwv_flow_imp.g_varchar2_table(2) := '2D737461746963207B0D0A20202020666F6E742D73697A653A20313270783B0D0A202020206C696E652D6865696768743A20313270783B0D0A2020202070616464696E673A2030203870783B0D0A20207D0D0A0D0A2F2A2E6C696234782D73617276202E';
wwv_flow_imp.g_varchar2_table(3) := '612D4947207B0D0A202020202D2D612D746F6F6C6261722D6974656D2D73706163696E673A20302E3372656D3B0D0A7D2A2F0D0A0D0A2E6C696234782D73617276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D66';
wwv_flow_imp.g_varchar2_table(4) := '69656C642D77696474682D323570290D0A7B0D0A2020202077696474683A203235253B0D0A7D0D0A0D0A2E6C696234782D73617276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D35';
wwv_flow_imp.g_varchar2_table(5) := '3070290D0A7B0D0A2020202077696474683A203530253B0D0A7D0D0A0D0A2E6C696234782D73617276202E612D47562D636F6C756D6E4974656D3A686173282E6C696234782D666F726D2D6669656C642D77696474682D373570290D0A7B0D0A20202020';
wwv_flow_imp.g_varchar2_table(6) := '77696474683A203735253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D323070207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203230253B0D0A7D0D0A0D0A2E6C6962';
wwv_flow_imp.g_varchar2_table(7) := '34782D666F726D2D6C6162656C2D77696474682D323570207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203235253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D3330';
wwv_flow_imp.g_varchar2_table(8) := '70207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A203330253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D333570207B0D0A202020202D2D612D666F726D2D6C616265';
wwv_flow_imp.g_varchar2_table(9) := '6C2D636F6E7461696E65722D77696474683A203335253B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D343070207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A20343025';
wwv_flow_imp.g_varchar2_table(10) := '3B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D313030207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2031303070783B0D0A7D0D0A0D0A2E6C696234782D666F726D2D';
wwv_flow_imp.g_varchar2_table(11) := '6C6162656C2D77696474682D313530207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2031353070783B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D323030207B0D0A20';
wwv_flow_imp.g_varchar2_table(12) := '2020202D2D612D666F726D2D6C6162656C2D636F6E7461696E65722D77696474683A2032303070783B0D0A7D0D0A0D0A2E6C696234782D666F726D2D6C6162656C2D77696474682D323530207B0D0A202020202D2D612D666F726D2D6C6162656C2D636F';
wwv_flow_imp.g_varchar2_table(13) := '6E7461696E65722D77696474683A2032353070783B0D0A7D0D0A0D0A2E6C696234782D73617276202E752D466F726D2D67726F757048656164696E6720627574746F6E207B0D0A2020202077696474683A20313030253B0D0A20202020746578742D616C';
wwv_flow_imp.g_varchar2_table(14) := '69676E3A2073746172743B0D0A20202020626F726465723A20303B0D0A20202020666F6E742D73697A653A202E3635656D3B0D0A2020202070616464696E673A203470783B0D0A7D0D0A0D0A2E6C696234782D73617276202E752D466F726D2D67726F75';
wwv_flow_imp.g_varchar2_table(15) := '7048656164696E67202E612D49636F6E207B0D0A20202020766572746963616C2D616C69676E3A20746578742D626F74746F6D3B0D0A7D0D0A0D0A2E6C696234782D736172762068332E752D466F726D2D67726F757048656164696E67207B0D0A202020';
wwv_flow_imp.g_varchar2_table(16) := '206D617267696E2D626C6F636B2D73746172743A20302E35656D3B0D0A202020206D617267696E2D626C6F636B2D656E643A20302E34656D3B0D0A7D0D0A0D0A2E6C696234782D73617276202E612D52562D626F64792E752D666C6578202E612D416C65';
wwv_flow_imp.g_varchar2_table(17) := '7274207B0D0A202020206D61782D77696474683A203230253B0D0A7D';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(29747902834629256)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_file_name=>'css/ig-singlerow.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '77696E646F772E6C69623478203D2077696E646F772E6C69623478207C7C207B7D3B0D0A77696E646F772E6C696234782E617874203D2077696E646F772E6C696234782E617874207C7C207B7D3B0D0A77696E646F772E6C696234782E6178742E696720';
wwv_flow_imp.g_varchar2_table(2) := '3D2077696E646F772E6C696234782E6178742E6967207C7C207B7D3B0D0A0D0A2F2A0D0A202A20526567696F6E20706C7567696E20746F20646973706C617920612073696E676C6520726F7720617420612074696D6520696E20612073696D706C652066';
wwv_flow_imp.g_varchar2_table(3) := '6F726D206C61796F75742C20656E61626C696E670D0A202A2065646974696E672C206E617669676174696E6720616E642072656672657368696E67206461746120776974686F75742070616765207375626D6974732E2054686520666F726D2063616E20';
wwv_flow_imp.g_varchar2_table(4) := '6265206D61646520200D0A202A2070617274206F662061204D61737465722D44657461696C2073657475702C207769746820737570706F727420666F722073696E676C65207472616E73616374696F6E2E0D0A202A2054686520706C7567696E20697320';
wwv_flow_imp.g_varchar2_table(5) := '616374696E67206173206120777261707065722061726F756E6420616E20496E74657261637469766520477269642E20497420646F657320736F0D0A202A20627920636F6E6669677572696E672074686520494720746F207573652053696E676C652052';
wwv_flow_imp.g_varchar2_table(6) := '6F772056696577206F6E6C7920616E642061646A757374696E672074686520746F6F6C6261727320617320746F20686176650D0A202A206F6E6520746F6F6C6261722077697468206372756420616E6420706167696E6174696F6E20627574746F6E732E';
wwv_flow_imp.g_varchar2_table(7) := '0D0A202A2054686520706C7567696E20616C736F2068617320736F6D6520657874726120666561747572657320746F207468652073696E676C6520726F77207669657720617320746F20656E61626C652073657474696E67200D0A202A206669656C6420';
wwv_flow_imp.g_varchar2_table(8) := '77696474682C206120627574746F6E20746F20657870616E642F636F6C6C61707365206669656C642067726F7570732C2061206665617475726520746F20656E61626C65206669656C6420636F6C756D6E732C200D0A202A20616E642061206665617475';
wwv_flow_imp.g_varchar2_table(9) := '726520746F2073657420746865207769647468206F6620746865206C6162656C732E0D0A202A20416C736F2C2074686520706C7567696E2068617320736F6D6520776F726B61726F756E647320666F722069737375657320696E20746865204150455820';
wwv_flow_imp.g_varchar2_table(10) := '756E6465726C79696E67207265636F726456696577207769646765742E0D0A202A2054686520494720746F206265206D61646520612073756220726567696F6E20696E2074686520706167652064657369676E65722E0D0A202A20466F7220636F6E6669';
wwv_flow_imp.g_varchar2_table(11) := '6775726174696F6E7320696E207768696368207468652049472053696E676C6520526F77206973207573656420696E2061204D61737465722D44657461696C2073657474696E672C20746865200D0A202A20706C7567696E206F66666572732073757070';
wwv_flow_imp.g_varchar2_table(12) := '6F727420746F20696D706C656D656E742053696E676C65205472616E73616374696F6E2E0D0A202A204279206D616B696E6720757365206F662049472053696E676C6520526F7720506C7567696E2C20697420616C736F206272696E6773207468652062';
wwv_flow_imp.g_varchar2_table(13) := '656E65666974206F662074686520756E6465726C79696E6720414A41580D0A202A2073657276657220636F6D6D756E69636174696F6E2C2070726576656E74696E67206E65656420666F722070616765207375626D6974732E0D0A202A2F0D0A6C696234';
wwv_flow_imp.g_varchar2_table(14) := '782E6178742E69672E73696E676C65526F77203D202866756E6374696F6E282429207B0D0A202020200D0A20202020636F6E737420435F52565F424F4459203D2027612D52562D626F6479273B0D0A20202020636F6E737420435F434F4C4C4150534942';
wwv_flow_imp.g_varchar2_table(15) := '4C45203D2027612D436F6C6C61707369626C65273B0D0A20202020636F6E737420435F434F4C4C41505349424C455F434F4E54454E54203D2027612D436F6C6C61707369626C652D636F6E74656E74273B0D0A20202020636F6E737420435F464C455820';
wwv_flow_imp.g_varchar2_table(16) := '3D2027752D666C6578273B0D0A20202020636F6E737420435F464C45585F47524F575F31203D2027752D666C65782D67726F772D31273B0D0A20202020636F6E737420435F464F524D203D2027752D466F726D273B0D0A20202020636F6E737420435F46';
wwv_flow_imp.g_varchar2_table(17) := '4F524D5F47524F55505F48454144494E47203D2027752D466F726D2D67726F757048656164696E67273B0D0A20202020636F6E737420435F4C494234585F53415256203D20276C696234782D73617276273B20202F2F20736172763A207374616E64616C';
wwv_flow_imp.g_varchar2_table(18) := '6F6E6520726F77766965772028696E697469616C206E616D6520666F72207468697320706C7567696E290D0A20202020636F6E737420435F4C494234585F464F524D5F4C4142454C5F57494454485F505245464958203D20276C696234782D666F726D2D';
wwv_flow_imp.g_varchar2_table(19) := '6C6162656C2D77696474682D273B0D0A20202020636F6E7374204143545F4649525354203D202766697273742D7265636F7264273B0D0A20202020636F6E7374204143545F4C415354203D20276C6173742D7265636F7264273B0D0A20202020636F6E73';
wwv_flow_imp.g_varchar2_table(20) := '742054425F425554544F4E203D2022425554544F4E223B0D0A20202020636F6E73742054425F4D454E55203D20224D454E55223B0D0A20202020636F6E737420414354494F4E203D2022616374696F6E223B0D0A20202020636F6E737420544F47474C45';
wwv_flow_imp.g_varchar2_table(21) := '203D2022746F67676C65223B0D0A20202020636F6E737420524144494F5F47524F5550203D2022726164696F47726F7570223B0D0A20202020636F6E737420534550415241544F525F4D49203D207B20747970653A2022736570617261746F7222207D3B';
wwv_flow_imp.g_varchar2_table(22) := '0D0A20202020636F6E737420454E41424C45203D2022656E61626C65223B0D0A20202020636F6E73742044495341424C45203D202264697361626C65223B202020200D0A0D0A202020206C657420736172764F7074696F6E73203D207B7D3B2020202020';
wwv_flow_imp.g_varchar2_table(23) := '2020202020202F2F20706C7567696E206F7074696F6E7320616E6420636F6E6669670D0A0D0A202020206C657420726F77566965774D6F64756C65203D202866756E6374696F6E2829200D0A202020207B0D0A20202020202020202F2F20457874656E64';
wwv_flow_imp.g_varchar2_table(24) := '696E672074686520756E6465726C79696E67207265636F7264566965772077696467657420617320746F2062652061626C6520746F20636F6E74726F6C0D0A20202020202020202F2F2074686520746F6F6C6261722028627574746F6E732920616E6420';
wwv_flow_imp.g_varchar2_table(25) := '6D616B696E67205549206C61796F75742061646A7573746D656E74730D0A202020202020202066756E6374696F6E20657874656E645265636F72645669657757696467657428290D0A20202020202020207B0D0A202020202020202020202020242E7769';
wwv_flow_imp.g_varchar2_table(26) := '646765742822617065782E7265636F726456696577222C20242E617065782E7265636F7264566965772C207B0D0A202020202020202020202020202020202F2F20417420746865206D6F6D656E7420746865207265636F72645669657720757064617465';
wwv_flow_imp.g_varchar2_table(27) := '7320746865207265636F72642073746174652C200D0A202020202020202020202020202020202F2F207570646174652074686520737461746520696E2074686520746F6F6C6261720D0A202020202020202020202020202020205F757064617465526563';
wwv_flow_imp.g_varchar2_table(28) := '6F726453746174653A2066756E6374696F6E2829207B0D0A202020202020202020202020202020202020202069662028746869732E656C656D656E742E636C6F7365737428272E27202B2020435F4C494234585F53415256292E6C656E677468290D0A20';
wwv_flow_imp.g_varchar2_table(29) := '202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020757064617465546F6F6C6261725265636F7264537461746528746869732E656C656D656E74293B20202020202F2F2069732073696E67';
wwv_flow_imp.g_varchar2_table(30) := '6C65526F7756696577240D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202072657475726E20746869732E5F737570657228293B0D0A202020202020202020202020202020207D2C0D0A2020';
wwv_flow_imp.g_varchar2_table(31) := '20202020202020202020202020202F2F2063616C6C6564206279204150455820746F2064657465726D696E65207468652061637475616C207374617465206F6620616374696F6E730D0A202020202020202020202020202020202F2F20616E6420697427';
wwv_flow_imp.g_varchar2_table(32) := '732072656C6174656420627574746F6E730D0A202020202020202020202020202020205F757064617465416374696F6E733A2066756E6374696F6E2829207B0D0A202020202020202020202020202020202020202069662028746869732E656C656D656E';
wwv_flow_imp.g_varchar2_table(33) := '742E636C6F7365737428272E27202B2020435F4C494234585F53415256292E6C656E677468290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206C657420637572526563203D20';
wwv_flow_imp.g_varchar2_table(34) := '746869732E656C656D656E742E7265636F72645669657728276765745265636F726427293B0D0A2020202020202020202020202020202020202020202020206C657420616374696F6E73203D20746869732E656C656D656E742E7265636F726456696577';
wwv_flow_imp.g_varchar2_table(35) := '2827676574416374696F6E7327293B0D0A20202020202020202020202020202020202020202020202066756E6374696F6E20746F67676C6528207072656469636174652C20616374696F6E2029207B0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(36) := '202020202020202020616374696F6E735B707265646963617465203F20454E41424C45203A2044495341424C455D2820616374696F6E20293B0D0A2020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(37) := '20202020202020202020746F67676C65282063757252656320262620746869732E5F6861734E65787428292C204143545F4C41535420293B0D0A202020202020202020202020202020202020202020202020746F67676C65282063757252656320262620';
wwv_flow_imp.g_varchar2_table(38) := '746869732E5F68617350726576696F757328292C204143545F464952535420293B0D0A202020202020202020202020202020202020202020202020746F67676C6528206375725265632C2027726566726573682D7265636F72642720293B0D0A20202020';
wwv_flow_imp.g_varchar2_table(39) := '202020202020202020202020202020207D0D0A20202020202020202020202020202020202020206C657420726573756C74203D20746869732E5F737570657228293B0D0A202020202020202020202020202020202020202069662028746869732E656C65';
wwv_flow_imp.g_varchar2_table(40) := '6D656E742E636C6F7365737428272E27202B2020435F4C494234585F53415256292E6C656E677468290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206C6574206576656E744F';
wwv_flow_imp.g_varchar2_table(41) := '626A203D207B7D3B0D0A2020202020202020202020202020202020202020202020206576656E744F626A2E6D6F64656C203D20746869732E656C656D656E742E7265636F72645669657728276765744D6F64656C27293B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(42) := '202020202020202020202020206576656E744F626A2E7265636F7264203D20746869732E656C656D656E742E7265636F72645669657728276765745265636F726427293B0D0A2020202020202020202020202020202020202020202020206576656E744F';
wwv_flow_imp.g_varchar2_table(43) := '626A2E7265636F72644964203D206E756C6C3B0D0A202020202020202020202020202020202020202020202020696620286576656E744F626A2E7265636F7264290D0A2020202020202020202020202020202020202020202020207B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(44) := '202020202020202020202020202020202020202020206576656E744F626A2E7265636F72644964203D206576656E744F626A2E6D6F64656C2E6765745265636F72644964286576656E744F626A2E7265636F7264293B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(45) := '2020202020202020202020207D0D0A2020202020202020202020202020202020202020202020206576656E744F626A2E616374696F6E73203D20746869732E656C656D656E742E7265636F7264566965772827676574416374696F6E7327293B0D0A2020';
wwv_flow_imp.g_varchar2_table(46) := '20202020202020202020202020202020202020202020617065782E6576656E742E7472696767657228746869732E656C656D656E742C20276C696234785F69675F72765F7570646174655F616374696F6E73272C206576656E744F626A293B0D0A202020';
wwv_flow_imp.g_varchar2_table(47) := '20202020202020202020202020202020207D0D0A202020202020202020202020202020202020202072657475726E20726573756C743B0D0A202020202020202020202020202020207D2C0D0A202020202020202020202020202020202F2F2075706F6E20';
wwv_flow_imp.g_varchar2_table(48) := '726566726573682C206D616B65206C61796F75742061646A7573746D656E7473206173207065722074686520706C7567696E206F7074696F6E730D0A20202020202020202020202020202020726566726573683A2066756E6374696F6E2870466F637573';
wwv_flow_imp.g_varchar2_table(49) := '29207B0D0A20202020202020202020202020202020202020206C657420726573756C74203D20746869732E5F737570657228293B0D0A202020202020202020202020202020202020202069662028746869732E656C656D656E742E636C6F736573742827';
wwv_flow_imp.g_varchar2_table(50) := '2E27202B2020435F4C494234585F53415256292E6C656E677468290D0A20202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202061646A7573745276426F647928746869732E656C656D656E';
wwv_flow_imp.g_varchar2_table(51) := '74293B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202072657475726E20726573756C743B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D293B2020';
wwv_flow_imp.g_varchar2_table(52) := '202020202020200D0A20202020202020207D0D0A0D0A202020202020202069662028242E617065782E7265636F726456696577290D0A20202020202020207B0D0A2020202020202020202020202F2F206966206C6F6164656420616C72656164792C2065';
wwv_flow_imp.g_varchar2_table(53) := '7874656E64206E6F772C20656C736520617761697420746865206C6F6164206576656E740D0A202020202020202020202020657874656E645265636F72645669657757696467657428293B0D0A20202020202020207D2020200D0A0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(54) := '2076617220626F6479456C656D203D20646F63756D656E742E676574456C656D656E747342795461674E616D652822626F647922295B305D3B0D0A2020202020202020626F6479456C656D2E6164644576656E744C697374656E657228226C6F6164222C';
wwv_flow_imp.g_varchar2_table(55) := '2066756E6374696F6E286576656E7429207B0D0A202020202020202020202020696620286576656E742E7461726765742E6E6F64654E616D65203D3D3D202253435249505422290D0A2020202020202020202020207B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(56) := '202020206C65742073726341747472203D206576656E742E7461726765742E676574417474726962757465282273726322293B0D0A202020202020202020202020202020202F2F207265636F726456696577207375627769646765740D0A202020202020';
wwv_flow_imp.g_varchar2_table(57) := '20202020202020202020696620287372634174747220262620737263417474722E696E636C7564657328277769646765742E7265636F7264566965772729290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(58) := '20202020657874656E645265636F72645669657757696467657428293B0D0A202020202020202020202020202020207D20202020202020202020202020202020200D0A2020202020202020202020207D0D0A20202020202020207D2C2074727565293B20';
wwv_flow_imp.g_varchar2_table(59) := '20202F2F207573656361707475726520697320637269746963616C2068657265202020200D0A0D0A20202020202020202F2F2077696C6C206D656E74696F6E20696E2074686520746F6F6C62617220696E2063617365207468652063757272656E742072';
wwv_flow_imp.g_varchar2_table(60) := '6F7720776173206164646564206F722075706461746564206F722064656C657465640D0A202020202020202066756E6374696F6E20757064617465546F6F6C6261725265636F726453746174652873696E676C65526F775669657724290D0A2020202020';
wwv_flow_imp.g_varchar2_table(61) := '2020207B0D0A2020202020202020202020206C6574206D6F64656C203D2073696E676C65526F7756696577242E7265636F72645669657728276765744D6F64656C27293B0D0A2020202020202020202020206C6574207265636F7264203D2073696E676C';
wwv_flow_imp.g_varchar2_table(62) := '65526F7756696577242E7265636F72645669657728276765745265636F726427293B0D0A2020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(63) := '2020206C6574206D657461203D206D6F64656C2E6765745265636F72644D65746164617461287265636F72644964293B0D0A2020202020202020202020206C657420737461747573203D2022223B0D0A20202020202020202020202069662028206D6574';
wwv_flow_imp.g_varchar2_table(64) := '612E64656C657465642029207B0D0A20202020202020202020202020202020737461747573203D20617065782E6C616E672E6765744D657373616765282022415045582E47562E524F575F44454C455445442220293B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(65) := '7D20656C73652069662028206D6574612E696E7365727465642029207B0D0A20202020202020202020202020202020737461747573203D20617065782E6C616E672E6765744D657373616765282022415045582E47562E524F575F41444445442220293B';
wwv_flow_imp.g_varchar2_table(66) := '0D0A2020202020202020202020207D20656C73652069662028206D6574612E757064617465642029207B0D0A20202020202020202020202020202020737461747573203D20617065782E6C616E672E6765744D657373616765282022415045582E47562E';
wwv_flow_imp.g_varchar2_table(67) := '524F575F4348414E4745442220293B0D0A2020202020202020202020207D20200D0A2020202020202020202020206C65742069675374617469634964203D206D6F64656C2E6765744F7074696F6E2827726567696F6E537461746963496427293B0D0A20';
wwv_flow_imp.g_varchar2_table(68) := '20202020202020202020206C657420746F6F6C62617224203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574546F6F6C62617227293B0D0A20202020202020202020202069662028746F6F6C626172242026262074';
wwv_flow_imp.g_varchar2_table(69) := '6F6F6C626172242E6C656E677468290D0A2020202020202020202020207B0D0A20202020202020202020202020202020746F6F6C626172242E746F6F6C62617228202266696E64456C656D656E74222C20227374617475732220292E7465787428207374';
wwv_flow_imp.g_varchar2_table(70) := '6174757320293B2020200D0A2020202020202020202020207D202020202020202020200D0A20202020202020207D0D0A0D0A20202020202020202F2F20636F6E76657274732074686520727620626F647920696E746F206120666C657820636F6C756D6E';
wwv_flow_imp.g_varchar2_table(71) := '206C61796F75742061732070657220746865206669656C642067726F75707320646566696E6974696F6E730D0A202020202020202066756E6374696F6E206170706C794669656C6447726F7570436F6C756D6E732873696E676C65526F77566965772429';
wwv_flow_imp.g_varchar2_table(72) := '0D0A20202020202020207B0D0A2020202020202020202020206C6574207276426F647924203D2073696E676C65526F7756696577242E66696E642827202E27202B20435F52565F424F4459293B0D0A202020202020202020202020696620287276426F64';
wwv_flow_imp.g_varchar2_table(73) := '79242E66696E642827202E27202B20435F434F4C4C41505349424C45292E6C656E677468290D0A2020202020202020202020207B0D0A202020202020202020202020202020207276426F6479242E66696E642827202E27202B20435F434F4C4C41505349';
wwv_flow_imp.g_varchar2_table(74) := '424C45292E6869646528293B0D0A202020202020202020202020202020207276426F6479242E616464436C61737328435F464C4558293B0D0A202020202020202020202020202020207276426F6479242E66696E642827202E272B20435F434F4C4C4150';
wwv_flow_imp.g_varchar2_table(75) := '5349424C455F434F4E54454E54292E656163682866756E6374696F6E28297B242874686973292E616464436C61737328435F464C45585F47524F575F31297D293B2020202020200D0A2020202020202020202020207D2020202020202020200D0A202020';
wwv_flow_imp.g_varchar2_table(76) := '20202020207D0D0A0D0A202020202020202066756E6374696F6E206170706C794669656C64436F6C756D6E735370616E2873696E676C65526F7756696577242C207370616E5769647468290D0A20202020202020207B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(77) := '6C6574206669656C6473203D2073696E676C65526F7756696577242E7265636F72645669657728276F7074696F6E272C20276669656C647327293B0D0A202020202020202020202020696620286669656C6473202626206669656C64732E6C656E677468';
wwv_flow_imp.g_varchar2_table(78) := '29202020202F2F20697320616E206172726179206F66206F6E65206F626A656374207769746820616C6C206669656C64730D0A2020202020202020202020207B0D0A20202020202020202020202020202020666F722028636F6E7374205B70726F706572';
wwv_flow_imp.g_varchar2_table(79) := '74792C206669656C645D206F66204F626A6563742E656E7472696573286669656C64735B305D292E66696C74657228285B6B65792C2076616C5D293D3E2876616C2E656C656D656E7449642929290D0A202020202020202020202020202020207B0D0A20';
wwv_flow_imp.g_varchar2_table(80) := '202020202020202020202020202020202020206669656C642E6669656C64436F6C5370616E203D207370616E57696474683B0D0A202020202020202020202020202020207D0D0A2020202020202020202020202020202073696E676C65526F7756696577';
wwv_flow_imp.g_varchar2_table(81) := '242E7265636F7264566965772827726566726573684669656C647327293B0D0A2020202020202020202020202020202073696E676C65526F7756696577242E7265636F72645669657728277265667265736827293B0D0A2020202020202020202020207D';
wwv_flow_imp.g_varchar2_table(82) := '0D0A20202020202020207D0D0A0D0A20202020202020202F2F2061646A7573742074686520727620626F6479206173207065722074686520706C7567696E206F7074696F6E730D0A202020202020202066756E6374696F6E2061646A7573745276426F64';
wwv_flow_imp.g_varchar2_table(83) := '792873696E676C65526F775669657724290D0A20202020202020207B0D0A2020202020202020202020206C6574207772705374617469634964203D2073696E676C65526F7756696577242E636C6F7365737428272E27202B20435F4C494234585F534152';
wwv_flow_imp.g_varchar2_table(84) := '56292E617474722827696427293B0D0A2020202020202020202020206C6574206F7074696F6E73203D20736172764F7074696F6E735B77727053746174696349645D3B0D0A2020202020202020202020202F2F20576974682067726F7570206865616469';
wwv_flow_imp.g_varchar2_table(85) := '6E6720627574746F6E732C2061207265636F72645669657720666F63757320726573756C747320696E206120666F637573206F6E2074686520627574746F6E20696E7374656164206F66207468650D0A2020202020202020202020202F2F206669727374';
wwv_flow_imp.g_varchar2_table(86) := '20696E707574206669656C642E20546F2070726576656E742C207765207365742074686520627574746F6E7320746162696E64657820746F20272D31272E2020202020202020202020202020200D0A202020202020202020202020696620286F7074696F';
wwv_flow_imp.g_varchar2_table(87) := '6E732E636F6C756D6E734C61796F7574203D3D20274649454C445F47524F55505F434F4C554D4E5327292020202020202020202020200D0A2020202020202020202020207B0D0A202020202020202020202020202020206170706C794669656C6447726F';
wwv_flow_imp.g_varchar2_table(88) := '7570436F6C756D6E732873696E676C65526F775669657724293B0D0A2020202020202020202020207D0D0A2020202020202020202020206D616B6547726F757048656164696E67734E6F6E5461626261626C652873696E676C65526F775669657724293B';
wwv_flow_imp.g_varchar2_table(89) := '0D0A20202020202020207D0D0A0D0A202020202020202066756E6374696F6E206D616B6547726F757048656164696E67734E6F6E5461626261626C652873696E676C65526F775669657724290D0A20202020202020207B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(90) := '2073696E676C65526F7756696577242E66696E642827202E27202B20435F52565F424F4459202B2027202E27202B20435F464F524D5F47524F55505F48454144494E47202B202720627574746F6E27292E656163682866756E6374696F6E28297B242874';
wwv_flow_imp.g_varchar2_table(91) := '686973292E617474722827746162696E646578272C20272D3127297D293B200D0A20202020202020207D0D0A0D0A20202020202020202F2F2067726F7570206869646520666561747572650D0A202020202020202066756E6374696F6E20686964654772';
wwv_flow_imp.g_varchar2_table(92) := '6F757028727653746174696349642C206669656C645374617469634964290D0A20202020202020207B0D0A2020202020202020202020206C6574206669656C64436F6E7461696E657224203D202428272327202B2072765374617469634964202B202720';
wwv_flow_imp.g_varchar2_table(93) := '2E27202B20435F52565F424F4459202B2027202327202B206669656C645374617469634964202B20275F434F4E5441494E455227293B0D0A2020202020202020202020206669656C64436F6E7461696E6572242E636C6F7365737428272E27202B20435F';
wwv_flow_imp.g_varchar2_table(94) := '464F524D5F47524F55505F48454144494E47292E6869646528293B0D0A2020202020202020202020206669656C64436F6E7461696E6572242E706172656E7428292E70726576416C6C28272E752D466F726D2D67726F757048656164696E6727292E6669';
wwv_flow_imp.g_varchar2_table(95) := '72737428292E6869646528293B0D0A2020202020202020202020206669656C64436F6E7461696E6572242E636C6F7365737428272E27202B20435F464F524D292E6869646528293B0D0A20202020202020207D0D0A0D0A20202020202020202F2F206772';
wwv_flow_imp.g_varchar2_table(96) := '6F75702073686F7720666561747572650D0A202020202020202066756E6374696F6E2073686F7747726F757028727653746174696349642C206669656C645374617469634964290D0A20202020202020207B0D0A2020202020202020202020206C657420';
wwv_flow_imp.g_varchar2_table(97) := '6669656C64436F6E7461696E657224203D202428272327202B2072765374617469634964202B2027202E27202B20435F52565F424F4459202B2027202327202B206669656C645374617469634964202B20275F434F4E5441494E455227293B0D0A202020';
wwv_flow_imp.g_varchar2_table(98) := '2020202020202020206669656C64436F6E7461696E6572242E636C6F7365737428272E27202B20435F464F524D5F47524F55505F48454144494E47292E73686F7728293B0D0A2020202020202020202020206669656C64436F6E7461696E6572242E7061';
wwv_flow_imp.g_varchar2_table(99) := '72656E7428292E70726576416C6C28272E752D466F726D2D67726F757048656164696E6727292E666972737428292E73686F7728293B0D0A2020202020202020202020206669656C64436F6E7461696E6572242E636C6F7365737428272E27202B20435F';
wwv_flow_imp.g_varchar2_table(100) := '464F524D292E73686F7728293B0D0A20202020202020207D20202020202020200D0A0D0A20202020202020202F2F2061646A75737420746865207276206173207065722074686520706C7567696E206F7074696F6E730D0A20202020202020206C657420';
wwv_flow_imp.g_varchar2_table(101) := '61646A7573745256203D2066756E6374696F6E28696753746174696349642C2073696E676C65526F775669657724290D0A20202020202020207B0D0A2020202020202020202020206C6574207772705374617469634964203D2073696E676C65526F7756';
wwv_flow_imp.g_varchar2_table(102) := '696577242E636C6F7365737428272E27202B20435F4C494234585F53415256292E617474722827696427293B0D0A2020202020202020202020206C6574206F7074696F6E73203D20736172764F7074696F6E735B77727053746174696349645D3B202020';
wwv_flow_imp.g_varchar2_table(103) := '2020202020202020200D0A2020202020202020202020206966202873696E676C65526F7756696577242E697328273A76697369626C652729290D0A2020202020202020202020207B0D0A20202020202020202020202020202020696620286F7074696F6E';
wwv_flow_imp.g_varchar2_table(104) := '732E636F6C756D6E734C61796F7574203D3D20274649454C445F434F4C554D4E535F5350414E27290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206170706C794669656C64436F6C756D6E735370';
wwv_flow_imp.g_varchar2_table(105) := '616E2873696E676C65526F7756696577242C206F7074696F6E732E6663735F7370616E5769647468290D0A20202020202020202020202020202020202020202F2F2077696C6C206C65616420746F20612072656672657368202B2061646A757374527642';
wwv_flow_imp.g_varchar2_table(106) := '6F64790D0A202020202020202020202020202020207D0D0A20202020202020202020202020202020656C73650D0A202020202020202020202020202020207B0D0A202020202020202020202020202020202020202061646A7573745276426F6479287369';
wwv_flow_imp.g_varchar2_table(107) := '6E676C65526F775669657724293B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D0A20202020202020202020202073696E676C65526F7756696577242E7265636F72645669657728276F7074696F6E272C202774';
wwv_flow_imp.g_varchar2_table(108) := '6F6F6C626172272C206E756C6C293B0D0A20202020202020202020202073696E676C65526F7756696577242E6F6E28277265636F7264766965777265636F72646368616E6765272C2066756E6374696F6E28206576656E742C20646174612029207B0D0A';
wwv_flow_imp.g_varchar2_table(109) := '202020202020202020202020202020206C657420746F6F6C62617224203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574546F6F6C62617227293B0D0A2020202020202020202020202020202069662028746F6F6C';
wwv_flow_imp.g_varchar2_table(110) := '6261722420262620746F6F6C626172242E6C656E677468290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206C6574206D6F64656C203D2073696E676C65526F7756696577242E7265636F72645669';
wwv_flow_imp.g_varchar2_table(111) := '657728276765744D6F64656C27293B0D0A20202020202020202020202020202020202020202F2F207265636F72646E756D6265720D0A20202020202020202020202020202020202020206C6574207265636F72644F6666736574203D2073696E676C6552';
wwv_flow_imp.g_varchar2_table(112) := '6F7756696577242E7265636F72645669657728276F7074696F6E272C20277265636F72644F666673657427293B0D0A20202020202020202020202020202020202020206C657420746F74616C203D206D6F64656C2E676574546F74616C5265636F726473';
wwv_flow_imp.g_varchar2_table(113) := '28293B0D0A20202020202020202020202020202020202020206C65742074657874203D2027273B0D0A20202020202020202020202020202020202020206966202820746F74616C203E20302029200D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(114) := '7B0D0A2020202020202020202020202020202020202020202020202F2F74657874203D20617065782E6C616E672E666F726D61744D657373616765282022415045582E52562E5245435F5859222C207265636F72644F6666736574202B20312C20746F74';
wwv_flow_imp.g_varchar2_table(115) := '616C20293B0D0A20202020202020202020202020202020202020202020202074657874203D20287265636F72644F666673657429202B2031202B20222F22202B20746F74616C3B0D0A20202020202020202020202020202020202020207D200D0A202020';
wwv_flow_imp.g_varchar2_table(116) := '2020202020202020202020202020202020656C7365200D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202F2F74657874203D20617065782E6C616E672E666F726D61744D657373';
wwv_flow_imp.g_varchar2_table(117) := '616765282022415045582E52562E5245435F58222C206F2E7265636F72644F6666736574202B203120293B0D0A20202020202020202020202020202020202020202020202074657874203D20287265636F72644F666673657429202B20313B0D0A202020';
wwv_flow_imp.g_varchar2_table(118) := '20202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020746F6F6C626172242E746F6F6C626172282766696E64456C656D656E74272C20277265636F72644E756D62657227292E746578742874657874293B20';
wwv_flow_imp.g_varchar2_table(119) := '202020202020202020202020202020200D0A202020202020202020202020202020207D0D0A2020202020202020202020207D293B0D0A20202020202020207D200D0A20202020202020200D0A20202020202020202F2F20726F775669657720696E697420';
wwv_flow_imp.g_varchar2_table(120) := '66756E6374696F6E0D0A20202020202020206C657420696E6974203D2066756E6374696F6E287772705374617469634964290D0A20202020202020207B0D0A2020202020202020202020202F2F2073756273637269626520746F206D6F64656C206E6F74';
wwv_flow_imp.g_varchar2_table(121) := '696669636174696F6E73206F6620746865207772617070656420494720286576656E7420627562626C696E67290D0A2020202020202020202020202428272327202B207772705374617469634964292E6F6E2827696E7465726163746976656772696476';
wwv_flow_imp.g_varchar2_table(122) := '6965776D6F64656C637265617465272C2066756E6374696F6E286A51756572794576656E742C2064617461297B0D0A202020202020202020202020202020206C6574206D6F64656C203D20646174612E6D6F64656C3B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(123) := '202020206D6F64656C2E737562736372696265287B0D0A20202020202020202020202020202020202020206F6E4368616E67653A2066756E6374696F6E286368616E6765547970652C206368616E676529207B0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(124) := '20202020202020202069662028286368616E676554797065203D3D2027696E736572742729207C7C20286368616E676554797065203D3D20277265766572742729290D0A2020202020202020202020202020202020202020202020207B0D0A2020202020';
wwv_flow_imp.g_varchar2_table(125) := '20202020202020202020202020202020202020202020202F2F20636865636B20696620746865206D6F64656C2068617320612054454D505F3C6964656E746974794669656C643E206669656C640D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(126) := '202020202020202F2F20696620736F2C20706F70756C6174652077697468207468652074656D7020696420286E6F726D616C6C7920277431303030272C20277431303031272C20657463290D0A2020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(127) := '20202020202F2F20746869732074656D702069642063616E2062652075736564207365727665722D7369646520666F722073696E676C652D7472616E73616374696F6E20737570706F72740D0A2020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(128) := '20202020206C6574206964656E746974794669656C64203D206D6F64656C2E6765744F7074696F6E28276964656E746974794669656C6427293B0D0A20202020202020202020202020202020202020202020202020202020696620286964656E74697479';
wwv_flow_imp.g_varchar2_table(129) := '4669656C642E6C656E677468290D0A202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020206C65742074656D7049644669656C64203D202754454D';
wwv_flow_imp.g_varchar2_table(130) := '505F27202B206964656E746974794669656C645B305D3B0D0A2020202020202020202020202020202020202020202020202020202020202020696620286D6F64656C2E6765744F7074696F6E28276669656C647327292E6861734F776E50726F70657274';
wwv_flow_imp.g_varchar2_table(131) := '792874656D7049644669656C6429290D0A20202020202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020206C6574207265636F72647320';
wwv_flow_imp.g_varchar2_table(132) := '3D206368616E67652E7265636F726473207C7C205B6368616E67652E7265636F72645D3B0D0A202020202020202020202020202020202020202020202020202020202020202020202020666F7220286C6574207265636F7264206F66207265636F726473';
wwv_flow_imp.g_varchar2_table(133) := '290D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020696620286D6F64656C2E6765745265636F72';
wwv_flow_imp.g_varchar2_table(134) := '644D65746164617461286D6F64656C2E6765745265636F72644964287265636F726429292E696E736572746564290D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(135) := '20202020202020202020202020202020202020202020202020202020202020202020206C65742074656D704964203D206D6F64656C2E67657456616C7565287265636F72642C206964656E746974794669656C645B305D293B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(136) := '20202020202020202020202020202020202020202020202020202020202020202020206D6F64656C2E73657456616C7565287265636F72642C2074656D7049644669656C642C2074656D704964293B0D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(137) := '2020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A2020';
wwv_flow_imp.g_varchar2_table(138) := '20202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D20200D0A202020202020202020202020202020202020202020202020696620286368616E676554797065203D3D20';
wwv_flow_imp.g_varchar2_table(139) := '276D6574614368616E676527290D0A2020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202F2F2042656361757365206F6620616E2041504558206275672C20696E63';
wwv_flow_imp.g_varchar2_table(140) := '6F72726563746C7920612076616C69646174696F6E206572726F72206D6573736167652069732073686F776E20666F722061207265717569726564206669656C64202877686963682068617320612076616C756520616E79776179290D0A202020202020';
wwv_flow_imp.g_varchar2_table(141) := '202020202020202020202020202020202020202020202F2F20696E2074686520736974756174696F6E20776865726520796F752073746172742065646974206D6F646520616E6420746865207265636F7264206973206E6F7420616C6C6F77656420746F';
wwv_flow_imp.g_varchar2_table(142) := '206265206564697465642E205468656E2C207768656E20796F7520706167696E61746520746F207468650D0A202020202020202020202020202020202020202020202020202020202F2F206E657874207265636F72642C207468652076616C6964617469';
wwv_flow_imp.g_varchar2_table(143) := '6F6E206572726F722069732073686F776E206F6E20746865206669656C642E0D0A202020202020202020202020202020202020202020202020202020202F2F20546F20776F726B6172726F756E6420746869732C20776520636174636820746865207265';
wwv_flow_imp.g_varchar2_table(144) := '6C61746564206D6F64656C206E6F74696669636174696F6E2028276D6574614368616E67652720697320276D6573736167652C6572726F72272920616E6420696620746865207265636F7264200D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(145) := '202020202020202F2F206973206E6F7420616C6C6F77656420746F206265206564697465642C20776520636C65617220746865206572726F722E0D0A20202020202020202020202020202020202020202020202020202020696620286368616E67652E72';
wwv_flow_imp.g_varchar2_table(146) := '65636F72644964202626206368616E67652E70726F7065727479202626206368616E67652E70726F70657274792E696E636C7564657328276D6573736167652729202626206368616E67652E70726F70657274792E696E636C7564657328276572726F72';
wwv_flow_imp.g_varchar2_table(147) := '2729290D0A202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020206C6574207265634D65746164617461203D206D6F64656C2E6765745265636F72';
wwv_flow_imp.g_varchar2_table(148) := '644D65746164617461286368616E67652E7265636F72644964293B0D0A202020202020202020202020202020202020202020202020202020202020202069662028216D6F64656C2E616C6C6F7745646974286368616E67652E7265636F72642920262620';
wwv_flow_imp.g_varchar2_table(149) := '216D6F64656C734D6F64756C652E7574696C2E7265636F72644669656C647356616C6964287265634D6574616461746129290D0A20202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(150) := '20202020202020202020202020202020202020202020206D6F64656C734D6F64756C652E7574696C2E7365745265636F72644669656C647356616C6964286D6F64656C2C206368616E67652E7265636F7264293B0D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(151) := '2020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020656C73650D0A20202020202020202020202020202020202020202020202020202020202020207B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(152) := '2020202020202020202020202020202020202020202020202020202020202F2F20696E2063617365206F66206D616E6461746F7279206669656C642076616C69646174696F6E206572726F7220636175736564206279206F70656E696E67206120666965';
wwv_flow_imp.g_varchar2_table(153) := '6C64206469616C6F672C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202F2F2072656D6F7665207468652076616C69646174696F6E206D6573736167650D0A202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(154) := '20202020202020202020202020202020202069662028617065782E7574696C2E676574546F704170657828292E6A517565727928272E75692D6469616C6F672D706F7075706C6F762C202E75692D6469616C6F672D646174657069636B657227292E6973';
wwv_flow_imp.g_varchar2_table(155) := '28273A76697369626C652729290D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206D6F64656C2E';
wwv_flow_imp.g_varchar2_table(156) := '73657456616C6964697479282776616C6964272C206368616E67652E7265636F726449642C206368616E67652E6669656C64293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D202020202020202020';
wwv_flow_imp.g_varchar2_table(157) := '2020202020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020';
wwv_flow_imp.g_varchar2_table(158) := '202020202020202020202020202020202020207D20202020202020202020200D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D293B20202020200D0A2020202020202020202020207D293B0D0A20';
wwv_flow_imp.g_varchar2_table(159) := '20202020202020202020202428617065782E6750616765436F6E7465787424292E6F6E2822617065787265616479656E64222C2066756E6374696F6E286A51756572794576656E7429207B0D0A202020202020202020202020202020206C657420696724';
wwv_flow_imp.g_varchar2_table(160) := '203D202428272327202B207772705374617469634964202B2027202E612D494727292E666972737428293B0D0A20202020202020202020202020202020696620286967242E6C656E677468290D0A202020202020202020202020202020207B0D0A202020';
wwv_flow_imp.g_varchar2_table(161) := '20202020202020202020202020202020206C65742069675374617469634964203D206967242E696E7465726163746976654772696428276F7074696F6E27292E636F6E6669672E726567696F6E53746174696349643B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(162) := '20202020202020206C65742073696E676C65526F775669657724203D206967242E696E746572616374697665477269642827676574566965777327292E677269642E73696E676C65526F7756696577243B0D0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(163) := '20202061646A757374525628696753746174696349642C2073696E676C65526F775669657724293B0D0A0D0A20202020202020202020202020202020202020202F2F20546865726520697320612062756720696E207265636F7264566965772077696467';
wwv_flow_imp.g_varchar2_table(164) := '657420696E2077686963682075706F6E20696E736572742C207265636F7264566965772E666F63757328292069730D0A20202020202020202020202020202020202020202F2F206578656375746564207477696365206F6E207468652066697273742066';
wwv_flow_imp.g_varchar2_table(165) := '69656C642E2046726F6D20746869732C2069662074686973206669656C64206973206D616E6461746F72792C200D0A20202020202020202020202020202020202020202F2F20696D6D65646961746C7920612076616C69646174696F6E206D6573736167';
wwv_flow_imp.g_varchar2_table(166) := '652069732073686F776E20756E64657220746865206669656C642E204974206F6E6C792068617070656E730D0A20202020202020202020202020202020202020202F2F207768656E2074686520776964676574206973206E6F7420696E2065646974206D';
wwv_flow_imp.g_varchar2_table(167) := '6F6465207965742E20416C736F2C2074686520697373756520776F6E27742068617070656E207768656E0D0A20202020202020202020202020202020202020202F2F2074686520666972737420636F6E74726F6C206973206120636F6C6C61707369626C';
wwv_flow_imp.g_varchar2_table(168) := '6520627574746F6E20617320697420707574732028696E636F72726563746C79292074686520666F6375730D0A20202020202020202020202020202020202020202F2F206F6E207468617420627574746F6E2E0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(169) := '20202020202F2F20536F2062656C6F7720776520636F7272656374207468697320627920726576657274696E67207468652076616C696469747920746F202776616C6964272E0D0A20202020202020202020202020202020202020206C657420696E7365';
wwv_flow_imp.g_varchar2_table(170) := '7274416374696F6E203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574416374696F6E7327292E6C6F6F6B75702827696E736572742D7265636F726427293B0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(171) := '69662028696E73657274416374696F6E290D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020696E73657274416374696F6E2E616374696F6E203D2066756E6374696F6E2829207B';
wwv_flow_imp.g_varchar2_table(172) := '0D0A202020202020202020202020202020202020202020202020202020202F2F20637573746F6D2027696E736572742D7265636F72642720616374696F6E20617320746F20696E7365727420616C776179730D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(173) := '2020202020202020202020202F2F20617420746865207665727920626567696E6E696E670D0A202020202020202020202020202020202020202020202020202020202F2F20726567756C6172206265686176696F72206F662027696E736572742D726563';
wwv_flow_imp.g_varchar2_table(174) := '6F72642720697320746F20696E73657274206166746572207468652063757272656E7420726F770D0A202020202020202020202020202020202020202020202020202020202F2F20686F77657665722062656361757365206F6620612062756720696E20';
wwv_flow_imp.g_varchar2_table(175) := '415045582C207468697320676976657320697373756573207768656E0D0A202020202020202020202020202020202020202020202020202020202F2F20616464696E6720616674657220746865206C61737420726F770D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(176) := '202020202020202020202020202020206C65742073696E676C65526F775669657724203D20617065782E726567696F6E2869675374617469634964292E77696467657428292E696E746572616374697665477269642827676574566965777327292E6772';
wwv_flow_imp.g_varchar2_table(177) := '69642E73696E676C65526F7756696577243B0D0A20202020202020202020202020202020202020202020202020202020696620282073696E676C65526F7756696577242E7265636F72645669657728276F7074696F6E272C20276564697461626C652729';
wwv_flow_imp.g_varchar2_table(178) := '2029207B0D0A20202020202020202020202020202020202020202020202020202020202020206C6574206D6F64656C203D2073696E676C65526F7756696577242E7265636F72645669657728276765744D6F64656C27293B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(179) := '202020202020202020202020202020202020202020206C657420616374696F6E73203D2073696E676C65526F7756696577242E7265636F7264566965772827676574416374696F6E7327293B0D0A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(180) := '202020202020202020206D6F64656C2E696E736572744E65775265636F726428293B0D0A2020202020202020202020202020202020202020202020202020202020202020616374696F6E732E696E766F6B6528204143545F464952535420293B0D0A2020';
wwv_flow_imp.g_varchar2_table(181) := '20202020202020202020202020202020202020202020202020202020202073696E676C65526F7756696577242E7265636F7264566965772827666F63757327293B20202020202020202020202020202020202020202020202020202020200D0A20202020';
wwv_flow_imp.g_varchar2_table(182) := '2020202020202020202020202020202020202020202020202020202069662028202173696E676C65526F7756696577242E7265636F7264566965772827696E456469744D6F646527202929207B0D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(183) := '20202020202020202020202020202073696E676C65526F7756696577242E7265636F7264566965772827736574456469744D6F6465272C2074727565293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A20';
wwv_flow_imp.g_varchar2_table(184) := '2020202020202020202020202020202020202020202020202020202020202072657475726E20747275653B202F2F20666F6375732073686F756C642068617665206265656E2073657420746F206669727374206669656C640D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(185) := '2020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D20202020202020202020202020202020202020200D0A20202020202020202020202020202020202020207D0D0A0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(186) := '202020202020202020202020202F2F20546865726520697320612062756720696E204150455820696E202075706F6E207265766572742C20616E792076616C69646174696F6E206D6573736167657320617265206E6F7420636C65617265642C0D0A2020';
wwv_flow_imp.g_varchar2_table(187) := '2020202020202020202020202020202020202F2F2063617573696E6720616E79207361766520616374696F6E20746F20706F707570207468652027436F7272656374206572726F7273206265666F726520736176696E6727206D6573736167652E0D0A20';
wwv_flow_imp.g_varchar2_table(188) := '202020202020202020202020202020202020202F2F20536F2062656C6F7720776520636F7272656374207468697320627920636C656172696E67207468652076616C69646174696F6E206572726F7273206166746572207265766572740D0A2020202020';
wwv_flow_imp.g_varchar2_table(189) := '2020202020202020202020202020206C657420726576657274416374696F6E203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574416374696F6E7327292E6C6F6F6B757028277265766572742D7265636F72642729';
wwv_flow_imp.g_varchar2_table(190) := '3B0D0A202020202020202020202020202020202020202069662028726576657274416374696F6E290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206C6574206F726967416374';
wwv_flow_imp.g_varchar2_table(191) := '696F6E203D20726576657274416374696F6E2E616374696F6E3B0D0A202020202020202020202020202020202020202020202020726576657274416374696F6E2E616374696F6E203D2066756E6374696F6E2829207B202020200D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(192) := '20202020202020202020202020202020202020206F726967416374696F6E28293B0D0A202020202020202020202020202020202020202020202020202020206C6574206D6F64656C203D2073696E676C65526F7756696577242E7265636F726456696577';
wwv_flow_imp.g_varchar2_table(193) := '28276765744D6F64656C27293B0D0A202020202020202020202020202020202020202020202020202020206C6574207265636F7264203D2073696E676C65526F7756696577242E7265636F72645669657728276765745265636F726427293B0D0A202020';
wwv_flow_imp.g_varchar2_table(194) := '202020202020202020202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0D0A202020202020202020202020202020202020202020202020202020206C657420';
wwv_flow_imp.g_varchar2_table(195) := '7265634D65746164617461203D206D6F64656C2E6765745265636F72644D65746164617461287265636F72644964293B0D0A2020202020202020202020202020202020202020202020202020202069662028216D6F64656C734D6F64756C652E7574696C';
wwv_flow_imp.g_varchar2_table(196) := '2E7265636F72644669656C647356616C6964287265634D6574616461746129290D0A202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020206D6F64';
wwv_flow_imp.g_varchar2_table(197) := '656C734D6F64756C652E7574696C2E7365745265636F72644669656C647356616C6964286D6F64656C2C207265636F7264293B0D0A202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(198) := '20202020202020207D3B0D0A20202020202020202020202020202020202020207D3B20202020202020202020200D0A20202020202020202020202020202020202020200D0A20202020202020202020202020202020202020202F2F20616E6F7468657220';
wwv_flow_imp.g_varchar2_table(199) := '776F726B61726F756E6420666F7220616E2041504558206275670D0A20202020202020202020202020202020202020202F2F2075706F6E20736176652C20616E79207365727665722D736964652076616C69646174696F6E732077686963682072657375';
wwv_flow_imp.g_varchar2_table(200) := '6C7420696E2061206669656C64206572726F722C0D0A20202020202020202020202020202020202020202F2F20746865206572726F72206973206E6F742073686F776E206F6E20746865206669656C6420286F6E6C79206F6E2070616765206C6576656C';
wwv_flow_imp.g_varchar2_table(201) := '2061732061206E6F74696669636174696F6E290D0A20202020202020202020202020202020202020202F2F20746865206572726F722069732074686572652074686F756768206F6E20746865206669656C64206D6574616461746120696E20746865206D';
wwv_flow_imp.g_varchar2_table(202) := '6F64656C0D0A20202020202020202020202020202020202020202F2F20746F20776F726B206172726F756E642C2077652072656672657368207468652053525620616674657220736176650D0A2020202020202020202020202020202020202020242822';
wwv_flow_imp.g_varchar2_table(203) := '2322202B2069675374617469634964292E6F6E2822696E7465726163746976656772696473617665222C2066756E6374696F6E28206576656E742C20646174612029207B0D0A2020202020202020202020202020202020202020202020206C6574206D6F';
wwv_flow_imp.g_varchar2_table(204) := '64656C203D2073696E676C65526F7756696577242E7265636F72645669657728276765744D6F64656C27293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F7264203D2073696E676C65526F7756696577242E7265';
wwv_flow_imp.g_varchar2_table(205) := '636F72645669657728276765745265636F726427293B0D0A2020202020202020202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F72644964287265636F7264293B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(206) := '20202020202020202020202020202069662028216D6F64656C734D6F64756C652E7574696C2E7265636F7264497356616C6964286D6F64656C2C207265636F7264496429290D0A2020202020202020202020202020202020202020202020207B0D0A2020';
wwv_flow_imp.g_varchar2_table(207) := '202020202020202020202020202020202020202020202020202073696E676C65526F7756696577242E7265636F72645669657728277265667265736827293B0D0A2020202020202020202020202020202020202020202020207D0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(208) := '2020202020202020202020207D293B202020202020202020202020202020200D0A202020202020202020202020202020207D0D0A2020202020202020202020207D293B0D0A20202020202020207D0D0A0D0A202020202020202072657475726E7B0D0A20';
wwv_flow_imp.g_varchar2_table(209) := '2020202020202020202020696E69743A20696E69742C0D0A20202020202020202020202061646A75737452563A2061646A75737452562C0D0A2020202020202020202020206869646547726F75703A206869646547726F75702C0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(210) := '2020202073686F7747726F75703A2073686F7747726F75700D0A20202020202020207D0D0A202020207D2928293B20202020202020200D0A202020200D0A202020202F2F206D6F64656C207574696C2066756E6374696F6E730D0A202020206C6574206D';
wwv_flow_imp.g_varchar2_table(211) := '6F64656C734D6F64756C65203D202866756E6374696F6E2829207B0D0A20202020202020206C6574206D6F64656C5574696C203D207B0D0A2020202020202020202020207265636F72644669656C647356616C69643A2066756E6374696F6E287265634D';
wwv_flow_imp.g_varchar2_table(212) := '65746164617461290D0A2020202020202020202020207B0D0A202020202020202020202020202020206C65742076616C6964203D20747275653B0D0A20202020202020202020202020202020696620287265634D65746164617461290D0A202020202020';
wwv_flow_imp.g_varchar2_table(213) := '202020202020202020207B0D0A20202020202020202020202020202020202020206C6574206669656C6473203D207265634D657461646174612E6669656C64733B0D0A2020202020202020202020202020202020202020696620286669656C6473290D0A';
wwv_flow_imp.g_varchar2_table(214) := '20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020666F722028636F6E7374206669656C6420696E206669656C647329200D0A2020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(215) := '207B0D0A20202020202020202020202020202020202020202020202020202020696620286669656C64735B6669656C645D2E6572726F72290D0A202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(216) := '20202020202020202020202020202020202020202076616C6964203D2066616C73653B0D0A2020202020202020202020202020202020202020202020202020202020202020627265616B3B0D0A2020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(217) := '20202020207D0D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A2020202020202020202020202020202072657475726E20';
wwv_flow_imp.g_varchar2_table(218) := '76616C69643B202020202020202020202020202020200D0A2020202020202020202020207D2C0D0A2020202020202020202020207265636F7264497356616C69643A2066756E6374696F6E286D6F64656C2C207265636F72644964290D0A202020202020';
wwv_flow_imp.g_varchar2_table(219) := '2020202020207B0D0A202020202020202020202020202020206C6574207265634D65746144617461203D206D6F64656C2E6765745265636F72644D65746164617461287265636F72644964293B0D0A202020202020202020202020202020207265747572';
wwv_flow_imp.g_varchar2_table(220) := '6E2028217265634D657461446174612E6572726F7220262620746869732E7265636F72644669656C647356616C6964287265634D6574614461746129293B0D0A2020202020202020202020207D2C0D0A2020202020202020202020207365745265636F72';
wwv_flow_imp.g_varchar2_table(221) := '644669656C647356616C69643A2066756E6374696F6E286D6F64656C2C207265636F7264290D0A2020202020202020202020207B0D0A202020202020202020202020202020206C6574207265636F72644964203D206D6F64656C2E6765745265636F7264';
wwv_flow_imp.g_varchar2_table(222) := '4964287265636F7264293B0D0A202020202020202020202020202020206C6574207265634D65746164617461203D206D6F64656C2E6765745265636F72644D65746164617461287265636F72644964293B0D0A2020202020202020202020202020202069';
wwv_flow_imp.g_varchar2_table(223) := '6620287265634D65746164617461290D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206C6574206669656C6473203D207265634D657461646174612E6669656C64733B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(224) := '20202020202020202020696620286669656C6473290D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020666F722028636F6E7374206669656C6420696E206669656C647329200D0A';
wwv_flow_imp.g_varchar2_table(225) := '2020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020696620286669656C64735B6669656C645D2E6572726F72290D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(226) := '2020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020206D6F64656C2E73657456616C6964697479282776616C6964272C207265636F726449642C206669656C64293B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(227) := '2020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D202020202020202020202020';
wwv_flow_imp.g_varchar2_table(228) := '202020200D0A2020202020202020202020207D0D0A20202020202020207D3B0D0A0D0A202020202020202072657475726E7B0D0A2020202020202020202020207574696C3A206D6F64656C5574696C0D0A20202020202020207D0D0A202020207D292829';
wwv_flow_imp.g_varchar2_table(229) := '3B2020202020200D0A202020200D0A2020202066756E6374696F6E20696E69744D6573736167657328290D0A202020207B0D0A20202020202020202F2F2068657265207765206861766520746865206C6162656C7320616E64206D657373616765732066';
wwv_flow_imp.g_varchar2_table(230) := '6F722077686963682074686520646576656C6F7065722073686F756C64206265200D0A20202020202020202F2F2061626C6520746F20636F6E666967207472616E736C6174696F6E7320696E20415045580D0A2020202020202020617065782E6C616E67';
wwv_flow_imp.g_varchar2_table(231) := '2E6164644D65737361676573287B0D0A202020202020202020202020274C494234582E4552562E434F4C5F4558505F475250273A2027436F6C6C617073652F457870616E642047726F757073272C0D0A202020202020202020202020274C494234582E45';
wwv_flow_imp.g_varchar2_table(232) := '52562E434F4C5F475250273A2027436F6C6C617073652047726F757073272C0D0A202020202020202020202020274C494234582E4552562E4558505F475250273A2027457870616E642047726F757073270D0A20202020202020207D293B202020202020';
wwv_flow_imp.g_varchar2_table(233) := '20200D0A202020207D0D0A0D0A2020202066756E6374696F6E206765744D657373616765286B657929207B0D0A202020202020202072657475726E20617065782E6C616E672E6765744D65737361676528274C494234582E4552562E27202B206B657929';
wwv_flow_imp.g_varchar2_table(234) := '3B0D0A202020207D202020200D0A0D0A202020202F2A0D0A20202020202A204D61696E20706C7567696E20696E69742066756E6374696F6E0D0A20202020202A2F0D0A202020206C657420696E6974203D2066756E6374696F6E28777270537461746963';
wwv_flow_imp.g_varchar2_table(235) := '49642C20636F6C756D6E734C61796F75742C206663735F7370616E57696474682C20666F726D4C6162656C57696474682C206D61784F6E654E6577526F772C20627574746F6E73436F6E66290D0A202020207B0D0A2020202020202020696E69744D6573';
wwv_flow_imp.g_varchar2_table(236) := '736167657328293B0D0A202020202020202024282723272B7772705374617469634964292E616464436C61737328435F4C494234585F53415256293B0D0A202020202020202069662028666F726D4C6162656C5769647468290D0A20202020202020207B';
wwv_flow_imp.g_varchar2_table(237) := '0D0A20202020202020202020202024282723272B7772705374617469634964292E616464436C61737328435F4C494234585F464F524D5F4C4142454C5F57494454485F505245464958202B20666F726D4C6162656C5769647468293B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(238) := '20207D0D0A20202020202020206C6574206F7074696F6E73203D207B7D3B0D0A20202020202020206F7074696F6E732E627574746F6E73436F6E66203D20627574746F6E73436F6E663B0D0A20202020202020206F7074696F6E732E636F6C756D6E734C';
wwv_flow_imp.g_varchar2_table(239) := '61796F7574203D20636F6C756D6E734C61796F7574203F20636F6C756D6E734C61796F7574203A20274E4F4E45273B0D0A202020202020202069662028636F6C756D6E734C61796F7574203D3D20274649454C445F434F4C554D4E535F5350414E27290D';
wwv_flow_imp.g_varchar2_table(240) := '0A20202020202020207B0D0A2020202020202020202020206F7074696F6E732E6663735F7370616E5769647468203D206663735F7370616E5769647468203F207061727365496E74286663735F7370616E576964746829203A20363B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(241) := '20207D0D0A20202020202020206F7074696F6E732E6D61784F6E654E6577526F77203D206D61784F6E654E6577526F773B0D0A2020202020202020736172764F7074696F6E735B77727053746174696349645D203D206F7074696F6E733B20202020200D';
wwv_flow_imp.g_varchar2_table(242) := '0A2020202020202020726F77566965774D6F64756C652E696E6974287772705374617469634964293B0D0A202020207D3B0D0A0D0A202020202F2F20696E6974494720746F2062652063616C6C65642066726F6D20746865204947204A61766153637269';
wwv_flow_imp.g_varchar2_table(243) := '707420496E697469616C697A6174696F6E2046756E6374696F6E0D0A202020206C657420696E69744947203D2066756E6374696F6E286967436F6E666967290D0A202020207B0D0A20202020202020206C65742069675374617469634964203D20696743';
wwv_flow_imp.g_varchar2_table(244) := '6F6E6669672E726567696F6E53746174696349643B0D0A20202020202020206C6574207772705374617469634964203D202428272327202B2069675374617469634964292E636C6F7365737428272E27202B20435F4C494234585F53415256292E617474';
wwv_flow_imp.g_varchar2_table(245) := '722827696427293B0D0A20202020202020206C65742072764F7074696F6E73203D20736172764F7074696F6E735B77727053746174696349645D3B0D0A20202020202020206C657420627574746F6E73436F6E66203D2072764F7074696F6E732E627574';
wwv_flow_imp.g_varchar2_table(246) := '746F6E73436F6E663B0D0A20202020202020206C6574206665617475726573203D20617065782E7574696C2E6765744E65737465644F626A656374286967436F6E6669672C202776696577732E677269642E666561747572657327293B0D0A2020202020';
wwv_flow_imp.g_varchar2_table(247) := '20202066656174757265732E6772696456696577203D2066616C73653B0D0A0D0A20202020202020206C65742070726F67726573734F7074696F6E73203D20617065782E7574696C2E6765744E65737465644F626A656374286967436F6E6669672C2027';
wwv_flow_imp.g_varchar2_table(248) := '64656661756C7453696E676C65526F774F7074696F6E732E70726F67726573734F7074696F6E7327293B0D0A202020202020202070726F67726573734F7074696F6E732E6669786564203D2066616C73653B20202F2F2062792074686973207365747469';
wwv_flow_imp.g_varchar2_table(249) := '6E672C20612066657463682F736176652070726F6772657373207370696E6E65722077696C6C20626520696E207468652063656E746572206F6620746865207265636F72645669657720616E64206E6F7420666978656420746F2074686520706167650D';
wwv_flow_imp.g_varchar2_table(250) := '0A202020200D0A202020202020202066756E6374696F6E20676F746F526F7728696753746174696349642C20666C290D0A20202020202020207B0D0A2020202020202020202020206C657420746F74616C5265636F726473203D20617065782E72656769';
wwv_flow_imp.g_varchar2_table(251) := '6F6E2869675374617469634964292E77696467657428292E696E746572616374697665477269642827676574566965777327292E677269642E6D6F64656C2E676574546F74616C5265636F72647328293B0D0A2020202020202020202020206966202874';
wwv_flow_imp.g_varchar2_table(252) := '6F74616C5265636F72647320262620746F74616C5265636F726473203E2030290D0A2020202020202020202020207B0D0A20202020202020202020202020202020617065782E726567696F6E2869675374617469634964292E77696467657428292E696E';
wwv_flow_imp.g_varchar2_table(253) := '746572616374697665477269642827676574566965777327292E677269642E73696E676C65526F7756696577242E7265636F72645669657728276F7074696F6E272C20277265636F72644F6666736574272C20666C203D3D20276C61737427203F20746F';
wwv_flow_imp.g_varchar2_table(254) := '74616C5265636F7264732D31203A203020293B0D0A2020202020202020202020207D2020202020202020200D0A20202020202020207D0D0A0D0A202020202020202066756E6374696F6E20636F6E666967757265427574746F6E28746F6F6C6261724461';
wwv_flow_imp.g_varchar2_table(255) := '74612C2073686F77427574746F6E2C206462644964290D0A20202020202020207B0D0A202020202020202020202020696620282173686F77427574746F6E290D0A2020202020202020202020207B0D0A20202020202020202020202020202020746F6F6C';
wwv_flow_imp.g_varchar2_table(256) := '626172446174612E746F6F6C62617252656D6F7665286462644964293B0D0A2020202020202020202020207D0D0A20202020202020207D0D0A202020200D0A20202020202020202F2F20696E74726F6475636520736F6D6520657874726120627574746F';
wwv_flow_imp.g_varchar2_table(257) := '6E732B616374696F6E733A2066697273742F6C61737420726F772C20657870616E642D636F6C6C617073650D0A20202020202020206967436F6E6669672E696E6974416374696F6E73203D2066756E6374696F6E2028616374696F6E7329207B200D0A20';
wwv_flow_imp.g_varchar2_table(258) := '2020202020202020202020616374696F6E732E616464285B0D0A202020202020202020202020202020207B200D0A20202020202020202020202020202020202020206E616D653A204143545F46495253542C200D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(259) := '20202020206C6162656C3A20274669727374272C0D0A2020202020202020202020202020202020202020616374696F6E3A2066756E6374696F6E2829207B200D0A202020202020202020202020202020202020202020202020676F746F526F7728696753';
wwv_flow_imp.g_varchar2_table(260) := '746174696349642C2027666972737427293B20202020202020202020200D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D2C2020202020202020202020200D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(261) := '20207B200D0A20202020202020202020202020202020202020206E616D653A204143545F4C4153542C200D0A20202020202020202020202020202020202020206C6162656C3A20274C617374272C0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(262) := '616374696F6E3A2066756E6374696F6E2829207B200D0A202020202020202020202020202020202020202020202020676F746F526F7728696753746174696349642C20276C61737427293B2020202020202020202020200D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(263) := '2020202020202020207D0D0A202020202020202020202020202020207D2C0D0A202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206E616D653A20276C696234782D746F67676C652D636F6C6C6170736962';
wwv_flow_imp.g_varchar2_table(264) := '6C6573272C200D0A20202020202020202020202020202020202020206C6162656C4B65793A20274C494234582E4552562E434F4C5F4558505F475250272C0D0A20202020202020202020202020202020202020206F6E4C6162656C4B65793A20274C4942';
wwv_flow_imp.g_varchar2_table(265) := '34582E4552562E434F4C5F475250272C0D0A20202020202020202020202020202020202020206F66664C6162656C4B65793A20274C494234582E4552562E4558505F475250272C0D0A20202020202020202020202020202020202020202F2F6F6E49636F';
wwv_flow_imp.g_varchar2_table(266) := '6E3A202769636F6E2D69672D636F6C6C617073652D726F77272C0D0A20202020202020202020202020202020202020202F2F6F666649636F6E3A202769636F6E2D69672D657870616E642D726F77272C0D0A202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(267) := '20202F2F6F6E49636F6E3A202766612D657870616E642D636F6C6C61707365272C0D0A20202020202020202020202020202020202020202F2F6F666649636F6E3A202766612D657870616E642D636F6C6C61707365272C0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(268) := '20202020202020202069636F6E3A202766612066612D657870616E642D636F6C6C61707365272C0D0A2020202020202020202020202020202020202020657870616E6465643A20747275652C0D0A20202020202020202020202020202020202020207365';
wwv_flow_imp.g_varchar2_table(269) := '743A2066756E6374696F6E28657870616E646564290D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020746869732E657870616E646564203D20657870616E6465643B0D0A202020';
wwv_flow_imp.g_varchar2_table(270) := '20202020202020202020202020202020202020202024282723272B206967436F6E6669672E726567696F6E5374617469634964202B2027202E27202B20435F434F4C4C41505349424C45292E636F6C6C61707369626C6528657870616E646564203F2027';
wwv_flow_imp.g_varchar2_table(271) := '657870616E6427203A2027636F6C6C6170736527293B0D0A20202020202020202020202020202020202020207D2C0D0A20202020202020202020202020202020202020206765743A2066756E6374696F6E28290D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(272) := '20202020207B0D0A20202020202020202020202020202020202020202020202072657475726E20746869732E657870616E6465643B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D2020202020';
wwv_flow_imp.g_varchar2_table(273) := '0D0A2020202020202020202020205D293B200D0A20202020202020207D3B20202020200D0A0D0A20202020202020206C657420746F6F6C62617244617461203D20242E617065782E696E746572616374697665477269642E636F707944656661756C7454';
wwv_flow_imp.g_varchar2_table(274) := '6F6F6C62617228293B0D0A20202020202020202F2F2074616B65206177617920756E6E6565646564206F7074696F6E732066726F6D2074686520416374696F6E73206D656E750D0A2020202020202020696620286967436F6E6669672E66656174757265';
wwv_flow_imp.g_varchar2_table(275) := '733F2E736176655265706F72743F2E6973446576656C6F706572290D0A20202020202020207B0D0A2020202020202020202020202F2F20646576656C6F7065722073686F756C642062652061626C6520746F20617272616E676520636F6C756D6E732028';
wwv_flow_imp.g_varchar2_table(276) := '6669656C64732920616E64207361766520697420746F207468652064656661756C74207265706F72740D0A202020202020202020202020746F6F6C626172446174612E746F6F6C626172496E7365727441667465722827616374696F6E7331272C0D0A20';
wwv_flow_imp.g_varchar2_table(277) := '2020202020202020202020202020207B0D0A202020202020202020202020202020202020202069643A20226C696234785F616374696F6E7331222C0D0A2020202020202020202020202020202020202020636F6E74726F6C733A205B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(278) := '2020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020747970653A2054425F4D454E552C0D0A2020202020202020202020202020202020202020202020202020202069643A20226163';
wwv_flow_imp.g_varchar2_table(279) := '74696F6E735F627574746F6E222C0D0A202020202020202020202020202020202020202020202020202020206C6162656C4B65793A2022415045582E49472E414354494F4E53222C0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(280) := '20206D656E753A207B0D0A20202020202020202020202020202020202020202020202020202020202020206974656D733A205B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(281) := '2020202020202020202020202020202020202020202020202020202020202020747970653A20414354494F4E2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020616374696F6E3A202273686F77';
wwv_flow_imp.g_varchar2_table(282) := '2D636F6C756D6E732D6469616C6F67222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C6162656C3A2027436F6C756D6E7320284669656C647329270D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(283) := '202020202020202020202020202020202020202020207D2C2020200D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(284) := '2020202020202020747970653A2022736570617261746F72220D0A2020202020202020202020202020202020202020202020202020202020202020202020207D2C2020202020202020202020202020202020202020202020202020202020202020200D0A';
wwv_flow_imp.g_varchar2_table(285) := '2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020747970653A20414354494F4E2C0D0A202020202020';
wwv_flow_imp.g_varchar2_table(286) := '20202020202020202020202020202020202020202020202020202020202020202020616374696F6E3A202273686F772D66696C7465722D6469616C6F67220D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(287) := '7D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020747970653A20227375624D656E75222C0D';
wwv_flow_imp.g_varchar2_table(288) := '0A2020202020202020202020202020202020202020202020202020202020202020202020202020202069643A2022646174615F7375626D656E75222C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(289) := '20206C6162656C4B65793A2022415045582E49472E44415441222C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202069636F6E3A202269636F6E2D69672D64617461222C0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(290) := '20202020202020202020202020202020202020202020202020202020202020206D656E753A207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206974656D733A205B0D0A2020202020';
wwv_flow_imp.g_varchar2_table(291) := '202020202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207479';
wwv_flow_imp.g_varchar2_table(292) := '70653A20414354494F4E2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020616374696F6E3A202273686F772D736F72742D6469616C6F67220D0A20202020202020';
wwv_flow_imp.g_varchar2_table(293) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020';
wwv_flow_imp.g_varchar2_table(294) := '202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020747970653A20414354494F4E2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(295) := '202020202020202020202020202020616374696F6E3A202272656672657368220D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(296) := '20202020202020202020202020202020202020202020202020202020205D0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(297) := '20202020202020202020207D2C2020200D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020747970';
wwv_flow_imp.g_varchar2_table(298) := '653A2022736570617261746F72220D0A2020202020202020202020202020202020202020202020202020202020202020202020207D2C2020202020202020202020202020202020202020202020202020202020202020200D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(299) := '202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020747970653A20414354494F4E2C0D0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(300) := '2020202020202020202020202020202020202020202020616374696F6E3A2022736176652D7265706F7274222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C6162656C3A20275361766520';
wwv_flow_imp.g_varchar2_table(301) := '44656661756C74205265706F7274270D0A2020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020';
wwv_flow_imp.g_varchar2_table(302) := '202020202020202020202020202020202020202020202020202020202020202020202020747970653A20414354494F4E2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020616374696F6E3A2022';
wwv_flow_imp.g_varchar2_table(303) := '72657365742D7265706F7274222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C6162656C3A20275265736574205265706F7274270D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(304) := '2020202020202020202020202020207D2020202020202020202020202020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020202020202020202020202020205D0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(305) := '20202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020205D0D0A202020202020202020202020202020207D0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(306) := '20293B0D0A20202020202020207D0D0A2020202020202020656C73650D0A20202020202020207B0D0A202020202020202020202020746F6F6C626172446174612E746F6F6C626172496E7365727441667465722827616374696F6E7331272C0D0A202020';
wwv_flow_imp.g_varchar2_table(307) := '202020202020202020202020207B0D0A202020202020202020202020202020202020202069643A20226C696234785F616374696F6E7331222C0D0A2020202020202020202020202020202020202020636F6E74726F6C733A205B0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(308) := '202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020747970653A2054425F4D454E552C0D0A2020202020202020202020202020202020202020202020202020202069643A202261637469';
wwv_flow_imp.g_varchar2_table(309) := '6F6E735F627574746F6E222C0D0A202020202020202020202020202020202020202020202020202020206C6162656C4B65793A2022415045582E49472E414354494F4E53222C0D0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(310) := '6D656E753A207B0D0A20202020202020202020202020202020202020202020202020202020202020206974656D733A205B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(311) := '202020202020202020202020202020202020202020202020202020202020747970653A20414354494F4E2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020616374696F6E3A202273686F772D66';
wwv_flow_imp.g_varchar2_table(312) := '696C7465722D6469616C6F67220D0A2020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(313) := '20202020202020202020202020202020202020202020202020202020202020202020747970653A20227375624D656E75222C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202069643A2022646174';
wwv_flow_imp.g_varchar2_table(314) := '615F7375626D656E75222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C6162656C4B65793A2022415045582E49472E44415441222C0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(315) := '202020202020202020202020202020202020202069636F6E3A202269636F6E2D69672D64617461222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206D656E753A207B0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(316) := '2020202020202020202020202020202020202020202020202020202020202020202020206974656D733A205B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A202020';
wwv_flow_imp.g_varchar2_table(317) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020747970653A20414354494F4E2C0D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(318) := '20202020202020202020202020202020616374696F6E3A202273686F772D736F72742D6469616C6F67220D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A20202020';
wwv_flow_imp.g_varchar2_table(319) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202074';
wwv_flow_imp.g_varchar2_table(320) := '7970653A20414354494F4E2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020616374696F6E3A202272656672657368220D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(321) := '2020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020205D0D0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(322) := '20202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020205D0D0A';
wwv_flow_imp.g_varchar2_table(323) := '202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020205D0D0A202020202020202020202020202020207D0D0A';
wwv_flow_imp.g_varchar2_table(324) := '202020202020202020202020293B0D0A20202020202020207D3B0D0A20202020202020202F2F20696E7374656164206F662063727564206D656E752C2068617665206372756420627574746F6E730D0A2020202020202020746F6F6C626172446174612E';
wwv_flow_imp.g_varchar2_table(325) := '746F6F6C626172496E7365727441667465722827616374696F6E7332272C200D0A2020202020202020202020207B0D0A2020202020202020202020202020202069643A20226C696234785F616374696F6E7332222C0D0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(326) := '202020636F6E74726F6C733A205B0D0A202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020616374696F6E3A2022696E736572742D7265636F7264222C0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(327) := '2020202020202020202020206C6162656C3A202741646420526F77272C0D0A202020202020202020202020202020202020202020202020747970653A2027425554544F4E272C0D0A20202020202020202020202020202020202020202020202069636F6E';
wwv_flow_imp.g_varchar2_table(328) := '4F6E6C793A20747275652C0D0A20202020202020202020202020202020202020202020202069636F6E3A202769636F6E2D69672D6164642D726F77270D0A20202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(329) := '2020202020207B0D0A202020202020202020202020202020202020202020202020616374696F6E3A20226475706C69636174652D7265636F7264222C0D0A2020202020202020202020202020202020202020202020206C6162656C3A20274475706C6963';
wwv_flow_imp.g_varchar2_table(330) := '61746520526F77272C0D0A202020202020202020202020202020202020202020202020747970653A2027425554544F4E272C0D0A20202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(331) := '202020202020202020202020202020202069636F6E3A202769636F6E2D69672D6475706C6963617465272020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020207D2C0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(332) := '2020202020202020202020207B0D0A202020202020202020202020202020202020202020202020616374696F6E3A202264656C6574652D7265636F7264222C0D0A2020202020202020202020202020202020202020202020206C6162656C3A202752656D';
wwv_flow_imp.g_varchar2_table(333) := '6F766520526F77272C0D0A202020202020202020202020202020202020202020202020747970653A2027425554544F4E272C0D0A20202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(334) := '202020202020202020202020202020202069636F6E3A202769636F6E2D69672D64656C657465272020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020207D2C0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(335) := '2020202020202020207B0D0A202020202020202020202020202020202020202020202020616374696F6E3A20227265766572742D7265636F7264222C0D0A2020202020202020202020202020202020202020202020206C6162656C3A2027526576657274';
wwv_flow_imp.g_varchar2_table(336) := '204368616E676573272C0D0A202020202020202020202020202020202020202020202020747970653A2027425554544F4E272C0D0A20202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A202020202020';
wwv_flow_imp.g_varchar2_table(337) := '20202020202020202020202020202020202069636F6E3A202769636F6E2D69672D726576657274272020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020207D2C0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(338) := '202020202020202020207B0D0A202020202020202020202020202020202020202020202020616374696F6E3A2022726566726573682D7265636F7264222C0D0A2020202020202020202020202020202020202020202020206C6162656C3A202752656672';
wwv_flow_imp.g_varchar2_table(339) := '65736820526F77272C0D0A202020202020202020202020202020202020202020202020747970653A2027425554544F4E272C0D0A20202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(340) := '202020202020202020202020202020202069636F6E3A202769636F6E2D69672D72656672657368272020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020207D20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(341) := '202020202020200D0A202020202020202020202020202020205D0D0A2020202020202020202020207D0D0A2020202020202020293B0D0A20202020202020202F2F2061646420706167696E6174696F6E20627574746F6E732C207265636F726420737461';
wwv_flow_imp.g_varchar2_table(342) := '74652F6E756D6265722C20657870616E642D636F6C6C617073650D0A2020202020202020746F6F6C626172446174612E746F6F6C626172496E73657274416674657228276C696234785F616374696F6E7332272C0D0A2020202020202020202020207B0D';
wwv_flow_imp.g_varchar2_table(343) := '0A2020202020202020202020202020202069643A20226C696234785F706167696E6174696F6E222C0D0A20202020202020202020202020202020616C69676E3A2022656E64222C0D0A20202020202020202020202020202020636F6E74726F6C733A205B';
wwv_flow_imp.g_varchar2_table(344) := '0D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020747970653A2022535441544943222C0D0A20202020202020202020202020202020202020202020202069643A20227374617475';
wwv_flow_imp.g_varchar2_table(345) := '73222C0D0A2020202020202020202020202020202020202020202020206C6162656C3A2022220D0A20202020202020202020202020202020202020207D2C0D0A20202020202020202020202020202020202020207B0D0A20202020202020202020202020';
wwv_flow_imp.g_varchar2_table(346) := '2020202020202020202020747970653A2027425554544F4E272C0D0A2020202020202020202020202020202020202020202020206C6162656C3A2027457870616E642F436F6C6C61707365272C0D0A202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(347) := '20202069636F6E4F6E6C793A20747275652C0D0A202020202020202020202020202020202020202020202020616374696F6E3A20226C696234782D746F67676C652D636F6C6C61707369626C6573220D0A20202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(348) := '207D2C0D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020747970653A2022425554544F4E222C0D0A20202020202020202020202020202020202020202020202069636F6E4F6E6C';
wwv_flow_imp.g_varchar2_table(349) := '793A20747275652C0D0A20202020202020202020202020202020202020202020202069636F6E3A202269636F6E2D6669727374222C0D0A202020202020202020202020202020202020202020202020616374696F6E3A202266697273742D7265636F7264';
wwv_flow_imp.g_varchar2_table(350) := '220D0A20202020202020202020202020202020202020207D2C202020202020202020202020202020200D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020747970653A2022425554';
wwv_flow_imp.g_varchar2_table(351) := '544F4E222C0D0A20202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A20202020202020202020202020202020202020202020202069636F6E3A202269636F6E2D70726576222C0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(352) := '20202020202020202020202020202020616374696F6E3A202270726576696F75732D7265636F7264220D0A20202020202020202020202020202020202020207D2C0D0A20202020202020202020202020202020202020207B0D0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(353) := '2020202020202020202020202020747970653A2022535441544943222C0D0A20202020202020202020202020202020202020202020202069643A20227265636F72644E756D626572222C0D0A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(354) := '6C6162656C3A2022220D0A20202020202020202020202020202020202020207D2C0D0A20202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020747970653A2022425554544F4E222C0D0A20';
wwv_flow_imp.g_varchar2_table(355) := '202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A20202020202020202020202020202020202020202020202069636F6E3A202269636F6E2D6E657874222C0D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(356) := '2020202020202020616374696F6E3A20226E6578742D7265636F7264220D0A20202020202020202020202020202020202020207D2C0D0A20202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(357) := '2020747970653A2022425554544F4E222C0D0A20202020202020202020202020202020202020202020202069636F6E4F6E6C793A20747275652C0D0A20202020202020202020202020202020202020202020202069636F6E3A202269636F6E2D6C617374';
wwv_flow_imp.g_varchar2_table(358) := '222C0D0A202020202020202020202020202020202020202020202020616374696F6E3A20226C6173742D7265636F7264220D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020205D0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(359) := '20202020207D200D0A2020202020202020293B0D0A2020202020202020746F6F6C626172446174612E746F6F6C62617252656D6F766528277265706F72747327293B2020200D0A2020202020202020746F6F6C626172446174612E746F6F6C6261725265';
wwv_flow_imp.g_varchar2_table(360) := '6D6F76652827766965777327293B200D0A2020202020202020746F6F6C626172446174612E746F6F6C62617252656D6F76652827616374696F6E733127293B200D0A2020202020202020746F6F6C626172446174612E746F6F6C62617252656D6F766528';
wwv_flow_imp.g_varchar2_table(361) := '27616374696F6E733327293B0D0A2020202020202020746F6F6C626172446174612E746F6F6C62617252656D6F76652827616374696F6E733427293B0D0A20202020202020202F2F206170706C7920706C7567696E20746F6F6C6261722F627574746F6E';
wwv_flow_imp.g_varchar2_table(362) := '206F7074696F6E730D0A20202020202020206966202821627574746F6E73436F6E662E726F77416374696F6E427574746F6E73290D0A20202020202020207B0D0A202020202020202020202020746F6F6C626172446174612E746F6F6C62617252656D6F';
wwv_flow_imp.g_varchar2_table(363) := '766528276C696234785F616374696F6E733227293B0D0A20202020202020207D0D0A2020202020202020656C73650D0A20202020202020207B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C20';
wwv_flow_imp.g_varchar2_table(364) := '627574746F6E73436F6E662E616464526F772C2027696E736572742D7265636F726427293B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C20627574746F6E73436F6E662E6475706C69636174';
wwv_flow_imp.g_varchar2_table(365) := '65526F772C20276475706C69636174652D7265636F726427293B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C20627574746F6E73436F6E662E64656C657465526F772C202764656C6574652D';
wwv_flow_imp.g_varchar2_table(366) := '7265636F726427293B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C20627574746F6E73436F6E662E72656672657368526F772C2027726566726573682D7265636F726427293B0D0A20202020';
wwv_flow_imp.g_varchar2_table(367) := '2020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C20627574746F6E73436F6E662E726576657274526F772C20277265766572742D7265636F726427293B0D0A20202020202020207D0D0A2020202020202020636F';
wwv_flow_imp.g_varchar2_table(368) := '6E666967757265427574746F6E28746F6F6C626172446174612C2028627574746F6E73436F6E662E6564697420262620216967436F6E6669672E64656661756C7453696E676C65526F774F7074696F6E732E616C7761797345646974292C202765646974';
wwv_flow_imp.g_varchar2_table(369) := '27293B0D0A20202020202020206966202821627574746F6E73436F6E662E706167696E6174696F6E427574746F6E73290D0A20202020202020207B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C62617244617461';
wwv_flow_imp.g_varchar2_table(370) := '2C2066616C73652C202766697273742D7265636F726427293B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C2066616C73652C202770726576696F75732D7265636F726427293B0D0A20202020';
wwv_flow_imp.g_varchar2_table(371) := '2020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C2066616C73652C20277265636F72644E756D62657227293B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174';
wwv_flow_imp.g_varchar2_table(372) := '612C2066616C73652C20276E6578742D7265636F726427293B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C2066616C73652C20276C6173742D7265636F726427293B0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(373) := '7D0D0A2020202020202020656C7365206966202821627574746F6E73436F6E662E66697273744C617374290D0A20202020202020207B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C2066616C';
wwv_flow_imp.g_varchar2_table(374) := '73652C202766697273742D7265636F726427293B0D0A202020202020202020202020636F6E666967757265427574746F6E28746F6F6C626172446174612C2066616C73652C20276C6173742D7265636F726427293B0D0A20202020202020207D0D0A2020';
wwv_flow_imp.g_varchar2_table(375) := '2020202020202F2F2073656520696620657870616E642F636F6C6C6170736520627574746F6E20746F20626520757365640D0A20202020202020206C657420757365457870616E64436F6C6C61707365427574746F6E203D2066616C73653B0D0A202020';
wwv_flow_imp.g_varchar2_table(376) := '20202020206966202872764F7074696F6E732E636F6C756D6E734C61796F757420213D20274649454C445F47524F55505F434F4C554D4E5327290D0A20202020202020207B0D0A2020202020202020202020206C65742067726F757065644669656C6473';
wwv_flow_imp.g_varchar2_table(377) := '4C656E677468203D206967436F6E6669672E636F6C756D6E732E66696C746572280D0A2020202020202020202020202020202028636F6C756D6E293D3E28636F6C756D6E2E6C61796F75743F2E67726F75704964290D0A20202020202020202020202029';
wwv_flow_imp.g_varchar2_table(378) := '2E6C656E6774683B0D0A2020202020202020202020206966202867726F757065644669656C64734C656E677468203E2030290D0A2020202020202020202020207B0D0A20202020202020202020202020202020757365457870616E64436F6C6C61707365';
wwv_flow_imp.g_varchar2_table(379) := '427574746F6E203D20747275653B0D0A2020202020202020202020207D0D0A20202020202020207D0D0A20202020202020206966202821757365457870616E64436F6C6C61707365427574746F6E290D0A20202020202020207B0D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(380) := '20202020636F6E666967757265427574746F6E28746F6F6C626172446174612C2066616C73652C20276C696234782D746F67676C652D636F6C6C61707369626C657327293B0D0A20202020202020207D0D0A0D0A20202020202020206967436F6E666967';
wwv_flow_imp.g_varchar2_table(381) := '2E746F6F6C62617244617461203D20746F6F6C626172446174613B0D0A0D0A20202020202020202F2F207365636F6E64206C696E65206F6620646566656E736520696E2063617365206F66206D61784F6E654E6577526F770D0A20202020202020206967';
wwv_flow_imp.g_varchar2_table(382) := '436F6E6669672E64656661756C744D6F64656C4F7074696F6E73203D207B0D0A202020202020202020202020636865636B3A2028726573756C742C206F7065726174696F6E2C207265636F72642C20616464416374696F6E2C207265636F726473546F41';
wwv_flow_imp.g_varchar2_table(383) := '646429203D3E207B0D0A2020202020202020202020202020202069662028726573756C7429207B0D0A2020202020202020202020202020202020202020696620282872764F7074696F6E732E6D61784F6E654E6577526F772920262620286F7065726174';
wwv_flow_imp.g_varchar2_table(384) := '696F6E203D3D202763616E416464272929207B0D0A2020202020202020202020202020202020202020202020206C6574206D6F64656C203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E6772';
wwv_flow_imp.g_varchar2_table(385) := '69642E6D6F64656C3B0D0A202020202020202020202020202020202020202020202020696620286D6F64656C290D0A2020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(386) := '2020726573756C74203D2021286D6F64656C2E6765744368616E67657328292E66696C7465722872203D3E20722E696E736572746564292E6C656E677468203E2030293B0D0A2020202020202020202020202020202020202020202020207D0D0A202020';
wwv_flow_imp.g_varchar2_table(387) := '20202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A2020202020202020202020202020202072657475726E20726573756C743B202020202020202020202020202020200D0A2020202020202020202020207D';
wwv_flow_imp.g_varchar2_table(388) := '0D0A20202020202020207D3B0D0A202020202020202072657475726E206967436F6E6669673B0D0A202020207D2020200D0A202020200D0A202020202F2F2062656C6F772066756E6374696F6E2063616E206265207573656420666F7220746865206361';
wwv_flow_imp.g_varchar2_table(389) := '6C6C73657276657220696E20617065782E6D6F64656C2E7361766528290D0A202020202F2F20746F206465616C2077697468207468652062656C6F77206465736372696265642069737375650D0A2020202066756E6374696F6E206D6173746572446574';
wwv_flow_imp.g_varchar2_table(390) := '61696C5361766543616C6C5365727665722872657175657374446174612C20726571756573744F7074696F6E73290D0A202020207B0D0A20202020202020202F2F207573696E672063616C6C536572766572206173206120777261707065722061726F75';
wwv_flow_imp.g_varchar2_table(391) := '6E6420746865207361766520726571756573740D0A20202020202020202F2F2062656C6F7720636F64652070726576656E7473206120274D616C666F726D656420726573706F6E736527206572726F7220200D0A20202020202020202F2F207768696368';
wwv_flow_imp.g_varchar2_table(392) := '207374617274656420746F206F636375722075706F6E206170706C79696E67204D61737465722D44657461696C207265666572656E7469616C20696E746567726974790D0A20202020202020202F2F20696E20706167652070726F6365737365730D0A20';
wwv_flow_imp.g_varchar2_table(393) := '202020202020202F2F2062656C6F77206C6F676963207265706C6163657320746865206F726967696E616C206D6F64656C2069642028656720277431303030272920696E2074686520726573706F6E736520776974680D0A20202020202020202F2F2074';
wwv_flow_imp.g_varchar2_table(394) := '68652073657276657220736964652067656E657261746564206F726465722069642028696E7365727420736974756174696F6E73290D0A20202020202020206C65742070203D20617065782E7365727665722E706C7567696E2872657175657374446174';
wwv_flow_imp.g_varchar2_table(395) := '612C20726571756573744F7074696F6E73293B0D0A2020202020202020702E646F6E652820726573706F6E736544617461203D3E207B0D0A20202020202020202020202069662028726573706F6E7365446174612E726567696F6E733F2E6C656E677468';
wwv_flow_imp.g_varchar2_table(396) := '203D3D2032290D0A2020202020202020202020207B0D0A20202020202020202020202020202020636F6E7374207265636F72644D6170203D207B7D3B0D0A20202020202020202020202020202020636F6E73742076616C756573203D20726573706F6E73';
wwv_flow_imp.g_varchar2_table(397) := '65446174612E726567696F6E735B305D2E66657463686564446174612E6D6F64656C735B305D2E76616C7565733B0D0A2020202020202020202020202020202076616C7565732E666F724561636828726F77203D3E207B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(398) := '202020202020202020636F6E737420666972737456616C7565203D20726F775B305D3B0D0A2020202020202020202020202020202020202020636F6E7374206D65746164617461203D20726F775B726F772E6C656E677468202D20315D3B202F2F206479';
wwv_flow_imp.g_varchar2_table(399) := '6E616D6963616C6C792067657420746865206C617374206974656D0D0A2020202020202020202020202020202020202020636F6E7374207265636F72644964203D206D657461646174612E7265636F726449643B0D0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(400) := '2020202020207265636F72644D61705B7265636F726449645D203D20666972737456616C75653B0D0A202020202020202020202020202020207D293B2020200D0A20202020202020202020202020202020726573706F6E7365446174612E726567696F6E';
wwv_flow_imp.g_varchar2_table(401) := '735B315D2E66657463686564446174612E6D6F64656C732E666F7245616368286D6F64656C203D3E207B0D0A2020202020202020202020202020202020202020636F6E7374206F726967696E616C496E7374616E6365203D206D6F64656C2E696E737461';
wwv_flow_imp.g_varchar2_table(402) := '6E63653B0D0A2020202020202020202020202020202020202020696620287265636F72644D61702E6861734F776E50726F7065727479286F726967696E616C496E7374616E63652929207B0D0A2020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(403) := '206D6F64656C2E696E7374616E6365203D207265636F72644D61705B6F726967696E616C496E7374616E63655D3B202F2F205265706C61636520696E7374616E63650D0A20202020202020202020202020202020202020207D0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(404) := '202020202020207D293B20202020200D0A2020202020202020202020207D20202020202020200D0A20202020202020207D293B200D0A20202020202020202F2F202E646F6E652063616C6C6261636B732061726520636861696E65640D0A202020202020';
wwv_flow_imp.g_varchar2_table(405) := '20202F2F2068747470733A2F2F626C6F672E64657667656E6975732E696F2F686F772D746F2D7573652D64656665727265642D646F6E652D666F722D6265747465722D70726F6D6973652D68616E646C696E672D696E2D6A6176617363726970742D6639';
wwv_flow_imp.g_varchar2_table(406) := '613461643034396436330D0A202020202020202072657475726E20703B0D0A202020207D202020202020200D0A0D0A202020202F2F2076616C69646174652066756E6374696F6E2077686963682063616E2062652075736564206265666F726520736176';
wwv_flow_imp.g_varchar2_table(407) := '6520617320746F206465616C0D0A202020202F2F2077697468207468652062656C6F77206465736372696265642069737375650D0A2020202066756E6374696F6E2076616C69646174652869675374617469634964290D0A202020207B0D0A2020202020';
wwv_flow_imp.g_varchar2_table(408) := '2020206C65742073696E676C65526F775669657724203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E73696E676C65526F7756696577243B0D0A20202020202020206C6574206D';
wwv_flow_imp.g_varchar2_table(409) := '61737465724D6F64656C203D2073696E676C65526F7756696577242E7265636F72645669657728276765744D6F64656C27293B0D0A20202020202020206C6574206D61737465725265636F7264203D2073696E676C65526F7756696577242E7265636F72';
wwv_flow_imp.g_varchar2_table(410) := '645669657728276765745265636F726427293B0D0A20202020202020206C6574206D61737465725265636F72644964203D206D61737465724D6F64656C2E6765745265636F72644964286D61737465725265636F7264293B0D0A20202020202020206966';
wwv_flow_imp.g_varchar2_table(411) := '202873696E676C65526F7756696577242E7265636F7264566965772827696E456469744D6F64652729290D0A20202020202020207B0D0A2020202020202020202020202F2F205768656E20696E2065646974206D6F646520616E642068697474696E6720';
wwv_flow_imp.g_varchar2_table(412) := '746865207361766520627574746F6E2C20746865206576656E742027656E647265636F7264656469742720776F6E277420666972650D0A2020202020202020202020202F2F20616E6420616E79202868746D6C35292076616C69646174696F6E20657272';
wwv_flow_imp.g_varchar2_table(413) := '6F727320776F6E277420706F70756C61746520696E746F20746865206D6F64656C2C2066726F6D2077686963680D0A2020202020202020202020202F2F2069742077696C6C206578656375746520746865207365727665722063616C6C2028616E642065';
wwv_flow_imp.g_varchar2_table(414) := '78656375746520746865207365727665722D736964652076616C69646174696F6E73292E0D0A2020202020202020202020202F2F20496E2062656C6F77206C6F6769632C207765206D616E75616C6C7920706F70756C61746520616E792076616C696461';
wwv_flow_imp.g_varchar2_table(415) := '74696F6E206572726F727320696E746F20746865206D6F64656C2C20736F0D0A2020202020202020202020202F2F2069742077696C6C206F6E6C7920676F20746F2074686520736572766572207768656E206E6F206F70656E206572726F72732E0D0A20';
wwv_flow_imp.g_varchar2_table(416) := '20202020202020202020206C6574206669656C6473203D2073696E676C65526F7756696577242E7265636F72645669657728276F7074696F6E272C20276669656C647327293B0D0A202020202020202020202020666F722028636F6E7374205B70726F70';
wwv_flow_imp.g_varchar2_table(417) := '657274792C206669656C645D206F66204F626A6563742E656E7472696573286669656C64735B305D29290D0A2020202020202020202020207B20200D0A20202020202020202020202020202020696620286669656C642E656C656D656E744964290D0A20';
wwv_flow_imp.g_varchar2_table(418) := '2020202020202020202020202020207B0D0A20202020202020202020202020202020202020206C6574206669656C644974656D203D20617065782E6974656D286669656C642E656C656D656E744964293B0D0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(419) := '20202069662028216669656C644974656D2E697344697361626C65642829290D0A20202020202020202020202020202020202020207B202020200D0A2020202020202020202020202020202020202020202020206C65742076616C6964697479203D2066';
wwv_flow_imp.g_varchar2_table(420) := '69656C644974656D2E67657456616C696469747928293B0D0A202020202020202020202020202020202020202020202020696620282176616C69646974792E76616C6964290D0A2020202020202020202020202020202020202020202020207B0D0A2020';
wwv_flow_imp.g_varchar2_table(421) := '20202020202020202020202020202020202020202020202020206C65742076616C69646174696F6E4D657373616765203D206669656C644974656D2E67657456616C69646174696F6E4D65737361676528293B0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(422) := '202020202020202020202020206966202876616C69646174696F6E4D657373616765290D0A202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(423) := '6D61737465724D6F64656C2E73657456616C696469747928226572726F72222C206D61737465725265636F726449642C2070726F70657274792C2076616C69646174696F6E4D657373616765293B0D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(424) := '20202020202020207D0D0A2020202020202020202020202020202020202020202020207D20202020202020202020202020202020202020202020202020202020202020200D0A20202020202020202020202020202020202020207D0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(425) := '2020202020202020207D0D0A2020202020202020202020207D0D0A20202020202020207D20202020202020200D0A202020207D0D0A0D0A202020202F2F2066756E6374696F6E2077686963682063616E206265207573656420746F206A756D7020746F20';
wwv_flow_imp.g_varchar2_table(426) := '74686520666972737420726F7720686176696E67206572726F722873290D0A202020202F2F20746869732063616E206265206572726F727320696E2072656C617465642064657461696C207265636F7264732061732077656C6C20286D61737465722D64';
wwv_flow_imp.g_varchar2_table(427) := '657461696C2073657474696E67290D0A2020202066756E6374696F6E20676F746F416E794572726F722869675374617469634964290D0A202020207B0D0A20202020202020206C6574206F684D6F64656C203D20617065782E726567696F6E2869675374';
wwv_flow_imp.g_varchar2_table(428) := '617469634964292E63616C6C2827676574566965777327292E677269642E6D6F64656C3B0D0A20202020202020206C6574206572726F725265634D657461417272203D206F684D6F64656C2E6765744572726F727328293B0D0A20202020202020206966';
wwv_flow_imp.g_varchar2_table(429) := '20286572726F725265634D6574614172722E6C656E677468290D0A20202020202020207B0D0A2020202020202020202020206C6574207265636F72644964203D206F684D6F64656C2E6765745265636F72644964286572726F725265634D657461417272';
wwv_flow_imp.g_varchar2_table(430) := '5B305D2E7265636F7264293B0D0A2020202020202020202020206C65742073696E676C65526F775669657724203D20617065782E726567696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E73696E676C6552';
wwv_flow_imp.g_varchar2_table(431) := '6F7756696577243B0D0A20202020202020202020202073696E676C65526F7756696577242E7265636F7264566965772827676F746F4669656C64272C207265636F72644964293B0D0A20202020202020207D0D0A2020202020202020656C73650D0A2020';
wwv_flow_imp.g_varchar2_table(432) := '2020202020207B0D0A2020202020202020202020206C6574206D6F64656C4C697374203D20617065782E6D6F64656C2E6C6973742866616C73652C206F684D6F64656C2E4D6F64656C49642C2074727565293B0D0A202020202020202020202020666F72';
wwv_flow_imp.g_varchar2_table(433) := '20286D6F64656C496E73744964206F66206D6F64656C4C697374290D0A2020202020202020202020207B0D0A202020202020202020202020202020206966202841727261792E69734172726179286D6F64656C496E7374496429290D0A20202020202020';
wwv_flow_imp.g_varchar2_table(434) := '2020202020202020207B0D0A20202020202020202020202020202020202020206C6574206F6C4D6F64656C203D20617065782E6D6F64656C2E676574286D6F64656C496E73744964293B0D0A20202020202020202020202020202020202020206C657420';
wwv_flow_imp.g_varchar2_table(435) := '6861734572726F7273203D206F6C4D6F64656C2E6861734572726F727328293B0D0A2020202020202020202020202020202020202020617065782E6D6F64656C2E72656C65617365286D6F64656C496E73744964293B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(436) := '2020202020202020696620286861734572726F7273290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206C65742073696E676C65526F775669657724203D20617065782E726567';
wwv_flow_imp.g_varchar2_table(437) := '696F6E2869675374617469634964292E63616C6C2827676574566965777327292E677269642E73696E676C65526F7756696577243B0D0A20202020202020202020202020202020202020202020202073696E676C65526F7756696577242E7265636F7264';
wwv_flow_imp.g_varchar2_table(438) := '566965772827676F746F4669656C64272C206D6F64656C496E737449645B315D293B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D0A20202020202020';
wwv_flow_imp.g_varchar2_table(439) := '207D20202020202020200D0A202020207D0D0A0D0A2020202072657475726E7B0D0A20202020202020205F696E69743A20696E69742C0D0A2020202020202020696E697449473A20696E697449472C0D0A20202020202020206869646547726F75703A20';
wwv_flow_imp.g_varchar2_table(440) := '726F77566965774D6F64756C652E6869646547726F75702C0D0A202020202020202073686F7747726F75703A20726F77566965774D6F64756C652E73686F7747726F75702C0D0A20202020202020206D617374657244657461696C5361766543616C6C53';
wwv_flow_imp.g_varchar2_table(441) := '65727665723A206D617374657244657461696C5361766543616C6C5365727665722C0D0A202020202020202076616C69646174653A2076616C69646174652C0D0A2020202020202020676F746F416E794572726F723A20676F746F416E794572726F720D';
wwv_flow_imp.g_varchar2_table(442) := '0A202020207D0D0A7D2928617065782E6A5175657279293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(29748777688629257)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_file_name=>'js/ig-singlerow.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '77696E646F772E6C696234783D77696E646F772E6C696234787C7C7B7D2C77696E646F772E6C696234782E6178743D77696E646F772E6C696234782E6178747C7C7B7D2C77696E646F772E6C696234782E6178742E69673D77696E646F772E6C69623478';
wwv_flow_imp.g_varchar2_table(2) := '2E6178742E69677C7C7B7D2C6C696234782E6178742E69672E73696E676C65526F773D66756E6374696F6E2865297B636F6E737420743D22612D52562D626F6479222C6F3D22612D436F6C6C61707369626C65222C693D22752D466F726D222C723D2275';
wwv_flow_imp.g_varchar2_table(3) := '2D466F726D2D67726F757048656164696E67222C6E3D226C696234782D73617276222C6C3D2266697273742D7265636F7264222C643D226C6173742D7265636F7264222C613D224D454E55222C633D22616374696F6E223B6C657420733D7B7D2C673D66';
wwv_flow_imp.g_varchar2_table(4) := '756E6374696F6E28297B66756E6374696F6E206128297B652E7769646765742822617065782E7265636F726456696577222C652E617065782E7265636F7264566965772C7B5F7570646174655265636F726453746174653A66756E6374696F6E28297B72';
wwv_flow_imp.g_varchar2_table(5) := '657475726E20746869732E656C656D656E742E636C6F7365737428222E222B6E292E6C656E677468262666756E6374696F6E2865297B6C657420743D652E7265636F72645669657728226765744D6F64656C22292C6F3D652E7265636F72645669657728';
wwv_flow_imp.g_varchar2_table(6) := '226765745265636F726422292C693D742E6765745265636F72644964286F292C723D742E6765745265636F72644D657461646174612869292C6E3D22223B722E64656C657465643F6E3D617065782E6C616E672E6765744D657373616765282241504558';
wwv_flow_imp.g_varchar2_table(7) := '2E47562E524F575F44454C4554454422293A722E696E7365727465643F6E3D617065782E6C616E672E6765744D6573736167652822415045582E47562E524F575F414444454422293A722E757064617465642626286E3D617065782E6C616E672E676574';
wwv_flow_imp.g_varchar2_table(8) := '4D6573736167652822415045582E47562E524F575F4348414E4745442229293B6C6574206C3D742E6765744F7074696F6E2822726567696F6E537461746963496422292C643D617065782E726567696F6E286C292E63616C6C2822676574546F6F6C6261';
wwv_flow_imp.g_varchar2_table(9) := '7222293B642626642E6C656E6774682626642E746F6F6C626172282266696E64456C656D656E74222C2273746174757322292E74657874286E297D28746869732E656C656D656E74292C746869732E5F737570657228297D2C5F75706461746541637469';
wwv_flow_imp.g_varchar2_table(10) := '6F6E733A66756E6374696F6E28297B696628746869732E656C656D656E742E636C6F7365737428222E222B6E292E6C656E677468297B6C6574206F3D746869732E656C656D656E742E7265636F72645669657728226765745265636F726422292C693D74';
wwv_flow_imp.g_varchar2_table(11) := '6869732E656C656D656E742E7265636F7264566965772822676574416374696F6E7322293B66756E6374696F6E206528652C74297B695B653F22656E61626C65223A2264697361626C65225D2874297D65286F2626746869732E5F6861734E6578742829';
wwv_flow_imp.g_varchar2_table(12) := '2C64292C65286F2626746869732E5F68617350726576696F757328292C6C292C65286F2C22726566726573682D7265636F726422297D6C657420743D746869732E5F737570657228293B696628746869732E656C656D656E742E636C6F7365737428222E';
wwv_flow_imp.g_varchar2_table(13) := '222B6E292E6C656E677468297B6C657420723D7B7D3B722E6D6F64656C3D746869732E656C656D656E742E7265636F72645669657728226765744D6F64656C22292C722E7265636F72643D746869732E656C656D656E742E7265636F7264566965772822';
wwv_flow_imp.g_varchar2_table(14) := '6765745265636F726422292C722E7265636F726449643D6E756C6C2C722E7265636F7264262628722E7265636F726449643D722E6D6F64656C2E6765745265636F7264496428722E7265636F726429292C722E616374696F6E733D746869732E656C656D';
wwv_flow_imp.g_varchar2_table(15) := '656E742E7265636F7264566965772822676574416374696F6E7322292C617065782E6576656E742E7472696767657228746869732E656C656D656E742C226C696234785F69675F72765F7570646174655F616374696F6E73222C72297D72657475726E20';
wwv_flow_imp.g_varchar2_table(16) := '747D2C726566726573683A66756E6374696F6E2865297B6C657420743D746869732E5F737570657228293B72657475726E20746869732E656C656D656E742E636C6F7365737428222E222B6E292E6C656E67746826266328746869732E656C656D656E74';
wwv_flow_imp.g_varchar2_table(17) := '292C747D7D297D66756E6374696F6E20632869297B6C6574206C3D692E636C6F7365737428222E222B6E292E617474722822696422293B224649454C445F47524F55505F434F4C554D4E53223D3D735B6C5D2E636F6C756D6E734C61796F757426266675';
wwv_flow_imp.g_varchar2_table(18) := '6E6374696F6E2869297B6C657420723D692E66696E642822202E222B74293B722E66696E642822202E222B6F292E6C656E677468262628722E66696E642822202E222B6F292E6869646528292C722E616464436C6173732822752D666C657822292C722E';
wwv_flow_imp.g_varchar2_table(19) := '66696E642822202E612D436F6C6C61707369626C652D636F6E74656E7422292E65616368282866756E6374696F6E28297B652874686973292E616464436C6173732822752D666C65782D67726F772D3122297D2929297D2869292C66756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(20) := '6F297B6F2E66696E642822202E222B742B22202E222B722B2220627574746F6E22292E65616368282866756E6374696F6E28297B652874686973292E617474722822746162696E646578222C222D3122297D29297D2869297D652E617065782E7265636F';
wwv_flow_imp.g_varchar2_table(21) := '72645669657726266128292C646F63756D656E742E676574456C656D656E747342795461674E616D652822626F647922295B305D2E6164644576656E744C697374656E657228226C6F6164222C2866756E6374696F6E2865297B69662822534352495054';
wwv_flow_imp.g_varchar2_table(22) := '223D3D3D652E7461726765742E6E6F64654E616D65297B6C657420743D652E7461726765742E676574417474726962757465282273726322293B742626742E696E636C7564657328227769646765742E7265636F726456696577222926266128297D7D29';
wwv_flow_imp.g_varchar2_table(23) := '2C2130293B6C657420673D66756E6374696F6E28652C74297B6C6574206F3D742E636C6F7365737428222E222B6E292E617474722822696422292C693D735B6F5D3B742E697328223A76697369626C652229262628224649454C445F434F4C554D4E535F';
wwv_flow_imp.g_varchar2_table(24) := '5350414E223D3D692E636F6C756D6E734C61796F75743F66756E6374696F6E28652C74297B6C6574206F3D652E7265636F72645669657728226F7074696F6E222C226669656C647322293B6966286F26266F2E6C656E677468297B666F7228636F6E7374';
wwv_flow_imp.g_varchar2_table(25) := '5B652C695D6F66204F626A6563742E656E7472696573286F5B305D292E66696C7465722828285B652C745D293D3E742E656C656D656E744964292929692E6669656C64436F6C5370616E3D743B652E7265636F7264566965772822726566726573684669';
wwv_flow_imp.g_varchar2_table(26) := '656C647322292C652E7265636F72645669657728227265667265736822297D7D28742C692E6663735F7370616E5769647468293A63287429292C742E7265636F72645669657728226F7074696F6E222C22746F6F6C626172222C6E756C6C292C742E6F6E';
wwv_flow_imp.g_varchar2_table(27) := '28227265636F7264766965777265636F72646368616E6765222C2866756E6374696F6E286F2C69297B6C657420723D617065782E726567696F6E2865292E63616C6C2822676574546F6F6C62617222293B696628722626722E6C656E677468297B6C6574';
wwv_flow_imp.g_varchar2_table(28) := '20653D742E7265636F72645669657728226765744D6F64656C22292C6F3D742E7265636F72645669657728226F7074696F6E222C227265636F72644F666673657422292C693D652E676574546F74616C5265636F72647328292C6E3D22223B6E3D693E30';
wwv_flow_imp.g_varchar2_table(29) := '3F6F2B312B222F222B693A6F2B312C722E746F6F6C626172282266696E64456C656D656E74222C227265636F72644E756D62657222292E74657874286E297D7D29297D3B72657475726E7B696E69743A66756E6374696F6E2874297B65282223222B7429';
wwv_flow_imp.g_varchar2_table(30) := '2E6F6E2822696E74657261637469766567726964766965776D6F64656C637265617465222C2866756E6374696F6E28652C74297B6C6574206F3D742E6D6F64656C3B6F2E737562736372696265287B6F6E4368616E67653A66756E6374696F6E28652C74';
wwv_flow_imp.g_varchar2_table(31) := '297B69662822696E73657274223D3D657C7C22726576657274223D3D65297B6C657420653D6F2E6765744F7074696F6E28226964656E746974794669656C6422293B696628652E6C656E677468297B6C657420693D2254454D505F222B655B305D3B6966';
wwv_flow_imp.g_varchar2_table(32) := '286F2E6765744F7074696F6E28226669656C647322292E6861734F776E50726F7065727479286929297B6C657420723D742E7265636F7264737C7C5B742E7265636F72645D3B666F72286C65742074206F662072296966286F2E6765745265636F72644D';
wwv_flow_imp.g_varchar2_table(33) := '65746164617461286F2E6765745265636F72644964287429292E696E736572746564297B6C657420723D6F2E67657456616C756528742C655B305D293B6F2E73657456616C756528742C692C72297D7D7D7D696628226D6574614368616E6765223D3D65';
wwv_flow_imp.g_varchar2_table(34) := '2626742E7265636F726449642626742E70726F70657274792626742E70726F70657274792E696E636C7564657328226D65737361676522292626742E70726F70657274792E696E636C7564657328226572726F722229297B6C657420653D6F2E67657452';
wwv_flow_imp.g_varchar2_table(35) := '65636F72644D6574616461746128742E7265636F72644964293B6F2E616C6C6F774564697428742E7265636F7264297C7C752E7574696C2E7265636F72644669656C647356616C69642865293F617065782E7574696C2E676574546F704170657828292E';
wwv_flow_imp.g_varchar2_table(36) := '6A517565727928222E75692D6469616C6F672D706F7075706C6F762C202E75692D6469616C6F672D646174657069636B657222292E697328223A76697369626C65222926266F2E73657456616C6964697479282276616C6964222C742E7265636F726449';
wwv_flow_imp.g_varchar2_table(37) := '642C742E6669656C64293A752E7574696C2E7365745265636F72644669656C647356616C6964286F2C742E7265636F7264297D7D7D297D29292C6528617065782E6750616765436F6E7465787424292E6F6E2822617065787265616479656E64222C2866';
wwv_flow_imp.g_varchar2_table(38) := '756E6374696F6E286F297B6C657420693D65282223222B742B22202E612D494722292E666972737428293B696628692E6C656E677468297B6C657420743D692E696E7465726163746976654772696428226F7074696F6E22292E636F6E6669672E726567';
wwv_flow_imp.g_varchar2_table(39) := '696F6E53746174696349642C6F3D692E696E746572616374697665477269642822676574566965777322292E677269642E73696E676C65526F7756696577243B6728742C6F293B6C657420723D617065782E726567696F6E2874292E63616C6C28226765';
wwv_flow_imp.g_varchar2_table(40) := '74416374696F6E7322292E6C6F6F6B75702822696E736572742D7265636F726422293B72262628722E616374696F6E3D66756E6374696F6E28297B6C657420653D617065782E726567696F6E2874292E77696467657428292E696E746572616374697665';
wwv_flow_imp.g_varchar2_table(41) := '477269642822676574566965777322292E677269642E73696E676C65526F7756696577243B696628652E7265636F72645669657728226F7074696F6E222C226564697461626C652229297B6C657420743D652E7265636F72645669657728226765744D6F';
wwv_flow_imp.g_varchar2_table(42) := '64656C22292C6F3D652E7265636F7264566965772822676574416374696F6E7322293B72657475726E20742E696E736572744E65775265636F726428292C6F2E696E766F6B65286C292C652E7265636F7264566965772822666F63757322292C652E7265';
wwv_flow_imp.g_varchar2_table(43) := '636F7264566965772822696E456469744D6F646522297C7C652E7265636F7264566965772822736574456469744D6F6465222C2130292C21307D7D293B6C6574206E3D617065782E726567696F6E2874292E63616C6C2822676574416374696F6E732229';
wwv_flow_imp.g_varchar2_table(44) := '2E6C6F6F6B757028227265766572742D7265636F726422293B6966286E297B6C657420653D6E2E616374696F6E3B6E2E616374696F6E3D66756E6374696F6E28297B6528293B6C657420743D6F2E7265636F72645669657728226765744D6F64656C2229';
wwv_flow_imp.g_varchar2_table(45) := '2C693D6F2E7265636F72645669657728226765745265636F726422292C723D742E6765745265636F726449642869292C6E3D742E6765745265636F72644D657461646174612872293B752E7574696C2E7265636F72644669656C647356616C6964286E29';
wwv_flow_imp.g_varchar2_table(46) := '7C7C752E7574696C2E7365745265636F72644669656C647356616C696428742C69297D7D65282223222B74292E6F6E2822696E7465726163746976656772696473617665222C2866756E6374696F6E28652C74297B6C657420693D6F2E7265636F726456';
wwv_flow_imp.g_varchar2_table(47) := '69657728226765744D6F64656C22292C723D6F2E7265636F72645669657728226765745265636F726422292C6E3D692E6765745265636F726449642872293B752E7574696C2E7265636F7264497356616C696428692C6E297C7C6F2E7265636F72645669';
wwv_flow_imp.g_varchar2_table(48) := '657728227265667265736822297D29297D7D29297D2C61646A75737452563A672C6869646547726F75703A66756E6374696F6E286F2C6E297B6C6574206C3D65282223222B6F2B22202E222B742B222023222B6E2B225F434F4E5441494E455222293B6C';
wwv_flow_imp.g_varchar2_table(49) := '2E636C6F7365737428222E222B72292E6869646528292C6C2E706172656E7428292E70726576416C6C28222E752D466F726D2D67726F757048656164696E6722292E666972737428292E6869646528292C6C2E636C6F7365737428222E222B69292E6869';
wwv_flow_imp.g_varchar2_table(50) := '646528297D2C73686F7747726F75703A66756E6374696F6E286F2C6E297B6C6574206C3D65282223222B6F2B22202E222B742B222023222B6E2B225F434F4E5441494E455222293B6C2E636C6F7365737428222E222B72292E73686F7728292C6C2E7061';
wwv_flow_imp.g_varchar2_table(51) := '72656E7428292E70726576416C6C28222E752D466F726D2D67726F757048656164696E6722292E666972737428292E73686F7728292C6C2E636C6F7365737428222E222B69292E73686F7728297D7D7D28292C753D7B7574696C3A7B7265636F72644669';
wwv_flow_imp.g_varchar2_table(52) := '656C647356616C69643A66756E6374696F6E2865297B6C657420743D21303B69662865297B6C6574206F3D652E6669656C64733B6966286F29666F7228636F6E7374206520696E206F296966286F5B655D2E6572726F72297B743D21313B627265616B7D';
wwv_flow_imp.g_varchar2_table(53) := '7D72657475726E20747D2C7265636F7264497356616C69643A66756E6374696F6E28652C74297B6C6574206F3D652E6765745265636F72644D657461646174612874293B72657475726E216F2E6572726F722626746869732E7265636F72644669656C64';
wwv_flow_imp.g_varchar2_table(54) := '7356616C6964286F297D2C7365745265636F72644669656C647356616C69643A66756E6374696F6E28652C74297B6C6574206F3D652E6765745265636F726449642874292C693D652E6765745265636F72644D65746164617461286F293B69662869297B';
wwv_flow_imp.g_varchar2_table(55) := '6C657420743D692E6669656C64733B6966287429666F7228636F6E7374206920696E207429745B695D2E6572726F722626652E73657456616C6964697479282276616C6964222C6F2C69297D7D7D7D3B72657475726E7B5F696E69743A66756E6374696F';
wwv_flow_imp.g_varchar2_table(56) := '6E28742C6F2C692C722C6C2C64297B617065782E6C616E672E6164644D65737361676573287B224C494234582E4552562E434F4C5F4558505F475250223A22436F6C6C617073652F457870616E642047726F757073222C224C494234582E4552562E434F';
wwv_flow_imp.g_varchar2_table(57) := '4C5F475250223A22436F6C6C617073652047726F757073222C224C494234582E4552562E4558505F475250223A22457870616E642047726F757073227D292C65282223222B74292E616464436C617373286E292C72262665282223222B74292E61646443';
wwv_flow_imp.g_varchar2_table(58) := '6C61737328226C696234782D666F726D2D6C6162656C2D77696474682D222B72293B6C657420613D7B7D3B612E627574746F6E73436F6E663D642C612E636F6C756D6E734C61796F75743D6F7C7C224E4F4E45222C224649454C445F434F4C554D4E535F';
wwv_flow_imp.g_varchar2_table(59) := '5350414E223D3D6F262628612E6663735F7370616E57696474683D693F7061727365496E742869293A36292C612E6D61784F6E654E6577526F773D6C2C735B745D3D612C672E696E69742874297D2C696E697449473A66756E6374696F6E2874297B6C65';
wwv_flow_imp.g_varchar2_table(60) := '7420693D742E726567696F6E53746174696349642C723D65282223222B69292E636C6F7365737428222E222B6E292E617474722822696422292C673D735B725D2C753D672E627574746F6E73436F6E663B66756E6374696F6E207028652C74297B6C6574';
wwv_flow_imp.g_varchar2_table(61) := '206F3D617065782E726567696F6E2865292E77696467657428292E696E746572616374697665477269642822676574566965777322292E677269642E6D6F64656C2E676574546F74616C5265636F72647328293B6F26266F3E302626617065782E726567';
wwv_flow_imp.g_varchar2_table(62) := '696F6E2865292E77696467657428292E696E746572616374697665477269642822676574566965777322292E677269642E73696E676C65526F7756696577242E7265636F72645669657728226F7074696F6E222C227265636F72644F6666736574222C22';
wwv_flow_imp.g_varchar2_table(63) := '6C617374223D3D743F6F2D313A30297D66756E6374696F6E206628652C742C6F297B747C7C652E746F6F6C62617252656D6F7665286F297D617065782E7574696C2E6765744E65737465644F626A65637428742C2276696577732E677269642E66656174';
wwv_flow_imp.g_varchar2_table(64) := '7572657322292E67726964566965773D21312C617065782E7574696C2E6765744E65737465644F626A65637428742C2264656661756C7453696E676C65526F774F7074696F6E732E70726F67726573734F7074696F6E7322292E66697865643D21312C74';
wwv_flow_imp.g_varchar2_table(65) := '2E696E6974416374696F6E733D66756E6374696F6E2872297B722E616464285B7B6E616D653A6C2C6C6162656C3A224669727374222C616374696F6E3A66756E6374696F6E28297B7028692C22666972737422297D7D2C7B6E616D653A642C6C6162656C';
wwv_flow_imp.g_varchar2_table(66) := '3A224C617374222C616374696F6E3A66756E6374696F6E28297B7028692C226C61737422297D7D2C7B6E616D653A226C696234782D746F67676C652D636F6C6C61707369626C6573222C6C6162656C4B65793A224C494234582E4552562E434F4C5F4558';
wwv_flow_imp.g_varchar2_table(67) := '505F475250222C6F6E4C6162656C4B65793A224C494234582E4552562E434F4C5F475250222C6F66664C6162656C4B65793A224C494234582E4552562E4558505F475250222C69636F6E3A2266612066612D657870616E642D636F6C6C61707365222C65';
wwv_flow_imp.g_varchar2_table(68) := '7870616E6465643A21302C7365743A66756E6374696F6E2869297B746869732E657870616E6465643D692C65282223222B742E726567696F6E53746174696349642B22202E222B6F292E636F6C6C61707369626C6528693F22657870616E64223A22636F';
wwv_flow_imp.g_varchar2_table(69) := '6C6C6170736522297D2C6765743A66756E6374696F6E28297B72657475726E20746869732E657870616E6465647D7D5D297D3B6C657420773D652E617065782E696E746572616374697665477269642E636F707944656661756C74546F6F6C6261722829';
wwv_flow_imp.g_varchar2_table(70) := '3B742E66656174757265733F2E736176655265706F72743F2E6973446576656C6F7065723F772E746F6F6C626172496E7365727441667465722822616374696F6E7331222C7B69643A226C696234785F616374696F6E7331222C636F6E74726F6C733A5B';
wwv_flow_imp.g_varchar2_table(71) := '7B747970653A612C69643A22616374696F6E735F627574746F6E222C6C6162656C4B65793A22415045582E49472E414354494F4E53222C6D656E753A7B6974656D733A5B7B747970653A632C616374696F6E3A2273686F772D636F6C756D6E732D646961';
wwv_flow_imp.g_varchar2_table(72) := '6C6F67222C6C6162656C3A22436F6C756D6E7320284669656C647329227D2C7B747970653A22736570617261746F72227D2C7B747970653A632C616374696F6E3A2273686F772D66696C7465722D6469616C6F67227D2C7B747970653A227375624D656E';
wwv_flow_imp.g_varchar2_table(73) := '75222C69643A22646174615F7375626D656E75222C6C6162656C4B65793A22415045582E49472E44415441222C69636F6E3A2269636F6E2D69672D64617461222C6D656E753A7B6974656D733A5B7B747970653A632C616374696F6E3A2273686F772D73';
wwv_flow_imp.g_varchar2_table(74) := '6F72742D6469616C6F67227D2C7B747970653A632C616374696F6E3A2272656672657368227D5D7D7D2C7B747970653A22736570617261746F72227D2C7B747970653A632C616374696F6E3A22736176652D7265706F7274222C6C6162656C3A22536176';
wwv_flow_imp.g_varchar2_table(75) := '652044656661756C74205265706F7274227D2C7B747970653A632C616374696F6E3A2272657365742D7265706F7274222C6C6162656C3A225265736574205265706F7274227D5D7D7D5D7D293A772E746F6F6C626172496E736572744166746572282261';
wwv_flow_imp.g_varchar2_table(76) := '6374696F6E7331222C7B69643A226C696234785F616374696F6E7331222C636F6E74726F6C733A5B7B747970653A612C69643A22616374696F6E735F627574746F6E222C6C6162656C4B65793A22415045582E49472E414354494F4E53222C6D656E753A';
wwv_flow_imp.g_varchar2_table(77) := '7B6974656D733A5B7B747970653A632C616374696F6E3A2273686F772D66696C7465722D6469616C6F67227D2C7B747970653A227375624D656E75222C69643A22646174615F7375626D656E75222C6C6162656C4B65793A22415045582E49472E444154';
wwv_flow_imp.g_varchar2_table(78) := '41222C69636F6E3A2269636F6E2D69672D64617461222C6D656E753A7B6974656D733A5B7B747970653A632C616374696F6E3A2273686F772D736F72742D6469616C6F67227D2C7B747970653A632C616374696F6E3A2272656672657368227D5D7D7D5D';
wwv_flow_imp.g_varchar2_table(79) := '7D7D5D7D292C772E746F6F6C626172496E7365727441667465722822616374696F6E7332222C7B69643A226C696234785F616374696F6E7332222C636F6E74726F6C733A5B7B616374696F6E3A22696E736572742D7265636F7264222C6C6162656C3A22';
wwv_flow_imp.g_varchar2_table(80) := '41646420526F77222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D6164642D726F77227D2C7B616374696F6E3A226475706C69636174652D7265636F7264222C6C6162656C3A224475706C696361';
wwv_flow_imp.g_varchar2_table(81) := '746520526F77222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D6475706C6963617465227D2C7B616374696F6E3A2264656C6574652D7265636F7264222C6C6162656C3A2252656D6F766520526F';
wwv_flow_imp.g_varchar2_table(82) := '77222C747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D64656C657465227D2C7B616374696F6E3A227265766572742D7265636F7264222C6C6162656C3A22526576657274204368616E676573222C74';
wwv_flow_imp.g_varchar2_table(83) := '7970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D726576657274227D2C7B616374696F6E3A22726566726573682D7265636F7264222C6C6162656C3A225265667265736820526F77222C747970653A2242';
wwv_flow_imp.g_varchar2_table(84) := '5554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D69672D72656672657368227D5D7D292C772E746F6F6C626172496E73657274416674657228226C696234785F616374696F6E7332222C7B69643A226C696234785F706167696E';
wwv_flow_imp.g_varchar2_table(85) := '6174696F6E222C616C69676E3A22656E64222C636F6E74726F6C733A5B7B747970653A22535441544943222C69643A22737461747573222C6C6162656C3A22227D2C7B747970653A22425554544F4E222C6C6162656C3A22457870616E642F436F6C6C61';
wwv_flow_imp.g_varchar2_table(86) := '707365222C69636F6E4F6E6C793A21302C616374696F6E3A226C696234782D746F67676C652D636F6C6C61707369626C6573227D2C7B747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D6669727374222C6163';
wwv_flow_imp.g_varchar2_table(87) := '74696F6E3A2266697273742D7265636F7264227D2C7B747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D70726576222C616374696F6E3A2270726576696F75732D7265636F7264227D2C7B747970653A225354';
wwv_flow_imp.g_varchar2_table(88) := '41544943222C69643A227265636F72644E756D626572222C6C6162656C3A22227D2C7B747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D6E657874222C616374696F6E3A226E6578742D7265636F7264227D2C';
wwv_flow_imp.g_varchar2_table(89) := '7B747970653A22425554544F4E222C69636F6E4F6E6C793A21302C69636F6E3A2269636F6E2D6C617374222C616374696F6E3A226C6173742D7265636F7264227D5D7D292C772E746F6F6C62617252656D6F766528227265706F72747322292C772E746F';
wwv_flow_imp.g_varchar2_table(90) := '6F6C62617252656D6F76652822766965777322292C772E746F6F6C62617252656D6F76652822616374696F6E733122292C772E746F6F6C62617252656D6F76652822616374696F6E733322292C772E746F6F6C62617252656D6F76652822616374696F6E';
wwv_flow_imp.g_varchar2_table(91) := '733422292C752E726F77416374696F6E427574746F6E733F286628772C752E616464526F772C22696E736572742D7265636F726422292C6628772C752E6475706C6963617465526F772C226475706C69636174652D7265636F726422292C6628772C752E';
wwv_flow_imp.g_varchar2_table(92) := '64656C657465526F772C2264656C6574652D7265636F726422292C6628772C752E72656672657368526F772C22726566726573682D7265636F726422292C6628772C752E726576657274526F772C227265766572742D7265636F72642229293A772E746F';
wwv_flow_imp.g_varchar2_table(93) := '6F6C62617252656D6F766528226C696234785F616374696F6E733222292C6628772C752E65646974262621742E64656661756C7453696E676C65526F774F7074696F6E732E616C77617973456469742C226564697422292C752E706167696E6174696F6E';
wwv_flow_imp.g_varchar2_table(94) := '427574746F6E733F752E66697273744C6173747C7C286628772C21312C2266697273742D7265636F726422292C6628772C21312C226C6173742D7265636F72642229293A286628772C21312C2266697273742D7265636F726422292C6628772C21312C22';
wwv_flow_imp.g_varchar2_table(95) := '70726576696F75732D7265636F726422292C6628772C21312C227265636F72644E756D62657222292C6628772C21312C226E6578742D7265636F726422292C6628772C21312C226C6173742D7265636F72642229293B6C657420623D21313B6966282246';
wwv_flow_imp.g_varchar2_table(96) := '49454C445F47524F55505F434F4C554D4E5322213D672E636F6C756D6E734C61796F7574297B742E636F6C756D6E732E66696C7465722828653D3E652E6C61796F75743F2E67726F7570496429292E6C656E6774683E30262628623D2130297D72657475';
wwv_flow_imp.g_varchar2_table(97) := '726E20627C7C6628772C21312C226C696234782D746F67676C652D636F6C6C61707369626C657322292C742E746F6F6C626172446174613D772C742E64656661756C744D6F64656C4F7074696F6E733D7B636865636B3A28652C742C6F2C722C6E293D3E';
wwv_flow_imp.g_varchar2_table(98) := '7B696628652626672E6D61784F6E654E6577526F7726262263616E416464223D3D74297B6C657420743D617065782E726567696F6E2869292E63616C6C2822676574566965777322292E677269642E6D6F64656C3B74262628653D2128742E6765744368';
wwv_flow_imp.g_varchar2_table(99) := '616E67657328292E66696C7465722828653D3E652E696E73657274656429292E6C656E6774683E3029297D72657475726E20657D7D2C747D2C6869646547726F75703A672E6869646547726F75702C73686F7747726F75703A672E73686F7747726F7570';
wwv_flow_imp.g_varchar2_table(100) := '2C6D617374657244657461696C5361766543616C6C5365727665723A66756E6374696F6E28652C74297B6C6574206F3D617065782E7365727665722E706C7567696E28652C74293B72657475726E206F2E646F6E652828653D3E7B696628323D3D652E72';
wwv_flow_imp.g_varchar2_table(101) := '6567696F6E733F2E6C656E677468297B636F6E737420743D7B7D3B652E726567696F6E735B305D2E66657463686564446174612E6D6F64656C735B305D2E76616C7565732E666F72456163682828653D3E7B636F6E7374206F3D655B305D2C693D655B65';
wwv_flow_imp.g_varchar2_table(102) := '2E6C656E6774682D315D2E7265636F726449643B745B695D3D6F7D29292C652E726567696F6E735B315D2E66657463686564446174612E6D6F64656C732E666F72456163682828653D3E7B636F6E7374206F3D652E696E7374616E63653B742E6861734F';
wwv_flow_imp.g_varchar2_table(103) := '776E50726F7065727479286F29262628652E696E7374616E63653D745B6F5D297D29297D7D29292C6F7D2C76616C69646174653A66756E6374696F6E2865297B6C657420743D617065782E726567696F6E2865292E63616C6C2822676574566965777322';
wwv_flow_imp.g_varchar2_table(104) := '292E677269642E73696E676C65526F7756696577242C6F3D742E7265636F72645669657728226765744D6F64656C22292C693D742E7265636F72645669657728226765745265636F726422292C723D6F2E6765745265636F726449642869293B69662874';
wwv_flow_imp.g_varchar2_table(105) := '2E7265636F7264566965772822696E456469744D6F64652229297B6C657420653D742E7265636F72645669657728226F7074696F6E222C226669656C647322293B666F7228636F6E73745B742C695D6F66204F626A6563742E656E747269657328655B30';
wwv_flow_imp.g_varchar2_table(106) := '5D2929696628692E656C656D656E744964297B6C657420653D617065782E6974656D28692E656C656D656E744964293B69662821652E697344697361626C65642829297B69662821652E67657456616C696469747928292E76616C6964297B6C65742069';
wwv_flow_imp.g_varchar2_table(107) := '3D652E67657456616C69646174696F6E4D65737361676528293B6926266F2E73657456616C696469747928226572726F72222C722C742C69297D7D7D7D7D2C676F746F416E794572726F723A66756E6374696F6E2865297B6C657420743D617065782E72';
wwv_flow_imp.g_varchar2_table(108) := '6567696F6E2865292E63616C6C2822676574566965777322292E677269642E6D6F64656C2C6F3D742E6765744572726F727328293B6966286F2E6C656E677468297B6C657420693D742E6765745265636F72644964286F5B305D2E7265636F7264293B61';
wwv_flow_imp.g_varchar2_table(109) := '7065782E726567696F6E2865292E63616C6C2822676574566965777322292E677269642E73696E676C65526F7756696577242E7265636F7264566965772822676F746F4669656C64222C69297D656C73657B6C6574206F3D617065782E6D6F64656C2E6C';
wwv_flow_imp.g_varchar2_table(110) := '6973742821312C742E4D6F64656C49642C2130293B666F72286D6F64656C496E73744964206F66206F2969662841727261792E69734172726179286D6F64656C496E7374496429297B6C657420743D617065782E6D6F64656C2E676574286D6F64656C49';
wwv_flow_imp.g_varchar2_table(111) := '6E73744964292E6861734572726F727328293B696628617065782E6D6F64656C2E72656C65617365286D6F64656C496E73744964292C74297B617065782E726567696F6E2865292E63616C6C2822676574566965777322292E677269642E73696E676C65';
wwv_flow_imp.g_varchar2_table(112) := '526F7756696577242E7265636F7264566965772822676F746F4669656C64222C6D6F64656C496E737449645B315D297D7D7D7D7D7D28617065782E6A5175657279293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(34667758724437609)
,p_plugin_id=>wwv_flow_imp.id(29734975957629210)
,p_file_name=>'js/ig-singlerow.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
