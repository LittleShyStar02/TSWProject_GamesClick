$(document).ready(function () {

    $('#search_datatype').keypress(function (event) {

        var bid = event.target.id;
        var text = event.target.value;
        var type = $("#input_datatype").val();
        if(type == null || type == '') return;
        
        $.post('AjaxAutoComplete?type='+type+'&start='+text, { "button-id": bid },
            function (resp) {
                var json = JSON.parse(resp);
                var element = $("#autocomplete-div")
                element.addClass('showcont');
                element.html('');
                if(type == 'category' || type == 'console' || type == 'game')
                {
                    $.each(json, function(x, data) {
                        element.html(element.html() + "<p id=\"autocomplete-text\">"+data.name+"</p>");
                    });
                }

                if(type == 'user')
                {
                    $.each(json, function(x, user){
                        element.html(element.html() + "<p id=\"autocomplete-text\">"+user.name+"/"+user-surname+"/"+user.email+"</p>");

                    });
                }
                
            }
        );

    });

});