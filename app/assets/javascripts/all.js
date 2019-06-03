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
    $.post("show_calendar.js", {department_id: department_id})
    if(form_date){
      $.post("show_report_form",{date: form_date, department_id: department_id})
    }
  }else{
    $('#calendar').html('')
    $('#report_form').html('')
  }
}

function reports_submitt(){
  var bad_data = false
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
    if(field_val && bad_data == false){
      params[field_name] = field_val
    }
  });
  if(bad_data == true){
    alert('bad data')
  }else{
    alert(JSON.stringify(params))
  }
}