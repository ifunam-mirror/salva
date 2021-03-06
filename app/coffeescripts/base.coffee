jQuery.extend 
  set_button_behaviour: ->
    $(".ui-state-default").hover (->
      $(this).addClass "ui-state-hover"
    ), ->
      $(this).removeClass "ui-state-hover"
    
    $(".ui-state-default").css "cursor", "pointer"
  
  open_dialog_with_progressbar: ->
    $("#dialog").dialog(
      width: 260
      height: 130
      bgiframe: true
      modal: true
      hide: "slide"
      open: (event, ui) ->
        $(this).parent().children(".ui-dialog-titlebar").hide()
    ).dialog "open"
    $("#dialog").html "<div id=\"progressbar\"></div><p style=\"font-size:12px\">Cargando, por favor espere...</p>"
    $("#progressbar").progressbar value: 100
  
  close_dialog_with_progressbar: ->
    $("#dialog").dialog "close"
    $("#dialog").html ""
  
  collection_from_remote_resource: (resource, params) ->
    options = 
      url: resource
      async: false
      beforeSend: ->
        $.open_dialog_with_progressbar()
      
      complete: (request) ->
        $.set_button_behaviour()
        $.close_dialog_with_progressbar()
      
      type: "get"
    
    options["data"] = params  unless params == undefined
    $.ajax(options).responseText
  
  remote_collection_list: (resource, params) ->
    html = $.collection_from_remote_resource(resource, params)
    $("#collection_records").remove()
    $("#collection_footer").remove()
    $(".pagination").remove()
    $("#pagination_info").remove()
    $("#collection_header").after html
    false
  
  date_picker_for: (dom_id, start_year, end_year) ->
    $(dom_id).datepicker 
      changeYear: true
      changeMonth: true
      yearRange: start_year + ":" + end_year
      dateFormat: "dd-mm-yy"
      defaultDate: "-2m"
      showOn: "both"
      buttonImageOnly: true
      buttonImage: "/assets/calendar.gif"
  
  response_from_simple_remote_resource: (resource) ->
    $.ajax(
      url: resource
      async: false
    ).responseText
  
  response_from_remote_resource: (resource) ->
    options = 
      url: resource
      async: false
      beforeSend: ->
        $.open_dialog_with_progressbar()
      
      complete: (request) ->
        $.set_button_behaviour()
        $.close_dialog_with_progressbar()
    
    $.ajax(options).responseText

  dialog_for_new_record: (controller) ->
    controller += ".js" if (controller.match(/format\=js$/g) == null)
    $("#dialog").dialog(
      title: ""
      width: 400
      height: 500
      modal: true
      overlay:  background: "#fff", opacity: 0.25
    ).dialog "open"
    responseData = $.response_from_simple_remote_resource(controller)
    $("div#dialog").html responseData

  dialog_for_new_checkbox: (controller) ->
    remote_resource = '/' + controller + '/new'
    $.dialog_for_new_record(remote_resource)
    $('#new_record_form').attr('id', "new_checkbox_form")


  change_record: (class_name) ->
    $('#autocomplete_'+class_name+'_name').removeAttr("disabled")
    $('#autocomplete_'+class_name+'_name').val('')
    $('#change_'+class_name).hide()

  dialog_for_new_period: (url) ->
    $.dialog_for_new_record(url)

  destroy_selected_records: (record_ids, dom_ids) ->
    $.ajax
      url: $("#filter_form").attr("action") + "/destroy_all.js"
      data: ids: record_ids
      type: "GET"
      async: false
      beforeSend: ->
        $.open_dialog_with_progressbar()
      complete: (data) ->
        $.close_dialog_with_progressbar()
      success: (data) ->
        $.each dom_ids, (index, dom_id) ->
          $("#" + dom_id).remove()
