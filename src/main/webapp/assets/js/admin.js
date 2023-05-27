function categoryAutoComplete()
{
    var text = document.getElementById('categoryName').value;
    if(text == null) return;
}

function setAction(id, idform, action) {
    document.getElementById(id).value = action;
    document.getElementById(idform).submit();
}

function toggle(firstToShow, secondToShow) {
    document.getElementById('actioncat').classList.remove('showcont');
    document.getElementById('actioncat').classList.add('hidecont');

    document.getElementById('actioncon').classList.remove('showcont');
    document.getElementById('actioncon').classList.add('hidecont');

    document.getElementById('actiongame').classList.remove('showcont');
    document.getElementById('actiongame').classList.add('hidecont');

    document.getElementById('actionadmin').classList.remove('showcont');
    document.getElementById('actionadmin').classList.add('hidecont');

    document.getElementById(firstToShow).classList.add('showcont');
    if (secondToShow != null) {
        document.getElementById(secondToShow).classList.add('showcont');
    }
}