/**
 *	Apttus Config & Pricing
 *	config.js
 *	 
 *	@2010-2011 Apttus Inc. All rights reserved.
 * 
 */

// constants
var aptIsIE = navigator.userAgent.toLowerCase().indexOf('msie') != 0;

// totaling steps
var cp_cTOTALING_STEP1 = "step1";
var cp_cTOTALING_STEP2 = "step2";
var cp_cTOTALING_STEP3 = "step3";
var cp_cTOTALING_ALLSTEPS = "allSteps";

// messages

// unknown error
var cp_cERROR_UNKNOWN = "ERROR: Unknown error:\n";

function cp_showMsgProgress(msg) {
    var html = "<center><p><p><h2>" + msg + "</h2>" +
        "<p><img src=\"/img/waiting_dots.gif\" border=\"0\" width=156 height=25></center>";
    
    cp_setMain(html);
    cp_showMain();
}

function cp_hideMsgProgress() {
	cp_resetMain();
	cp_hideMain();
}

function cp_resetMain() {
	cp_setMain("");
}

function cp_setMain(html) {
    document.getElementById("divMain").innerHTML = html;
}

function cp_showMain() {
    document.getElementById("divMain").style.visibility = "visible";
}

function cp_hideMain() {
    document.getElementById("divMain").style.visibility = "hidden";
}

