function save_list(){
	var list_name =  $('#list_name').val()
	var list_url = $('#list_url').val()
	$.post("save_list.js", {name: list_name, url: list_url})
}

function refresh_list(list_id){
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