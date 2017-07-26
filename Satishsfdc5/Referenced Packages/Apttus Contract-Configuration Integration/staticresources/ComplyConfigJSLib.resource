/**
 *	Apttus Comply-Config Integration
 *	complyconfig.js
 *	 
 *	@2010-2011 Apttus Inc. All rights reserved.
 * 
 */

// constants


// messages

// unknown error
var cc_cERROR_UNKNOWN = "ERROR: Unknown error:\n";

function cc_showMsgProgress(msg) {
    var html = "<center><p><p><h2>" + msg + "</h2>" +
        "<p><img src=\"/img/waiting_dots.gif\" border=\"0\" width=156 height=25></center>";
    
    cc_setMain(html);
    cc_showMain();
}

function cc_hideMsgProgress() {
	cc_resetMain();
	cc_hideMain();
}

function cc_resetMain() {
	cc_setMain("");
}

function cc_setMain(html) {
    document.getElementById("divMain").innerHTML = html;
}

function cc_showMain() {
    document.getElementById("divMain").style.visibility = "visible";
}

function cc_hideMain() {
    document.getElementById("divMain").style.visibility = "hidden";
}

function cc_erroralert(msg, exception) {
    
	try {
        var emsg = null;
        var efld = null;
        var estc = null;
        var etid = null;

        try {
            var hasErrors = (exception.errors!=null);
            var hasFault = (exception.faultcode!=null);
            //alert("hasErrors="+hasErrors+"\nhasFault="+hasFault);

            if (hasErrors) {
                emsg = exception.errors.message;
                efld = exception.errors.fields;
                estc = exception.errors.statusCode;

            } else if (hasFault) {
                emsg = exception.faultcode;
                efld = exception.faultstring;
                
            } else {
                emsg = exception.message;
                efld = exception.fields;
                estc = exception.statusCode;
            }
            
        } catch(ex) {
            emsg = exception.errors.message;
            efld = exception.errors.fields;
            estc = exception.errors.statusCode;
        }

        var estr = msg;
        var estrdb = estr;
        
        if (emsg!=null && emsg!="") {
            estr += "\nmessage: "+emsg;
            estrdb += "<br>message: "+emsg;
        }
        if (efld!=null && efld!="") {
            estr += "\nfields: "+efld;
            estrdb += "<br>fields: "+efld;
        }
        if (estc!=null && estc!="") {
            estr += "\nstatusCode: "+estc;
            estrdb += "<br>statusCode: "+estc;
        }
        if (etid!=null && etid!="") {
            estr += "\ntargetObjectId: "+etid;
            estrdb += "<br>targetObjectId: "+etid;
        }
        
        alert(estr);
        
    } catch(ex) {
        alert(msg+"\n"+exception);
    }
    
}

/**
 * Navigates to the given url
 * @param url the url to navigate to 
 */
function cc_navigateTo(url) {
    top.location.replace(url);
}

/**
 * Navigates to the given url after a delay of millis
 * @param url the url to navigate to 
 * @param millis the millisecs to wait before navigating to the url
 * @return the timer object
 */
function cc_navigateToDeferred(url, millis) {
    return setTimeout(function () {
    					cc_navigateTo(url);
    		  		  }, millis);
}

/**
 * Gets the global function with the given name
 * @param functionName the function name to search
 * @returns the function or null if no function found
 */
function cc_getGlobalFunction(functionName) {

	// look for the global function in the window object
	var fn = window[functionName];
	// make sure it is a function
	return (typeof(fn) === "function" ? fn : null);
}
