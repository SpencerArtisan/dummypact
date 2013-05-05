show_modal = (selector, submit_event, endpoint = $("form").attr("action"))  ->
  submit_js = "return submit_json({'contact':$('#contact').val(), 'name': '" + submit_event + "'}, '" + endpoint + "')"
  $(selector + ' #submit_event').attr('onclick', submit_js)
  $(selector).modal()
  false

submit_json = (extra_data, endpoint = $("form").attr("action")) ->
  return if page_has_form() and !$("form").validate().form()

  # disable the button to prevent repeated clicks
  $(window.event.srcElement).attr("disabled", "disabled") if window.event
  json_string = form_as_json extra_data
  send_to_server json_string, endpoint
  false

page_has_form = ->
  $("form").length > 0

form_as_json = (extra_data) ->
  inputs = []
  inputs = $("form").serializeArray() if page_has_form
  for key, val of extra_data
    inputs.push {name: key, value : val}
  json = {}
  for input in inputs
    if input.value != ""
      if input.name.indexOf(".") == -1
        json[input.name] = input.value
      else
        parent_key = input.name.substring(0, input.name.indexOf("."))
        child_key = input.name.substring(input.name.indexOf(".") + 1)
        embedded_json_array = json[parent_key] ? []
        child_json = {}
        child_json[child_key] = input.value
        embedded_json_array.push child_json
        json[parent_key] = embedded_json_array
  
  json_string = JSON.stringify json
  console.log "Form data as json is: #{json_string}"
  _.escape(json_string)

send_to_server = (json_string, endpoint) ->
  json_form = $("<form id='json_form' action='#{endpoint}' method='POST'><input type='hidden' name='json' value='#{json_string}'/></form>")
  $("body").append(json_form)
  json_form.submit()

window.submit_json = submit_json
window.show_modal = show_modal
