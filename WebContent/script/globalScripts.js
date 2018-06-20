    $(window).resize(function() {
    $("#dialog-form").dialog("option", "position", {
      my: "center",
      at: "center",
      of: window
    });
    $("#del-confirm").dialog("option", "position", {
      my: "center",
      at: "center",
      of: window
    });
    });
    
    function updateTips(t) {
        tips
            .text(t)
            .addClass("ui-state-highlight");
        setTimeout(function() {
            tips.removeClass("ui-state-highlight", 1500);
        }, 500);
    }
    
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }
    
    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
    function evidenzia(oggetto) {
	    oggetto
	      .addClass( "ui-state-highlight" );
	    setTimeout(function() {
	      oggetto.removeClass( "ui-state-highlight", 1500 );
	    }, 500 );
	  }