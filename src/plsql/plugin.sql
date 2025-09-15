function get_attr_as_boolean(
    p_region in apex_plugin.t_region,
    p_attribute in varchar2
)
return boolean
is
    l_attribute varchar2(10);
begin
    l_attribute := p_region.attributes.get_varchar2(p_attribute);
    return (l_attribute is not null and l_attribute = 'Y');
end;

procedure render (
    p_plugin in            apex_plugin.t_plugin,
    p_region in            apex_plugin.t_region,
    p_param  in            apex_plugin.t_region_render_param,
    p_result in out nocopy apex_plugin.t_region_render_result )
is 
    l_region_id             varchar2(50);  
    l_columns_layout        varchar2(20);
    l_span_width            varchar2(20);
    l_form_label_width      varchar2(20);
    l_max_one_new_row       boolean;
    l_buttons_conf          varchar2(400);
    l_row_action_buttons    boolean;
    l_pagination_buttons    boolean;
begin
    if apex_application.g_debug then
        apex_plugin_util.debug_region(p_plugin => p_plugin, p_region => p_region);
    end if;
    l_region_id := apex_escape.html_attribute(p_region.static_id);
    l_columns_layout := p_region.attributes.get_varchar2('attr_columns_layout');
    l_span_width := p_region.attributes.get_varchar2('attr_span_width');
    l_form_label_width := p_region.attributes.get_varchar2('attr_form_label_width');
    l_max_one_new_row := get_attr_as_boolean(p_region, 'attr_max_one_new_row');

    l_row_action_buttons := get_attr_as_boolean(p_region, 'attr_row_action_buttons');
    l_buttons_conf := '{' || apex_javascript.add_attribute('rowActionButtons', l_row_action_buttons);
    if (l_row_action_buttons) then
        l_buttons_conf := l_buttons_conf || apex_javascript.add_attribute('addRow', get_attr_as_boolean(p_region, 'attr_add_row_button')) ||
            apex_javascript.add_attribute('duplicateRow', get_attr_as_boolean(p_region, 'attr_duplicate_row_button')) ||
            apex_javascript.add_attribute('deleteRow', get_attr_as_boolean(p_region, 'attr_delete_row_button')) ||
            apex_javascript.add_attribute('refreshRow', get_attr_as_boolean(p_region, 'attr_refresh_row_button')) ||
            apex_javascript.add_attribute('revertRow', get_attr_as_boolean(p_region, 'attr_revert_row_button'));
    end if;
    l_pagination_buttons := get_attr_as_boolean(p_region, 'attr_pagination_buttons');
    l_buttons_conf := l_buttons_conf || apex_javascript.add_attribute('edit', get_attr_as_boolean(p_region, 'attr_edit_button')) ||
        apex_javascript.add_attribute('paginationButtons', l_pagination_buttons, false, false);
    if (l_pagination_buttons) then
        l_buttons_conf := l_buttons_conf || ',' || apex_javascript.add_attribute('firstLast', get_attr_as_boolean(p_region, 'attr_first_last_buttons'), false, false);
    end if;
    l_buttons_conf := l_buttons_conf || '}';
 
    -- When specifying the library declaratively, it fails to load the minified version. So using the API:
    apex_javascript.add_library(
          p_name      => 'ig-singlerow',
          p_check_to_add_minified => true,
          --p_directory => '#WORKSPACE_FILES#javascript/',          
          p_directory => p_plugin.file_prefix || 'js/',
          p_version   => NULL
    );  

    apex_css.add_file (
        p_name => 'ig-singlerow',
        --p_directory => '#WORKSPACE_FILES#css/'
        p_directory => p_plugin.file_prefix || 'css/' 
    );    

    apex_javascript.add_onload_code(
        p_code => apex_string.format(
            'lib4x.axt.ig.singleRow._init("%s", "%s", "%s", "%s", %s, '
            , l_region_id
            , l_columns_layout
            , l_span_width
            , l_form_label_width
            , case l_max_one_new_row when true then 'true' else 'false' end
        ) || l_buttons_conf ||');'
    );    
end;
