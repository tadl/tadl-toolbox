function save_list(){
	var list_name =  $('#list_name').val()
	var list_url = $('#list_url').val()
	$("#save_list_button").html("<i class='fa fa-spinner fa-spin'></i> Saving List")
	$.post("save_list.js", {name: list_name, url: list_url})
}

function refresh_list(list_id){
	$("#refresh_list_button").html("<i class='fa fa-spinner fa-spin'></i> Refreshing List")
	$.post("refresh_list.js", {list_id: list_id})
}

function confirm_delete_list(list_id){
	$("#delete_button").text("Press Again to Confirm Deletion")
	var new_onclick = 'delete_list("' + list_id + '")'
	$("#delete_button").attr("onclick", new_onclick)
}

function delete_list(list_id){
	$.post("delete_list.js", {list_id: list_id})
}

function show_admins_list(list_id){
	$.post("show_admins.js", {list_id: list_id})
}

function confirm_change_list_owner(admin_name, admin_id, list_id){
	$('#confirm_change_owner').css('display','block')
	$('#confirm_change_owner').prepend('You are about to transfer ownership of this list to ' + admin_name)
	var new_onclick = 'change_list_owner("'+ admin_id +'","'+ list_id +'")'
	$("#confirm_change_owner_button").css('display','block')
	$("#confirm_change_owner_button").attr("onclick", new_onclick)
}

function change_list_owner(admin_id,list_id){
	$.post("change_list_owner.js", {list_id: list_id, new_owner_id: admin_id})
}

function show_upload_cover_form(record_id){
	$.post("new_cover.js", {record_id: record_id})
}

function cancel_upload_cover(record_id){
	var target_hide = '#cover_form_' + record_id
	var target_show = '#list_buttons_' + record_id
	$(target_hide).html('')
	$(target_show).css('display','block')
}


function mark_not_found(cover_id){
	$.post("mark_cover_not_found.js", {id: cover_id})
}


function preview_file(input, record_id) {
  var target_div = '#img_prev_' + record_id
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(target_div)
        .attr('src', e.target.result)
    };
    reader.readAsDataURL(input.files[0]);
  }
  $(target_div).css('display','block')
}

function preview_url(input, record_id) {
  var target_div = '#img_prev_' + record_id
  var image_url = $(input).val()
  $(target_div).attr('src', image_url)
  $(target_div).css('display','block')
}

function preview_image(record_id){
	var file_input = '#file_' + record_id
	var url_input = '#url_' + record_id
	var message_div = '#messages_' + record_id
	var check_file = $(file_input).val()
	var check_url = $(url_input).val()
	$(message_div).html('') 
	if(check_file){
		$(file_input).show(function(){ 
    		preview_file(this, record_id)
		});
	}else if(check_url){
		$(url_input).show(function(){ 
    		preview_url(this, record_id)
		});
	}else{
		$(message_div).append('<p class="error_text">Error: No image selected for preview</p>') 
	}
}

function reports_department_changed(){
  var form_date = $('#form_date').text()
  var department_id = $('#department').val()
  if(department_id != 'none'){
    if(form_date){
      $.post("show_report_form",{date: form_date, department_id: department_id})
      $.post("show_calendar.js", {start_date: form_date, department_id: department_id})
    }else{
      $.post("show_calendar.js", {department_id: department_id})
    }
  }else{
    $('#calendar').html('')
    $('#report_form').html('')
  }
}

function reports_submitt(){
  var bad_data = false
  var department_id = $('#department').val()
  var current_user = $.trim($('#current_user').text())
  var report_date = $.trim($('#form_date').text())
  var params = {}
  var report_inputs = $("#report_form :input")
  $.each(report_inputs, function(){
    $(this).css('border','1px solid #ccc')
    var field_name = this.id
    var field_val = $(this).val()
    //check for whole numbers
    if(!field_val.match(/^[0-9]*$/)){
      $(this).css('border','2px solid red')
      bad_data = true
    }
    if(bad_data == false)
    if(field_val){
      params[field_name] = field_val
    }else{
      params[field_name] = 0
    }
  });
  if(bad_data == true){
    alert('bad data')
  }else{
    params['last_edit_by'] = current_user
    params['report_date'] = report_date
    params['department_id'] = department_id
    $.post("save_report", params)
  }
}

function no_patron(){
  if($('#no_patrons').is(":checked")){
    $('#save_incident_with_patron').hide()
    $('#save_incident').show()
    $('#patron_form').hide()
    $('#add_patron').hide()
  }else{
    $('#save_incident_with_patron').show()
    $('#save_incident').hide()
    $('#patron_form').show()
    $('#add_patron').show()
  }
}

