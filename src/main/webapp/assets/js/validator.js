function validateReg()
{
    var exp = new RegExp("^[A-Za-z]+$");
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

    if(document.getElementById('password').value != document.getElementById('password2'))
    {
        document.getElementById('password2error').innerHTML = "Le password non corrispondono";
        return false;
    }

    return true;
}