function save_list(){
	var list_name =  $('#list_name').val()
	var list_url = $('#list_url').val()
	$.post("save_list.js", {name: list_name, url: list_url})
}

function refresh_list(list_id){
	$.post("refresh_list.js", {list_id: list_id})
}