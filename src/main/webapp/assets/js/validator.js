function validateReg()
{
    let exp = new RegExp("^[A-Za-z]+$");
    if(!exp.test(document.getElementById('nome').value))
    {
        document.getElementById('errorname').innerHTML = "Solo lettere ammesse";
        return false;
    }

    if(!(exp.test(document.getElementById('cognome').value))) 
    {
        document.getElementById('errorsurname').innerHTML = "Solo lettere ammesse";
        return false;
    }

    let pass = new String(document.getElementById('password').value);
    let text = document.getElementById('password2error');
    if(pass.length < 6 || pass.length > 32)
    {
        text.innerHTML = "Lunghezza password dai 6 ai 32 caratteri";
        return false;
    }

    let exp2 = new RegExp("[A-Z]");
    if(!exp2.test(pass))
    {
        text.innerHTML = "La password deve contenere una lettera maiuscola"
        return false;
    }

    let exp3 = new RegExp("[0-9]");
    if(!exp3.test(pass))
    {
        text.innerHTML = "La password deve contenere almeno un numero";
        return false;
    }

    if(pass != document.getElementById('password2').value)
    {
        text.innerHTML = "Le password non corrispondono";
        return false;
    }

    return true;
}