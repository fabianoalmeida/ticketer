$(document).ready(function(){
	$('#place_ticket_type_group_tokens').tokenInput( '/grupos_tipo_de_senha.json', {
		propertyToSearch: "value",
		prePopulate: $('#place_ticket_type_group_tokens').data('load'),
		hintText: "Digite um grupo de tipo de senha",
		searchingText: "Procurando..."
	})
});