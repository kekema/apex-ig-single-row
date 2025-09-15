window.lib4x = window.lib4x || {};
window.lib4x.axt = window.lib4x.axt || {};
window.lib4x.axt.ig = window.lib4x.axt.ig || {};

/*
 * Region plugin to display a single row at a time in a simple form layout, enabling
 * editing, navigating and refreshing data without page submits. The form can be made  
 * part of a Master-Detail setup, with support for single transaction.
 * The plugin is acting as a wrapper around an Interactive Grid. It does so
 * by configuring the IG to use Single Row View only and adjusting the toolbars as to have
 * one toolbar with crud and pagination buttons.
 * The plugin also has some extra features to the single row view as to enable setting 
 * field width, a button to expand/collapse field groups, a feature to enable field columns, 
 * and a feature to set the width of the labels.
 * Also, the plugin has some workarounds for issues in the APEX underlying recordView widget.
 * The IG to be made a sub region in the page designer.
 * For configurations in which the IG Single Row is used in a Master-Detail setting, the 
 * plugin offers support to implement Single Transaction.
 * By making use of IG Single Row Plugin, it also brings the benefit of the underlying AJAX
 * server communication, preventing need for page submits.
 */
lib4x.axt.ig.singleRow = (function($) {
    
    const C_RV_BODY = 'a-RV-body';
    const C_COLLAPSIBLE = 'a-Collapsible';
    const C_COLLAPSIBLE_CONTENT = 'a-Collapsible-content';
    const C_FLEX = 'u-flex';
    const C_FLEX_GROW_1 = 'u-flex-grow-1';
    const C_FORM = 'u-Form';
    const C_FORM_GROUP_HEADING = 'u-Form-groupHeading';
    const C_LIB4X_SARV = 'lib4x-sarv';  // sarv: standalone rowview (initial name for this plugin)
    const C_LIB4X_FORM_LABEL_WIDTH_PREFIX = 'lib4x-form-label-width-';
    const ACT_FIRST = 'first-record';
    const ACT_LAST = 'last-record';
    const TB_BUTTON = "BUTTON";
    const TB_MENU = "MENU";
    const ACTION = "action";
    const TOGGLE = "toggle";
    const RADIO_GROUP = "radioGroup";
    const SEPARATOR_MI = { type: "separator" };
    const ENABLE = "enable";
    const DISABLE = "disable";    

    let sarvOptions = {};           // plugin options and config

    let rowViewModule = (function() 
    {
        // Extending the underlying recordView widget as to be able to control
        // the toolbar (buttons) and making UI layout adjustments
        function extendRecordViewWidget()
        {
            $.widget("apex.recordView", $.apex.recordView, {
                // At the moment the recordView updates the record state, 
                // update the state in the toolbar
                _updateRecordState: function() {
                    if (this.element.closest('.' +  C_LIB4X_SARV).length)
                    {
                        updateToolbarRecordState(this.element);     // is singleRowView$
                    }
                    return this._super();
                },
                // called by APEX to determine the actual state of actions
                // and it's related buttons
                _updateActions: function() {
                    if (this.element.closest('.' +  C_LIB4X_SARV).length)
                    {
                        let curRec = this.element.recordView('getRecord');
                        let actions = this.element.recordView('getActions');
                        function toggle( predicate, action ) {
                            actions[predicate ? ENABLE : DISABLE]( action );
                        }
                        toggle( curRec && this._hasNext(), ACT_LAST );
                        toggle( curRec && this._hasPrevious(), ACT_FIRST );
                        toggle( curRec, 'refresh-record' );
                    }
                    let result = this._super();
                    if (this.element.closest('.' +  C_LIB4X_SARV).length)
                    {
                        let eventObj = {};
                        eventObj.model = this.element.recordView('getModel');
                        eventObj.record = this.element.recordView('getRecord');
                        eventObj.recordId = null;
                        if (eventObj.record)
                        {
                            eventObj.recordId = eventObj.model.getRecordId(eventObj.record);
                        }
                        eventObj.actions = this.element.recordView('getActions');
                        apex.event.trigger(this.element, 'lib4x_ig_rv_update_actions', eventObj);
                    }
                    return result;
                },
                // upon refresh, make layout adjustments as per the plugin options
                refresh: function(pFocus) {
                    let result = this._super();
                    if (this.element.closest('.' +  C_LIB4X_SARV).length)
                    {
                        adjustRvBody(this.element);
                    }
                    return result;
                }
            });         
        }

        if ($.apex.recordView)
        {
            // if loaded already, extend now, else await the load event
            extendRecordViewWidget();
        }   

        var bodyElem = document.getElementsByTagName("body")[0];
        bodyElem.addEventListener("load", function(event) {
            if (event.target.nodeName === "SCRIPT")
            {
                let srcAttr = event.target.getAttribute("src");
                // recordView subwidget
                if (srcAttr && srcAttr.includes('widget.recordView'))
                {
                    extendRecordViewWidget();
                }                 
            }
        }, true);   // usecapture is critical here    

        // will mention in the toolbar in case the current row was added or updated or deleted
        function updateToolbarRecordState(singleRowView$)
        {
            let model = singleRowView$.recordView('getModel');
            let record = singleRowView$.recordView('getRecord');
            let recordId = model.getRecordId(record);
            let meta = model.getRecordMetadata(recordId);
            let status = "";
            if ( meta.deleted ) {
                status = apex.lang.getMessage( "APEX.GV.ROW_DELETED" );
            } else if ( meta.inserted ) {
                status = apex.lang.getMessage( "APEX.GV.ROW_ADDED" );
            } else if ( meta.updated ) {
                status = apex.lang.getMessage( "APEX.GV.ROW_CHANGED" );
            }  
            let igStaticId = model.getOption('regionStaticId');
            let toolbar$ = apex.region(igStaticId).call('getToolbar');
            if (toolbar$ && toolbar$.length)
            {
                toolbar$.toolbar( "findElement", "status" ).text( status );   
            }          
        }

        // converts the rv body into a flex column layout as per the field groups definitions
        function applyFieldGroupColumns(singleRowView$)
        {
            let rvBody$ = singleRowView$.find(' .' + C_RV_BODY);
            if (rvBody$.find(' .' + C_COLLAPSIBLE).length)
            {
                rvBody$.find(' .' + C_COLLAPSIBLE).hide();
                rvBody$.addClass(C_FLEX);
                rvBody$.find(' .'+ C_COLLAPSIBLE_CONTENT).each(function(){$(this).addClass(C_FLEX_GROW_1)});      
            }         
        }

        function applyFieldColumnsSpan(singleRowView$, spanWidth)
        {
            let fields = singleRowView$.recordView('option', 'fields');
            if (fields && fields.length)    // is an array of one object with all fields
            {
                for (const [property, field] of Object.entries(fields[0]).filter(([key, val])=>(val.elementId)))
                {
                    field.fieldColSpan = spanWidth;
                }
                singleRowView$.recordView('refreshFields');
                singleRowView$.recordView('refresh');
            }
        }

        // adjust the rv body as per the plugin options
        function adjustRvBody(singleRowView$)
        {
            let wrpStaticId = singleRowView$.closest('.' + C_LIB4X_SARV).attr('id');
            let options = sarvOptions[wrpStaticId];
            // With group heading buttons, a recordView focus results in a focus on the button instead of the
            // first input field. To prevent, we set the buttons tabindex to '-1'.               
            if (options.columnsLayout == 'FIELD_GROUP_COLUMNS')            
            {
                applyFieldGroupColumns(singleRowView$);
            }
            makeGroupHeadingsNonTabbable(singleRowView$);
        }

        function makeGroupHeadingsNonTabbable(singleRowView$)
        {
            singleRowView$.find(' .' + C_RV_BODY + ' .' + C_FORM_GROUP_HEADING + ' button').each(function(){$(this).attr('tabindex', '-1')}); 
        }

        // group hide feature
        function hideGroup(rvStaticId, fieldStaticId)
        {
            let fieldContainer$ = $('#' + rvStaticId + ' .' + C_RV_BODY + ' #' + fieldStaticId + '_CONTAINER');
            fieldContainer$.closest('.' + C_FORM_GROUP_HEADING).hide();
            fieldContainer$.parent().prevAll('.u-Form-groupHeading').first().hide();
            fieldContainer$.closest('.' + C_FORM).hide();
        }

        // group show feature
        function showGroup(rvStaticId, fieldStaticId)
        {
            let fieldContainer$ = $('#' + rvStaticId + ' .' + C_RV_BODY + ' #' + fieldStaticId + '_CONTAINER');
            fieldContainer$.closest('.' + C_FORM_GROUP_HEADING).show();
            fieldContainer$.parent().prevAll('.u-Form-groupHeading').first().show();
            fieldContainer$.closest('.' + C_FORM).show();
        }        

        // adjust the rv as per the plugin options
        let adjustRV = function(igStaticId, singleRowView$)
        {
            let wrpStaticId = singleRowView$.closest('.' + C_LIB4X_SARV).attr('id');
            let options = sarvOptions[wrpStaticId];            
            if (singleRowView$.is(':visible'))
            {
                if (options.columnsLayout == 'FIELD_COLUMNS_SPAN')
                {
                    applyFieldColumnsSpan(singleRowView$, options.fcs_spanWidth)
                    // will lead to a refresh + adjustRvBody
                }
                else
                {
                    adjustRvBody(singleRowView$);
                }
            }
            singleRowView$.recordView('option', 'toolbar', null);
            singleRowView$.on('recordviewrecordchange', function( event, data ) {
                let toolbar$ = apex.region(igStaticId).call('getToolbar');
                if (toolbar$ && toolbar$.length)
                {
                    let model = singleRowView$.recordView('getModel');
                    // recordnumber
                    let recordOffset = singleRowView$.recordView('option', 'recordOffset');
                    let total = model.getTotalRecords();
                    let text = '';
                    if ( total > 0 ) 
                    {
                        //text = apex.lang.formatMessage( "APEX.RV.REC_XY", recordOffset + 1, total );
                        text = (recordOffset) + 1 + "/" + total;
                    } 
                    else 
                    {
                        //text = apex.lang.formatMessage( "APEX.RV.REC_X", o.recordOffset + 1 );
                        text = (recordOffset) + 1;
                    }
                    toolbar$.toolbar('findElement', 'recordNumber').text(text);                 
                }
            });
        } 
        
        // rowView init function
        let init = function(wrpStaticId)
        {
            // subscribe to model notifications of the wrapped IG (event bubbling)
            $('#' + wrpStaticId).on('interactivegridviewmodelcreate', function(jQueryEvent, data){
                let model = data.model;
                model.subscribe({
                    onChange: function(changeType, change) {
                        if ((changeType == 'insert') || (changeType == 'revert'))
                        {
                            // check if the model has a TEMP_<identityField> field
                            // if so, populate with the temp id (normally 't1000', 't1001', etc)
                            // this temp id can be used server-side for single-transaction support
                            let identityField = model.getOption('identityField');
                            if (identityField.length)
                            {
                                let tempIdField = 'TEMP_' + identityField[0];
                                if (model.getOption('fields').hasOwnProperty(tempIdField))
                                {
                                    let records = change.records || [change.record];
                                    for (let record of records)
                                    {
                                        if (model.getRecordMetadata(model.getRecordId(record)).inserted)
                                        {
                                            let tempId = model.getValue(record, identityField[0]);
                                            model.setValue(record, tempIdField, tempId);
                                        }
                                    }
                                }
                            }
                        }  
                        if (changeType == 'metaChange')
                        {
                            // Because of an APEX bug, incorrectly a validation error message is shown for a required field (which has a value anyway)
                            // in the situation where you start edit mode and the record is not allowed to be edited. Then, when you paginate to the
                            // next record, the validation error is shown on the field.
                            // To workarround this, we catch the related model notification ('metaChange' is 'message,error') and if the record 
                            // is not allowed to be edited, we clear the error.
                            if (change.recordId && change.property && change.property.includes('message') && change.property.includes('error'))
                            {
                                let recMetadata = model.getRecordMetadata(change.recordId);
                                if (!model.allowEdit(change.record) && !modelsModule.util.recordFieldsValid(recMetadata))
                                {
                                    modelsModule.util.setRecordFieldsValid(model, change.record);
                                }
                                else
                                {
                                    // in case of mandatory field validation error caused by opening a field dialog,
                                    // remove the validation message
                                    if (apex.util.getTopApex().jQuery('.ui-dialog-popuplov, .ui-dialog-datepicker').is(':visible'))
                                    {
                                        model.setValidity('valid', change.recordId, change.field);
                                    }                                    
                                }
                            }
                        }           
                    }
                });     
            });
            $(apex.gPageContext$).on("apexreadyend", function(jQueryEvent) {
                let ig$ = $('#' + wrpStaticId + ' .a-IG').first();
                if (ig$.length)
                {
                    let igStaticId = ig$.interactiveGrid('option').config.regionStaticId;
                    let singleRowView$ = ig$.interactiveGrid('getViews').grid.singleRowView$;
                    adjustRV(igStaticId, singleRowView$);

                    // There is a bug in recordView widget in which upon insert, recordView.focus() is
                    // executed twice on the first field. From this, if this field is mandatory, 
                    // immediatly a validation message is shown under the field. It only happens
                    // when the widget is not in edit mode yet. Also, the issue won't happen when
                    // the first control is a collapsible button as it puts (incorrectly) the focus
                    // on that button.
                    // So below we correct this by reverting the validity to 'valid'.
                    let insertAction = apex.region(igStaticId).call('getActions').lookup('insert-record');
                    if (insertAction)
                    {
                        insertAction.action = function() {
                            // custom 'insert-record' action as to insert always
                            // at the very beginning
                            // regular behavior of 'insert-record' is to insert after the current row
                            // however because of a bug in APEX, this gives issues when
                            // adding after the last row
                            let singleRowView$ = apex.region(igStaticId).widget().interactiveGrid('getViews').grid.singleRowView$;
                            if ( singleRowView$.recordView('option', 'editable') ) {
                                let model = singleRowView$.recordView('getModel');
                                let actions = singleRowView$.recordView('getActions');
                                model.insertNewRecord();
                                actions.invoke( ACT_FIRST );
                                singleRowView$.recordView('focus');                             
                                if ( !singleRowView$.recordView('inEditMode' )) {
                                    singleRowView$.recordView('setEditMode', true);
                                }
                                return true; // focus should have been set to first field
                            }
                        }                    
                    }

                    // There is a bug in APEX in  upon revert, any validation messages are not cleared,
                    // causing any save action to popup the 'Correct errors before saving' message.
                    // So below we correct this by clearing the validation errors after revert
                    let revertAction = apex.region(igStaticId).call('getActions').lookup('revert-record');
                    if (revertAction)
                    {
                        let origAction = revertAction.action;
                        revertAction.action = function() {    
                            origAction();
                            let model = singleRowView$.recordView('getModel');
                            let record = singleRowView$.recordView('getRecord');
                            let recordId = model.getRecordId(record);
                            let recMetadata = model.getRecordMetadata(recordId);
                            if (!modelsModule.util.recordFieldsValid(recMetadata))
                            {
                                modelsModule.util.setRecordFieldsValid(model, record);
                            }
                        };
                    };           
                    
                    // another workaround for an APEX bug
                    // upon save, any server-side validations which result in a field error,
                    // the error is not shown on the field (only on page level as a notification)
                    // the error is there though on the field metadata in the model
                    // to work arround, we refresh the SRV after save
                    $("#" + igStaticId).on("interactivegridsave", function( event, data ) {
                        let model = singleRowView$.recordView('getModel');
                        let record = singleRowView$.recordView('getRecord');
                        let recordId = model.getRecordId(record);
                        if (!modelsModule.util.recordIsValid(model, recordId))
                        {
                            singleRowView$.recordView('refresh');
                        }
                    });                
                }
            });
        }

        return{
            init: init,
            adjustRV: adjustRV,
            hideGroup: hideGroup,
            showGroup: showGroup
        }
    })();        
    
    // model util functions
    let modelsModule = (function() {
        let modelUtil = {
            recordFieldsValid: function(recMetadata)
            {
                let valid = true;
                if (recMetadata)
                {
                    let fields = recMetadata.fields;
                    if (fields)
                    {
                        for (const field in fields) 
                        {
                            if (fields[field].error)
                            {
                                valid = false;
                                break;
                            }
                        }
                    }
                }
                return valid;                
            },
            recordIsValid: function(model, recordId)
            {
                let recMetaData = model.getRecordMetadata(recordId);
                return (!recMetaData.error && this.recordFieldsValid(recMetaData));
            },
            setRecordFieldsValid: function(model, record)
            {
                let recordId = model.getRecordId(record);
                let recMetadata = model.getRecordMetadata(recordId);
                if (recMetadata)
                {
                    let fields = recMetadata.fields;
                    if (fields)
                    {
                        for (const field in fields) 
                        {
                            if (fields[field].error)
                            {
                                model.setValidity('valid', recordId, field);
                            }
                        }
                    }
                }                
            }
        };

        return{
            util: modelUtil
        }
    })();      
    
    function initMessages()
    {
        // here we have the labels and messages for which the developer should be 
        // able to config translations in APEX
        apex.lang.addMessages({
            'LIB4X.ERV.COL_EXP_GRP': 'Collapse/Expand Groups',
            'LIB4X.ERV.COL_GRP': 'Collapse Groups',
            'LIB4X.ERV.EXP_GRP': 'Expand Groups'
        });        
    }

    function getMessage(key) {
        return apex.lang.getMessage('LIB4X.ERV.' + key);
    }    

    /*
     * Main plugin init function
     */
    let init = function(wrpStaticId, columnsLayout, fcs_spanWidth, formLabelWidth, maxOneNewRow, buttonsConf)
    {
        initMessages();
        $('#'+wrpStaticId).addClass(C_LIB4X_SARV);
        if (formLabelWidth)
        {
            $('#'+wrpStaticId).addClass(C_LIB4X_FORM_LABEL_WIDTH_PREFIX + formLabelWidth);
        }
        let options = {};
        options.buttonsConf = buttonsConf;
        options.columnsLayout = columnsLayout ? columnsLayout : 'NONE';
        if (columnsLayout == 'FIELD_COLUMNS_SPAN')
        {
            options.fcs_spanWidth = fcs_spanWidth ? parseInt(fcs_spanWidth) : 6;
        }
        options.maxOneNewRow = maxOneNewRow;
        sarvOptions[wrpStaticId] = options;     
        rowViewModule.init(wrpStaticId);
    };

    // initIG to be called from the IG JavaScript Initialization Function
    let initIG = function(igConfig)
    {
        let igStaticId = igConfig.regionStaticId;
        let wrpStaticId = $('#' + igStaticId).closest('.' + C_LIB4X_SARV).attr('id');
        let rvOptions = sarvOptions[wrpStaticId];
        let buttonsConf = rvOptions.buttonsConf;
        let features = apex.util.getNestedObject(igConfig, 'views.grid.features');
        features.gridView = false;

        let progressOptions = apex.util.getNestedObject(igConfig, 'defaultSingleRowOptions.progressOptions');
        progressOptions.fixed = false;  // by this setting, a fetch/save progress spinner will be in the center of the recordView and not fixed to the page
    
        function gotoRow(igStaticId, fl)
        {
            let totalRecords = apex.region(igStaticId).widget().interactiveGrid('getViews').grid.model.getTotalRecords();
            if (totalRecords && totalRecords > 0)
            {
                apex.region(igStaticId).widget().interactiveGrid('getViews').grid.singleRowView$.recordView('option', 'recordOffset', fl == 'last' ? totalRecords-1 : 0 );
            }         
        }

        function configureButton(toolbarData, showButton, dbdId)
        {
            if (!showButton)
            {
                toolbarData.toolbarRemove(dbdId);
            }
        }
    
        // introduce some extra buttons+actions: first/last row, expand-collapse
        igConfig.initActions = function (actions) { 
            actions.add([
                { 
                    name: ACT_FIRST, 
                    label: 'First',
                    action: function() { 
                        gotoRow(igStaticId, 'first');           
                    }
                },            
                { 
                    name: ACT_LAST, 
                    label: 'Last',
                    action: function() { 
                        gotoRow(igStaticId, 'last');            
                    }
                },
                {
                    name: 'lib4x-toggle-collapsibles', 
                    labelKey: 'LIB4X.ERV.COL_EXP_GRP',
                    onLabelKey: 'LIB4X.ERV.COL_GRP',
                    offLabelKey: 'LIB4X.ERV.EXP_GRP',
                    //onIcon: 'icon-ig-collapse-row',
                    //offIcon: 'icon-ig-expand-row',
                    //onIcon: 'fa-expand-collapse',
                    //offIcon: 'fa-expand-collapse',
                    icon: 'fa fa-expand-collapse',
                    expanded: true,
                    set: function(expanded)
                    {
                        this.expanded = expanded;
                        $('#'+ igConfig.regionStaticId + ' .' + C_COLLAPSIBLE).collapsible(expanded ? 'expand' : 'collapse');
                    },
                    get: function()
                    {
                        return this.expanded;
                    }
                }     
            ]); 
        };     

        let toolbarData = $.apex.interactiveGrid.copyDefaultToolbar();
        // take away unneeded options from the Actions menu
        if (igConfig.features.saveReport.isDeveloper)
        {
            // developer should be able to arrange columns (fields) and save it to the default report
            toolbarData.toolbarInsertAfter('actions1',
                {
                    id: "lib4x_actions1",
                    controls: [
                        {
                            type: TB_MENU,
                            id: "actions_button",
                            labelKey: "APEX.IG.ACTIONS",
                            menu: {
                                items: [
                                    {
                                        type: ACTION,
                                        action: "show-columns-dialog",
                                        label: 'Columns (Fields)'
                                    },   
                                    {
                                        type: "separator"
                                    },                                 
                                    {
                                        type: ACTION,
                                        action: "show-filter-dialog"
                                    },
                                    {
                                        type: "subMenu",
                                        id: "data_submenu",
                                        labelKey: "APEX.IG.DATA",
                                        icon: "icon-ig-data",
                                        menu: {
                                            items: [
                                                {
                                                    type: ACTION,
                                                    action: "show-sort-dialog"
                                                },
                                                {
                                                    type: ACTION,
                                                    action: "refresh"
                                                }
                                            ]
                                        }
                                    },   
                                    {
                                        type: "separator"
                                    },                                 
                                    {
                                        type: ACTION,
                                        action: "save-report",
                                        label: 'Save Default Report'
                                    },
                                    {
                                        type: ACTION,
                                        action: "reset-report",
                                        label: 'Reset Report'
                                    }                                    
                                ]
                            }
                        }
                    ]
                }
            );
        }
        else
        {
            toolbarData.toolbarInsertAfter('actions1',
                {
                    id: "lib4x_actions1",
                    controls: [
                        {
                            type: TB_MENU,
                            id: "actions_button",
                            labelKey: "APEX.IG.ACTIONS",
                            menu: {
                                items: [
                                    {
                                        type: ACTION,
                                        action: "show-filter-dialog"
                                    },
                                    {
                                        type: "subMenu",
                                        id: "data_submenu",
                                        labelKey: "APEX.IG.DATA",
                                        icon: "icon-ig-data",
                                        menu: {
                                            items: [
                                                {
                                                    type: ACTION,
                                                    action: "show-sort-dialog"
                                                },
                                                {
                                                    type: ACTION,
                                                    action: "refresh"
                                                }
                                            ]
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                }
            );
        };
        // instead of crud menu, have crud buttons
        toolbarData.toolbarInsertAfter('actions2', 
            {
                id: "lib4x_actions2",
                controls: [
                   {
                        action: "insert-record",
                        label: 'Add Row',
                        type: 'BUTTON',
                        iconOnly: true,
                        icon: 'icon-ig-add-row'
                    },
                    {
                        action: "duplicate-record",
                        label: 'Duplicate Row',
                        type: 'BUTTON',
                        iconOnly: true,
                        icon: 'icon-ig-duplicate'                        
                    },
                    {
                        action: "delete-record",
                        label: 'Remove Row',
                        type: 'BUTTON',
                        iconOnly: true,
                        icon: 'icon-ig-delete'                        
                    },
                    {
                        action: "revert-record",
                        label: 'Revert Changes',
                        type: 'BUTTON',
                        iconOnly: true,
                        icon: 'icon-ig-revert'                        
                    },
                    {
                        action: "refresh-record",
                        label: 'Refresh Row',
                        type: 'BUTTON',
                        iconOnly: true,
                        icon: 'icon-ig-refresh'                        
                    }                    
                ]
            }
        );
        // add pagination buttons, record state/number, expand-collapse
        toolbarData.toolbarInsertAfter('lib4x_actions2',
            {
                id: "lib4x_pagination",
                align: "end",
                controls: [
                    {
                        type: "STATIC",
                        id: "status",
                        label: ""
                    },
                    {
                        type: 'BUTTON',
                        label: 'Expand/Collapse',
                        iconOnly: true,
                        action: "lib4x-toggle-collapsibles"
                    },
                    {
                        type: "BUTTON",
                        iconOnly: true,
                        icon: "icon-first",
                        action: "first-record"
                    },                
                    {
                        type: "BUTTON",
                        iconOnly: true,
                        icon: "icon-prev",
                        action: "previous-record"
                    },
                    {
                        type: "STATIC",
                        id: "recordNumber",
                        label: ""
                    },
                    {
                        type: "BUTTON",
                        iconOnly: true,
                        icon: "icon-next",
                        action: "next-record"
                    },
                    {
                        type: "BUTTON",
                        iconOnly: true,
                        icon: "icon-last",
                        action: "last-record"
                    }
                ]
            } 
        );
        toolbarData.toolbarRemove('reports');   
        toolbarData.toolbarRemove('views'); 
        toolbarData.toolbarRemove('actions1'); 
        toolbarData.toolbarRemove('actions3');
        toolbarData.toolbarRemove('actions4');
        // apply plugin toolbar/button options
        if (!buttonsConf.rowActionButtons)
        {
            toolbarData.toolbarRemove('lib4x_actions2');
        }
        else
        {
            configureButton(toolbarData, buttonsConf.addRow, 'insert-record');
            configureButton(toolbarData, buttonsConf.duplicateRow, 'duplicate-record');
            configureButton(toolbarData, buttonsConf.deleteRow, 'delete-record');
            configureButton(toolbarData, buttonsConf.refreshRow, 'refresh-record');
            configureButton(toolbarData, buttonsConf.revertRow, 'revert-record');
        }
        configureButton(toolbarData, (buttonsConf.edit && !igConfig.defaultSingleRowOptions.alwaysEdit), 'edit');
        if (!buttonsConf.paginationButtons)
        {
            configureButton(toolbarData, false, 'first-record');
            configureButton(toolbarData, false, 'previous-record');
            configureButton(toolbarData, false, 'recordNumber');
            configureButton(toolbarData, false, 'next-record');
            configureButton(toolbarData, false, 'last-record');
        }
        else if (!buttonsConf.firstLast)
        {
            configureButton(toolbarData, false, 'first-record');
            configureButton(toolbarData, false, 'last-record');
        }
        // see if expand/collapse button to be used
        let useExpandCollapseButton = false;
        if (rvOptions.columnsLayout != 'FIELD_GROUP_COLUMNS')
        {
            let groupedFieldsLength = igConfig.columns.filter(
                (column)=>(column.layout?.groupId)
            ).length;
            if (groupedFieldsLength > 0)
            {
                useExpandCollapseButton = true;
            }
        }
        if (!useExpandCollapseButton)
        {
            configureButton(toolbarData, false, 'lib4x-toggle-collapsibles');
        }

        igConfig.toolbarData = toolbarData;

        // second line of defense in case of maxOneNewRow
        igConfig.defaultModelOptions = {
            check: (result, operation, record, addAction, recordsToAdd) => {
                if (result) {
                    if ((rvOptions.maxOneNewRow) && (operation == 'canAdd')) {
                        let model = apex.region(igStaticId).call('getViews').grid.model;
                        if (model)
                        {
                            result = !(model.getChanges().filter(r => r.inserted).length > 0);
                        }
                    }
                }
                return result;                
            }
        };
        return igConfig;
    }   
    
    // below function can be used for the callserver in apex.model.save()
    // to deal with the below described issue
    function masterDetailSaveCallServer(requestData, requestOptions)
    {
        // using callServer as a wrapper around the save request
        // below code prevents a 'Malformed response' error  
        // which started to occur upon applying Master-Detail referential integrity
        // in page processes
        // below logic replaces the original model id (eg 't1000') in the response with
        // the server side generated order id (insert situations)
        let p = apex.server.plugin(requestData, requestOptions);
        p.done( responseData => {
            if (responseData.regions?.length == 2)
            {
                const recordMap = {};
                const values = responseData.regions[0].fetchedData.models[0].values;
                values.forEach(row => {
                    const firstValue = row[0];
                    const metadata = row[row.length - 1]; // dynamically get the last item
                    const recordId = metadata.recordId;
                    recordMap[recordId] = firstValue;
                });   
                responseData.regions[1].fetchedData.models.forEach(model => {
                    const originalInstance = model.instance;
                    if (recordMap.hasOwnProperty(originalInstance)) {
                        model.instance = recordMap[originalInstance]; // Replace instance
                    }
                });     
            }        
        }); 
        // .done callbacks are chained
        // https://blog.devgenius.io/how-to-use-deferred-done-for-better-promise-handling-in-javascript-f9a4ad049d63
        return p;
    }       

    // validate function which can be used before save as to deal
    // with the below described issue
    function validate(igStaticId)
    {
        let singleRowView$ = apex.region(igStaticId).call('getViews').grid.singleRowView$;
        let masterModel = singleRowView$.recordView('getModel');
        let masterRecord = singleRowView$.recordView('getRecord');
        let masterRecordId = masterModel.getRecordId(masterRecord);
        if (singleRowView$.recordView('inEditMode'))
        {
            // When in edit mode and hitting the save button, the event 'endrecordedit' won't fire
            // and any (html5) validation errors won't populate into the model, from which
            // it will execute the server call (and execute the server-side validations).
            // In below logic, we manually populate any validation errors into the model, so
            // it will only go to the server when no open errors.
            let fields = singleRowView$.recordView('option', 'fields');
            for (const [property, field] of Object.entries(fields[0]))
            {  
                if (field.elementId)
                {
                    let fieldItem = apex.item(field.elementId);
                    if (!fieldItem.isDisabled())
                    {    
                        let validity = fieldItem.getValidity();
                        if (!validity.valid)
                        {
                            let validationMessage = fieldItem.getValidationMessage();
                            if (validationMessage)
                            {
                                masterModel.setValidity("error", masterRecordId, property, validationMessage);
                            }
                        }                                
                    }
                }
            }
        }        
    }

    // function which can be used to jump to the first row having error(s)
    // this can be errors in related detail records as well (master-detail setting)
    function gotoAnyError(igStaticId)
    {
        let ohModel = apex.region(igStaticId).call('getViews').grid.model;
        let errorRecMetaArr = ohModel.getErrors();
        if (errorRecMetaArr.length)
        {
            let recordId = ohModel.getRecordId(errorRecMetaArr[0].record);
            let singleRowView$ = apex.region(igStaticId).call('getViews').grid.singleRowView$;
            singleRowView$.recordView('gotoField', recordId);
        }
        else
        {
            let modelList = apex.model.list(false, ohModel.ModelId, true);
            for (modelInstId of modelList)
            {
                if (Array.isArray(modelInstId))
                {
                    let olModel = apex.model.get(modelInstId);
                    let hasErrors = olModel.hasErrors();
                    apex.model.release(modelInstId);
                    if (hasErrors)
                    {
                        let singleRowView$ = apex.region(igStaticId).call('getViews').grid.singleRowView$;
                        singleRowView$.recordView('gotoField', modelInstId[1]);
                    }
                }
            }
        }        
    }

    return{
        _init: init,
        initIG: initIG,
        hideGroup: rowViewModule.hideGroup,
        showGroup: rowViewModule.showGroup,
        masterDetailSaveCallServer: masterDetailSaveCallServer,
        validate: validate,
        gotoAnyError: gotoAnyError
    }
})(apex.jQuery);
