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

function upload_cover(record_id){
	target_form = 'form_' + record_id
	var formData = new FormData($(target_form)[0]);
	$.ajax({
    	url: "cover_upload",
    	type: "POST",
    	data: formData,
    	async: false,
    	cache: false,
    	contentType: false,
    	processData: false
    });


}

function mark_not_found(record_id){
	alert(record_id)
}