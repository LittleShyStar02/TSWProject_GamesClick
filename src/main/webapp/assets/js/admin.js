function getFromType() {
    switch (getInputDataType()) {
        case 'category':
            return 'catinfo';
        case 'console':
            return 'coninfo';
        case 'game':
            return 'gameinfo';
        case 'user':
            return 'userinfo';
    }
}

function getInputDataType() {
    return document.getElementById('input_datatype').value;
}

function hide(idtohide) {
    document.getElementById(idtohide).classList.remove('showcont');
}

function setAction(id, idform, action) {
    document.getElementById(id).value = action;
    document.getElementById(idform).submit();
}

function setInputDataType(dataType) {
    document.getElementById('input_datatype').value = dataType;
}

function setDataSearch(text) {
    if (text == 'null' || text == null) return;
    document.getElementById('search_datatype').value = text;
}

function setTypeText(id, text) {
    document.getElementById(id).innerHTML = text;
}

function setParameter(form, first, second, type) {
    if (form == 'firstForm') {
        if (first != null) document.getElementById('firstToShow').value = first;
        if (second != null) document.getElementById('secondToShow').value = second;
        if (type != null) document.getElementById('dataType').value = type;
        return true;
    }

    if (form == 'secondForm') {
        if (first != null) document.getElementById('firstToShow2').value = first;
        if (second != null) document.getElementById('secondToShow2').value = second;
        if (type != null) document.getElementById('dataType2').value = type;
        return true;
    }
    return false;
}

function setPlaceholder(id, text) {
    document.getElementById(id).placeholder = text;
}

function setReadOnly(id) {
    document.getElementById(id).readOnly = true;
    document.getElementById(id).classList.add('readonly');
}

function show(idtoshow) {
    document.getElementById(idtoshow).classList.add('showcont');
}

function unlock(id) {
    var tmp = document.getElementById(id);
    tmp.readOnly = false;
    tmp.classList.remove('readonly');
}

function visualize(firstToShow, secondToShow, dataType) {
    if (firstToShow == '' || firstToShow == null) return;

    hide('searchthing');
    hide('actionadmin');
    hide('catinfo');
    hide('coninfo');
    hide('gameinfo');
    hide('userinfo');

    show(firstToShow);

    if (dataType != '' && dataType != null) {
        switch (dataType) {
            case 'category':
                setTypeText('search_type_text', 'Gestione Categorie Gioco');
                setTypeText('label_datatype', "Inserisci il nome della categoria");
                setPlaceholder('search_datatype', "Nome Categoria");
                break;
            case 'console':
                setTypeText('search_type_text', 'Gestione Console');
                setTypeText('label_datatype', "Inserisci il nome della console");
                setPlaceholder('search_datatype', "Nome Console");
                break;
            case 'game':
                setTypeText('search_type_text', 'Gestione Giochi');
                setTypeText('label_datatype', "Inserisci il nome del gioco");
                setPlaceholder('search_datatype', "Nome Gioco");
                break;
            case 'user':
                setTypeText('search_type_text', 'Ricerca Utenti');
                setTypeText('label_datatype', "Ricerca un utente per nome/cognome/email");
                setPlaceholder('search_datatype', "Email utente");
                break;
        }
        setInputDataType(dataType);
    }

    if (secondToShow != '' && secondToShow != null) {
        show(secondToShow);
        setReadOnly('search_datatype');
    }

}

/*
  CATEGORY FUNCTION
*/
function createCategory() {
    if (checkCatDesc()) {
        document.getElementById('action_form').value = "create_category";
        document.getElementById('secondForm').submit();
    }
}

function unlockCategory() {
    unlock('catdesc');
}

function modifyCategory() {
    if (checkCatDesc()) {
        document.getElementById('action_form').value = "modify_category";
        document.getElementById('secondForm').submit();
    }
}

function deleteCategory() {
    document.getElementById('action_form').value = "delete_category";
    document.getElementById('secondForm').submit();
}

function checkCatDesc() {
    var text = document.getElementById('catdesc').value;
    if (text == '' || text == null) {
        document.getElementById('errordesc').innerHTML = "Descrizione richiesta";
        return false;
    }
    else if(text.length > 2000)
    {
        document.getElementById('errordesc').innerHTML = "La descrizione conta più di 2000 caratteri";
        return false;
    }
    else {
        return true;
    }
}

/*
  CONSOLE FUNCTION
*/
function createConsole() {
    if (checkConDesc()) {
        document.getElementById('action_form').value = "create_console";
        document.getElementById('secondForm').submit();
    }
}

function unlockConsole() {
    unlock('condesc');
}

function modifyConsole() {
    if (checkConDesc()) {
        document.getElementById('action_form').value = "modify_console";
        document.getElementById('secondForm').submit();
    }
}

function deleteConsole() {
    document.getElementById('action_form').value = "delete_console";
    document.getElementById('secondForm').submit();
}

function checkConDesc() {
    var text = document.getElementById('condesc').value;
    if (text == '' || text == null) {
        document.getElementById('errordesc2').innerHTML = "Descrizione richiesta";
        return false;
    }
    else if(text.length > 2000)
    {
        document.getElementById('errordesc2').innerHTML = "La descrizione conta più di 2000 caratteri";
        return false;
    }
    else {
        return true;
    }
}

/*
  GAME FUNCTION
*/
function createGame() {
    if (checkGameValue()) {
        document.getElementById('action_form').value = "create_game";
        setConsoleGame();
        setCategoryGame();
        document.getElementById('secondForm').submit();
    }
}

function unlockGame() {
    unlock('gamedesc');
    unlock('gamedate');
    unlock('gameprice');
    unlock('minage');
    unlock('gameurl');
    unlock('gameadmin');
    var element;
    var x = 1;
    while((element = document.getElementById('con'+x)) != null)
    {
        element.disabled = false;
        x++;
    }
    x = 1;
    while((element = document.getElementById('cat'+x)) != null)
    {
        element.disabled = false;
        x++;
    }
}


function modifyGame() {
    if (checkGameValue()) {
        document.getElementById('action_form').value = "modify_game";
        setConsoleGame();
        setCategoryGame();
        document.getElementById('secondForm').submit();
    }
}

function deleteGame() {
    document.getElementById('action_form').value = "delete_game";
    document.getElementById('secondForm').submit();
}

function checkGameValue() {
    var text = document.getElementById('gamedesc').value;
    if (text == '' || text == null) {
        document.getElementById('errordesc3').innerHTML = "Descrizione richiesta";
        return false;
    }
    if(text.length > 2000)
    {
        document.getElementById('errordesc3').innerHTML = "La descrizione conta più di 2000 caratteri";
        return false;
    }
    var date = document.getElementById('gamedate').value;
    if(!date)
    {
        document.getElementById('errordate').innerHTML = "Data richiesta";
        return false;
    }
    return true;
}

function setConsoleGame() {
    var str = new String("");
    var x = 1;
    var element;
    while((element = document.getElementById('con'+x)) != null)
    {
        if(element.checked) str = str.concat(element.value + ';');
        x++;
    }
    if(str.endsWith(';')) str = str.substring(0,str.length-1);
    document.getElementById('gameconsole').value = str;
}

function setCategoryGame() {
    var str = new String("");
    var x = 1;
    var element;
    while((element = document.getElementById('cat'+x)) != null)
    {
        if(element.checked) str = str.concat(element.value + ';');
        x++;
    }
    if(str.endsWith(';')) str = str.substring(0,str.length-1);
    document.getElementById('gamecategory').value = str;
}