function cp_erroralert(msg,exception) {
    
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
function cp_navigateTo(url) {
    top.location.replace(url);
}

/**
 * Navigates to the given url after a delay of millis
 * @param url the url to navigate to 
 * @param millis the millisecs to wait before navigating to the url
 * @return the timer object
 */
function cp_navigateToDeferred(url, millis) {
    return setTimeout(function () {
    					cp_navigateTo(url);
    		  		  }, millis);
}

/**
 * Gets the global function with the given name
 * @param functionName the function name to search
 * @returns the function or null if no function found
 */
function cp_getGlobalFunction(functionName) {

	// look for the global function in the window object
	var fn = window[functionName];
	// make sure it is a function
	return (typeof(fn) === "function" ? fn : null);
}


 //begin select all script
 var aptSearchedCheckboxes = [];
 var aptAddedCheckboxes = [];
 var aptAddedOptionCheckboxes = [];
 var aptSearchedSelectAll; //ref to SelectAll checkbox
 var aptAddedSelectAll;
 var aptAddedOptionSelectAll;
 
/**
 * mark all product list checkboxes as checked or unckecked based on current choice
 * @param btnSelecAll is the actual select all checkbox 
 * @param listName identifies the select list
 */
 function aptToggleSelectAll(btnSelectAll, listName){
	if(listName=='searched'){
		aptSearchedSelectAll = btnSelectAll;
		aptSelectCheckboxes(aptSearchedCheckboxes, btnSelectAll.checked);
		
	}else if(listName=='addedOption'){
		aptAddedOptionSelectAll = btnSelectAll;
		aptSelectCheckboxes(aptAddedOptionCheckboxes, btnSelectAll.checked);
		
	}else if(listName=='added'){
		aptAddedSelectAll = btnSelectAll;
		aptSelectCheckboxes(aptAddedCheckboxes, btnSelectAll.checked);
		
	}
 }
 /**
  * helper function to check or uncheck all checkboxes
  */
 function aptSelectCheckboxes(aptCheckboxes, isChecked){
 	if(aptCheckboxes.length){
	  for(i=0; i<aptCheckboxes.length; i++){
		var chkBox = document.getElementById(aptCheckboxes[i]);
	    if(chkBox){
			chkBox.checked = isChecked;
		}
	  }
	}
 }
/**
 * uncheck select all checkbox based on the list
 * @param listName is just a flag, either searched or added
 */
 function aptUncheckSelectAll(listName){
	if(listName=='searched' && aptSearchedSelectAll){
		aptSearchedSelectAll.checked = false;
	}else if(listName=='added' && aptAddedSelectAll){
		aptAddedSelectAll.checked = false;
	}else if(listName=='addedOption' && aptAddedOptionSelectAll){
		aptAddedOptionSelectAll.checked = false;
	}
 }
//end of select all script

/**
 * create popup window
 * @param urlOrContent url address or embed content
 * @param header header text on popup window
 * @content content of the popup window, when this has value url should be blank
 */
function aptCreatePopup(urlOrContent, header, isEmbed){
	if(urlOrContent=='' || urlOrContent=='null'){
		return false;
	}
	var url = isEmbed ? '' : urlOrContent;
	
	var pop1 = window.open(url, 'apttusPopup', 'menubar=1,resizable=1,width=712,height=500');
	if(isEmbed){
	  	pop1.document.write('<html><head><title>Apttus</title></head>');
	  	pop1.document.write('<body><center><h3>'+header+'</h3>');
	  	pop1.document.write(urlOrContent);
	  	pop1.document.write('</center></body></html>');
  	}
  	if(window.focus){
  		pop1.focus();
  	}
}

/**
 * Invoke search if Enter key was pressed, TODO: move this to ConfigJSLib.resource
 */
function aptHandleEnterKeySearch(event, hideWait){ 
	var keyCode; 
	if (event && event.which) { 
		// Use for Firefox and Chrome 
		keyCode = event.which; 

	} else { 
		// Use for IE 
	    keyCode = event.keyCode;

	}
	if (keyCode == 13) {
		// show the modal panel
		if(!hideWait){
			YAHOO.force.com.waitPanel.show();
		} 

		// invoke search
		aptInvokeDoSearch(); 

		return true; 
	}
	return false; 
}

/**
 * Igonore enter key press
 */
function aptIgnoreEnterKey(event, callback){ 
	var keyCode; 
	if (event && event.which) { 
		// Use for Firefox and Chrome 
		keyCode = event.which; 

	} else { 
		// Use for IE 
	    keyCode = event.keyCode;

	}
	if (keyCode == 13) {
		if(callback){
			callback();
		}
		return false; 
	}
	return true; 
}  

/**
 * Gets the list of summary line item objects (excluding option line items) for the given configuration
 * @param configId the product configuration id
 * @return the list of summary line item objects
 */
function getSummaryLineItemsForConfiguration(configId) {
	
	// get the summary line items
	var result = sforce.apex.execute('Apttus_Config2.PricingWebService',
									 'getSummaryLineItemsForConfiguration',
									 {configId:configId});
	
	if (result == null || result == '') {
		throw(cp_cERROR_UNKNOWN);
		
	} 
	
	return result;
	
}

/**
 * Computes the net price for items in the given line item collection
 * @param configId the product configuration id
 * @param lineNumber the line number associated with the item collection
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function computeNetPriceForItemColl(configId, lineNumber) {
	
	// compute net price
	var result = sforce.apex.execute('Apttus_Config2.PricingWebService',
									 'computeNetPriceForItemColl',
									 {configId:configId,
									  lineNumber:lineNumber});
	
	if (result == null || result == '') {
		throw(cp_cERROR_UNKNOWN);
	} 
	
	return result.valueOf();
	
}

/**
 * Computes the base price for items in the given line item collection
 * @param configId the product configuration id
 * @param lineNumber the line number associated with the item collection
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function computeBasePriceForItemColl(configId, lineNumber) {
	
	// compute net price
	var result = sforce.apex.execute('Apttus_Config2.PricingWebService',
									 'computeBasePriceForItemColl',
									 {configId:configId,
									  lineNumber:lineNumber});
	
	if (result == null || result == '') {
		throw(cp_cERROR_UNKNOWN);
	} 
	
	return result.valueOf();
	
}

/**
 * Computes the total price for items in the given product configuration
 * @param configId the product configuration id to compute the total price for
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function computeTotalPriceForCart(configId) {
	
	// compute net price
	var result = sforce.apex.execute('Apttus_Config2.PricingWebService',
									 'computeTotalPriceForCart',
									 {configId:configId});
	
	if (result == null || result == '') {
		throw(cp_cERROR_UNKNOWN);
	} 
	
	return result.valueOf();
	
}

/**
 * Executes the given total price step for items in the given product configuration
 * @param configId the product configuration id to execute the total price step for
 * @param stepName the totaling step to execute
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function executeTotalPriceStepForCart(configId, stepName) {
	
	// compute net price
	var result = sforce.apex.execute('Apttus_Config2.PricingWebService',
									 'executeTotalPriceStepForCart',
									 {configId:configId,
									  stepName:stepName});
	
	if (result == null || result == '') {
		throw(cp_cERROR_UNKNOWN);
	} 
	
	return result.valueOf();
	
}

/**
 * Combines delegate functions. Using this function the event that needs delegate function can call more than one function. 
 * @param function1 the first function to be delegated
 * @param function2 the second function to be delegated
 * @return the composite function
 */
function combineFunction(function1, function2) {
	return function() {
		if (function1) {
			function1();
		}    
		if (function2) {
			function2();
		}    
	}
}

