
function setValue(text)
{
    document.getElementById('search_datatype').value = text;
    document.getElementById('autocomplete-div').classList.remove("showcont");
}

$(document).ready(function () {

    $('#search_datatype').keypress(function (event) {

        var bid = event.target.id;
        var text = event.target.value;
        var type = $("#input_datatype").val();
        if(type == null || type == '') return;
        
        $.post('AjaxAutoComplete?type='+type+'&start='+text, { "button-id": bid },
            function (resp) {
                var json = JSON.parse(resp);
                var element = $("#autocomplete-div");
                element.addClass('showcont');
                element.html('');
                if(type == 'category' || type == 'console' || type == 'game')
                {
                    $.each(json, function(x, data) {
                        if(x < 7) element.html(element.html() + "<input type=\"button\" class=\"autocomplete-text\" value=\""+data.name+"\" onclick=\"setValue('"+data.name+"')\">");
                    });
                }
                
            }
        );

    });

});