function deleteGame(name)
{
	document.getElementById('carrelloform').action = 'DeleteCartGame?gamename='+name; 
}

function cartDelete()
{
	document.getElementById('carrelloform').action = 'ResetCart'; 
}

function goToCheckOut()
{
	document.getElementById('carrelloform').action = 'GoCheckOut'; 
}