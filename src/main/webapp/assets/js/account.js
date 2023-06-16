function hide(id)
{
    document.getElementById(id).classList.remove('showcont');
}

function show(id)
{
    document.getElementById(id).classList.add('showcont');
}

function visualize(id)
{
    if(id == '' || id == null) return;
    hide('userprofile');

    show(id);
}