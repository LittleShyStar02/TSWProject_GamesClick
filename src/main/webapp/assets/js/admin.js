function getFromType()
{
    switch(getInputDataType())
        {
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

function getInputDataType()
{
    return document.getElementById('input_datatype').value;
}

function hide(idtohide)
{
    document.getElementById(idtohide).classList.remove('showcont');
}

function setAction(id, idform, action) {
    document.getElementById(id).value = action;
    document.getElementById(idform).submit();
}

function setInputDataType(dataType)
{
    document.getElementById('input_datatype').value = dataType;
}

function setDataSearch(text)
{
    if(text == 'null' || text == null) return;
    document.getElementById('search_datatype').value = text;
}

function setTypeText(id,text)
{
    document.getElementById(id).innerHTML = text;
}

function setParameter(form,first,second,type)
{
    if(form == 'firstForm')
    {
        if(first != null) document.getElementById('firstToShow').value = first;
        if(second != null) document.getElementById('secondToShow').value = second;
        if(type != null) document.getElementById('dataType').value = type;
        return true;
    }

    if(form == 'secondForm')
    {
        if(first != null) document.getElementById('firstToShow2').value = first;
        if(second != null) document.getElementById('secondToShow2').value = second;
        if(type != null) document.getElementById('dataType2').value = type;
        return true;
    }

    return false;
}

function setPlaceholder(id,text)
{
    document.getElementById(id).placeholder = text;
}

function setReadOnly(id)
{
    document.getElementById(id).readOnly = true;
}

function show(idtoshow)
{
    document.getElementById(idtoshow).classList.add('showcont');
}


function visualize(firstToShow,secondToShow,dataType)
{
    if(firstToShow == '' || firstToShow == null) return;

    hide('searchthing');
    hide('actionadmin');
    hide('catinfo');
    hide('coninfo');
    hide('gameinfo');
    hide('userinfo');

    show(firstToShow);
    
    if(dataType != '' && dataType != null)
    {
        switch(dataType)
        {
            case 'category':
                setTypeText('search_type_text','Gestione Categorie Gioco');
                setTypeText('label_datatype',"Inserisci il nome della categoria");
                setPlaceholder('search_datatype',"Nome Categoria");
                break;
            case 'console':
                setTypeText('search_type_text','Gestione Console');
                setTypeText('label_datatype',"Inserisci il nome della console");
                setPlaceholder('search_datatype',"Nome Console");
                break;
            case 'game':
                setTypeText('search_type_text','Gestione Giochi');
                setTypeText('label_datatype',"Inserisci il nome del gioco");
                setPlaceholder('search_datatype',"Nome Gioco");
                break;
            case 'user':
                setTypeText('search_type_text','Ricerca Utenti');
                setTypeText('label_datatype',"Ricerca un utente per nome/cognome/email");
                setPlaceholder('search_datatype',"Nome/Cognome/Email utente");
                break;
        }
        setInputDataType(dataType);
    }

    if(secondToShow != '' && firstToShow != null)
    {
        show(secondToShow);
        setReadOnly('search_datatype');
    }

}