/**
 *	Apttus Proposal Management
 *	proposal.js
 *	 
 *	@2010-2011 Apttus Inc. All rights reserved.
 * 
 */

// constants


// messages
// update proposal
var qp_cERROR_UPDATE_PROPOSAL = "ERROR: updating the quote/proposal:\n";
// email template clone
var qp_cERROR_EMAILTEMPLATE_CLONE = "ERROR: cloning the email template:\n";
var qp_cERROR_AFTER_EMAILTEMPLATE_CLONE = "ERROR: cloning the email template:\n";
// email template delete
var qp_cERROR_EMAILTEMPLATE_DELETE = "ERROR: deleting email template:\n";
// after sent
var qp_cERROR_AFTER_PRESENT = "ERROR: presenting the proposal:\n";
// attachment copy
var qp_cERROR_ATTACHMENT_COPY = "ERROR: copying attachments:\n";
// build email author page
var qp_cERROR_BUILD_PAGE = "Error building the email author page:\n";

// unknown error
var qp_cERROR_UNKNOWN = "ERROR: Unknown error:\n";

function qp_showMsgProgress(msg) {
	// use standard waiting dots image
    qp_showMsgProgress2(msg, "/img/waiting_dots.gif");
    
}

function qp_showMsgProgress2(msg, imageUrl) {
    var html = "<center><p><p><h2>" + msg + "</h2>" +
        "<p><img src=\"" + imageUrl + "\"" + " border=\"0\" width=156 height=25></center>";
        
    qp_setMain(html);
    qp_showMain();
}

function qp_hideMsgProgress() {
	qp_resetMain();
	qp_hideMain();
}

function qp_resetMain() {
	qp_setMain("");
}

function qp_setMain(html) {
    document.getElementById("divMain").innerHTML = html;
}

function qp_showMain() {
    document.getElementById("divMain").style.visibility = "visible";
}

function qp_hideMain() {
    document.getElementById("divMain").style.visibility = "hidden";
}

function qp_erroralert(msg,exception) {
    
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
function qp_navigateTo(url) {
    top.location.replace(url);
}

/**
 * Navigates to the given url after a delay of millis
 * @param url the url to navigate to 
 * @param millis the millisecs to wait before navigating to the url
 * @return the timer object
 */
function qp_navigateToDeferred(url, millis) {
    return setTimeout(function () {
    					qp_navigateTo(url);
    		  		  }, millis);
}

/**
 * Gets the global function with the given name
 * @param functionName the function name to search
 * @returns the function or null if no function found
 */
function qp_getGlobalFunction(functionName) {

	// look for the global function in the window object
	var fn = window[functionName];
	// make sure it is a function
	return (typeof(fn) === "function" ? fn : null);
}

/**
 * Updates the given proposal sobject
 * @param proposalSO the proposal sobject to update 
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function qp_updateProposal(proposalSO) {
	
	// update the proposal 
	var result = sforce.apex.execute('Apttus_Proposal.ProposalWebService',
									 'updateProposal',
									 {proposalSO:proposalSO});
	
	if (result == null || result == '') {
		throw(qp_cERROR_UPDATE_PROPOSAL);
	} 
	
	return result.valueOf();
	
}

/**
 * Clones the given email template object
 * @param templateId the email template object id to clone 
 * @return the id of the email template clone
 */
function qp_cloneEmailTemplate(templateId) {
	
	// clone the email template
	var cloneId = sforce.apex.execute('Apttus_Proposal.ProposalWebService',
									  'cloneEmailTemplate',
									  {originalId:templateId});
	
	if (cloneId == null || cloneId == '') {
		throw(qp_cERROR_EMAILTEMPLATE_CLONE);
	} 
	
	// perform after clone tasks
	var result = sforce.apex.execute('Apttus_Proposal.ProposalWebService',
									 'afterEmailTemplateClone',
									 {originalId:templateId,
									  cloneId:cloneId});
	
	if (result == null || result == '') {
		throw(qp_cERROR_AFTER_EMAILTEMPLATE_CLONE);
	} 
	
	return cloneId;
	
}

/**
 * Deletes the given email template sobject
 * @param templateId the id of the email template sobject to delete 
 * @return <code>true</code> if the delete was successful, <code>false</code> otherwise
 */
function qp_deleteEmailTemplate(templateId) {
	
	// delete the email template object
	var result = sforce.apex.execute('Apttus_Proposal.ProposalWebService',
									 'deleteEmailTemplate',
									 {templateId:templateId});
	
	if (result == null || result == '') {
		throw(qp_cERROR_EMAILTEMPLATE_DELETE);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after a proposal is presented
 * @param proposalId the id of the proposal object 
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function qp_afterPresent(proposalId) {	
	
	// perform after present tasks
	var result = sforce.apex.execute('Apttus_Proposal.ProposalWebService',
									 'afterPresent',
									 {proposalId:proposalId});
	
	if (result == null || result == '') {
		throw(qp_cERROR_AFTER_PRESENT);
	} 
	
	return result.valueOf();
	
}

/**
 * Copies the given attachment sobject to the destination parent
 * @param destParentId the destination parent sobject id to copy the attachment sobject to 
 * @param attId the attachment sobject id to copy 
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function qp_copyAttachment(destParentId, attId) {
	
	// copy attachment child object
	var result = sforce.apex.execute('Apttus_Proposal.ProposalWebService',
									 'copyAttachment',
									 {destParentId:destParentId,
									  attId:attId});
	
	if (result == null || result == '') {
		throw(qp_cERROR_ATTACHMENT_COPY);
	} 
	
	return result.valueOf();
	
}

/**
 * Builds the email author page url using the given parameters
 * @param sObjectId the id of the context object 
 * @param tempEmailTemplateId the temporary email template id
 * @return the page url
 */
function qp_buildEmailAuthorPageURL(sObjectId, tempEmailTemplateId) {
	
	// build the page url 
	var result = sforce.apex.execute('Apttus_Proposal.ProposalWebService',
									 'buildEmailAuthorPageURL',
									 {sObjectId:sObjectId,
									  tempEmailTemplateId:tempEmailTemplateId});
	
	if (result == null || result == '') {
		throw(qp_cERROR_BUILD_PAGE);
	} 
	
	//return decodeURIComponent(result);
	return result;
	
}


