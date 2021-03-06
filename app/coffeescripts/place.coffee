$(document).on "change", ".country-select", ->
  country_id = $(this).val()
  if country_id == "484" or country_id == 840
    $.state_list_by_country country_id
    $("#hidden_state_id").remove()
    $("#city_text_field").html ""
    $('select').chosen()
  else
    $("#user_person_attributes_state_id").remove()
    $("#user_person_attributes_state_id_chosen").remove()
    $("#city_list_chosen").remove()
    $("#city_list").replaceWith ""
    $("#city_new").hide()
    $.textfield_for_city()
    $("#city_new").before "<div id=\"city_list\"> </div>"
    $("#state_set").append "<input id=\"user_person_attributes_state_id\" name=\"user[person_attributes][state_id]\" value=\"\" type=\"hidden\">"
  
$(document).on "change", "#user_person_attributes_state_id", ->
  state_id = $($("#user_person_attributes_state_id").find("option:selected")[0]).val()
  if state_id >= 1 or state_id <= 83
    $.city_list_by_state state_id
    $("#city_new").show()
    $("#city_field").replaceWith "<div id=\"city_field\"> </div>"
    $("#city_list_chosen").remove()
    $('select').chosen()

$(document).on "click", "#city_new", (e)->
  e.preventDefault()
  url = "/cities/new.js?state_id=" + $("#user_person_attributes_state_id").val()
  $("#dialog").dialog(
    title: "Nueva ciudad"
    width: 400
    height: 330
    modal: true
    overlay:  background: "#fff", opacity: 0.25
  ).dialog "open"
  responseData = $.response_from_simple_remote_resource(url)
  $("div#dialog").html responseData

$(document).on "click", "#new_city input[type=submit]", (e) ->
  e.preventDefault()
  url = $("#new_city").attr("action")
  p = $.param($("#new_city").serializeArray())
  options = 
    url: url
    type: "POST"
    data: p
    async: false
  object = jQuery.parseJSON($.ajax(options).responseText)
  option = $('<option>', { value: object.id}).text(object.name)
  option.attr('selected','selected')
  $($("#city_set").find("select option:selected")[0]).remove()
  $($("#city_set").find("select")[0]).append(option)
  $($("#city_set").find("select")[0]).trigger("chosen:updated")
  $("#dialog").empty()
  $("#dialog").dialog "close"

jQuery.extend 
  state_list_by_country: (id) ->
    url = "/states/list_by_country?country_id=" + id
    html = $.response_from_simple_remote_resource(url)
    $("#state_set").append html

  city_list_by_state: (id) ->
    url = "/cities/list_by_state?state_id=" + id
    html = $.response_from_simple_remote_resource(url)
    $("#city_list").replaceWith html

  textfield_for_city: ->
    $.ajax 
      url: "/cities/remote_form.js"
      type: "GET"
      dataType: "html"
      async: true
      success: (html) ->
        $("#city_text_field").html html
