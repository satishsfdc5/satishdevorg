/**
 *	Apttus Proposal-Config Integration
 *	proposalconfig.js
 *	 
 *	@2010-2011 Apttus Inc. All rights reserved.
 * 
 */

// constants


// messages

// unknown error
var pc_cERROR_UNKNOWN = "ERROR: Unknown error:\n";

function pc_showMsgProgress(msg) {
	// use standard waiting dots image
	pc_showMsgProgress2(msg, "/img/waiting_dots.gif");
    
}

function pc_showMsgProgress2(msg, imageUrl) {
    var html = "<center><p><p><h2>" + msg + "</h2>" +
        "<p><img src=\"" + imageUrl + "\"" + " border=\"0\" width=156 height=25></center>";
        
    pc_setMain(html);
    pc_showMain();
}

function pc_hideMsgProgress() {
	pc_resetMain();
	pc_hideMain();
}

function pc_resetMain() {
	pc_setMain("");
}

function pc_setMain(html) {
    document.getElementById("divMain").innerHTML = html;
}

function pc_showMain() {
    document.getElementById("divMain").style.visibility = "visible";
}

function pc_hideMain() {
    document.getElementById("divMain").style.visibility = "hidden";
}

function pc_erroralert(msg, exception) {
    
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
function pc_navigateTo(url) {
    top.location.replace(url);
}

/**
 * Navigates to the given url after a delay of millis
 * @param url the url to navigate to 
 * @param millis the millisecs to wait before navigating to the url
 * @return the timer object
 */
function pc_navigateToDeferred(url, millis) {
    return setTimeout(function () {
    					pc_navigateTo(url);
    		  		  }, millis);
}

/**
 * Gets the global function with the given name
 * @param functionName the function name to search
 * @returns the function or null if no function found
 */
function pc_getGlobalFunction(functionName) {

	// look for the global function in the window object
	var fn = window[functionName];
	// make sure it is a function
	return (typeof(fn) === "function" ? fn : null);
}