function cancel_add_patron(){
  $('#patron_portion').hide()
  $("#add_patron").show()
  $("#update_incident").show()
}


function save_incident(update, from){
  var incident_input = []
  var incident_params = new FormData()
  $(".incident_info :input").each(function(){
    incident_input.push($(this));
  });
  $(incident_input).each(function(){
    if($(this).attr('type') == 'checkbox'){
      incident_params.append($(this).attr('id'), $(this).is(":checked"))
    }else if($(this).attr('type') == 'file'){
      var file_count = $(this)[0].files.length
      for (var x = 0; x < file_count; x++) {
        incident_params.append("incidentpic[]", $(this)[0].files[x]);
      }
    }else{
      incident_params.append($(this).attr('id'), $(this).val())
    }
  })
  var date_of = $('#datetimepicker1').data("DateTimePicker").viewDate().format()
  incident_params.append('date_of', date_of)
  incident_params.append('from', from)
  if(update == true){
    var url = 'update_incident'
  }else{
    var url = 'save_incident'
  }
  if(from == 'form_with_patron'){
    $("#add_patron").hide()
    $("#update_incident").hide()
  }
  $.ajax({
    type: "POST",
    url: url,
    data: incident_params,
    processData: false,
    contentType: false
  });
}


function save_patron(update, from){
  var patron_input = []
  var patron_params = new FormData()
  $(".patron_info :input").each(function(){
    patron_input.push($(this));
  });
  $(patron_input).each(function(){
    if($(this).attr('type') == 'checkbox'){
      patron_params.append($(this).attr('id'), $(this).is(":checked"))
    }else if($(this).attr('type') == 'file'){
      var file_count = $(this)[0].files.length
      for (var x = 0; x < file_count; x++) {
        patron_params.append("patronpic[]", $(this)[0].files[x]);
      }
    }else{
      patron_params.append($(this).attr('id'), $(this).val())
    }
  })
  var incident_id = $('#incident_id').text()
  if(incident_id){}else{
    var incident_id = $('#incident_info').val()
  }
  patron_params.append('incident_id', incident_id)
  patron_params.append('from', from)
  if(update == true){
    var url = 'update_update'
  }else{
    var url = 'save_patron'
  }
  $.ajax({
    type: "POST",
    url: url,
    data: patron_params,
    processData: false,
    contentType: false
  });
}

function delete_pic(i, model){
  var id = $('#id').val()
  if(model=='patron'){
    var url = "delete_patron_pic.js"
  }else{
    var url = "delete_incident_pic.js"
  }
  $.get(url, {i: i, id: id})
}

function make_primary_pic(i, model){
  var id = $('#id').val()
  if(model=='patron'){
    var url = "make_primary_patron_pic.js"
  }else{
    var url = "make_primary_incident_pic.js"
  }
  $.get(url, {i: i, id: id})
}

function show_patron_search(){
  $('#patron_search').show()
  $('#new_patron_form').hide()
}

function hide_patron_search(){
  $('#patron_search').hide()
  $('#new_patron_form').show()
}


function search_for_patron(from_incident){
  var query = $('#patron_search_input').val()
  var age_range = $('#age_range').val()
  var gender = $('#gender').val()
  $.get("patron_search", {query: query, age_range: age_range, gender: gender, from_incident: from_incident})
}

function incident_location_change(){
  target_location = $('#location').val()
  if(target_location == 'Woodmere'){
    $('#department_select').show()
  }else{
    $('#department_select').hide()
  }
}

function add_patron_to_incident(patron_id){
  var incident_id = $('#incident_id').text()
  if(incident_id){}else{
    var incident_id = $('#incident_info').val()
  }
  $.get("add_patron_to_incident", {patron_id: patron_id, incident_id: incident_id})
}

function save_violations(patron_id){
  var incident_id = $('#incident_id').text()
  if(incident_id){}else{
    var incident_id = $('#id').val()
  }
  var violation_div = '#violations_' + patron_id  + ' input:checkbox'
  var violation_ids_raw = $(violation_div+':checked').map(function(){
    return $(this).val();
  }).get();
  var unchecked_violations_raw = $(violation_div).map(function(){
    if(!this.checked){
      return $(this).val();
    }
  }).get();
  var violation_ids = violation_ids_raw.join(',')
  var unchecked_violation_ids = unchecked_violations_raw.join(',')
  $.get("save_violations",{patron_id: patron_id, incident_id: incident_id, violation_ids: violation_ids, unchecked_violation_ids: unchecked_violation_ids})
}

function edit_violations(patron_id){
  var incident_id = $('#incident_id').text()
  if(incident_id){}else{
    var incident_id = $('#id').val()
  }
  $.get("edit_violations", {patron_id: patron_id, incident_id: incident_id})
}