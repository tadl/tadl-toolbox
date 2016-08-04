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