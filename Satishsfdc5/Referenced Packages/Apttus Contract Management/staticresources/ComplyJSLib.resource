/**
 *	Apttus Contract Management
 *	comply.js
 *	 
 *	@2009-2013 Apttus Inc. All rights reserved.
 * 
 */

// constants

// action names
var cACTION_CREATE_NEW_AGREEMENT = "create_new_agreement";
var cACTION_CREATE_OPPTY_AGREEMENT = "create_oppty_agreement";
var cACTION_CREATE_OFFLINE_AGREEMENT = "create_offline_agreement";
var cACTION_CREATE_CHILD_AGREEMENT = "create_child_agreement";
var cACTION_STORE_EXECUTED_AGREEMENT = "store_executed_agreement";
var cACTION_CLONE_AGREEMENT = "clone_agreement";
var cACTION_AMEND_AGREEMENT = "amend_agreement";
var cACTION_RENEW_AGREEMENT = "renew_agreement";

// params
var cPARAM_ACTION_NAME = "actionName";
var cPARAM_ID = "id";
var cPARAM_CLONE_ID = "cloneId";
var cPARAM_ORIGINAL_ID = "originalId";
var cPARAM_AMENDMENT_ID = "amendmentId";
var cPARAM_RENEWAL_ID = "renewalId";
var cPARAM_AGREEMENT_ID = "agreementId";
var cPARAM_OPPORTUNITY_ID = "opportunityId";
var cPARAM_RETURN_ID = "retId";
var cPARAM_OBJECT_TYPE = "objectType";

// relationship name
var cRELATIONSHIP_NAME_ATTACHMENTS = "Attachments";

// messages

// agreement child objects
var cCOPY_CHILD_OBJECTS = "Please wait...";
var cSUCCESS_COPY_CHILD_OBJECTS = "SUCCESS: copied child objects for the agreement:\n";

// template child objects
var cCOPY_TEMPLATE_CHILD_OBJECTS = "Please wait...";
var cSUCCESS_COPY_TEMPLATE_CHILD_OBJECTS = "SUCCESS: copied child objects for the template:\n";

// agreement rule child objects
var cCOPY_AGREEMENTRULE_CHILD_OBJECTS = "Please wait...";
var cSUCCESS_COPY_AGREEMENTRULE_CHILD_OBJECTS = "SUCCESS: copied child objects for the agreement rule:\n";

// query template child objects
var cCOPY_QUERYTEMPLATE_CHILD_OBJECTS = "Please wait...";
var cSUCCESS_COPY_QUERYTEMPLATE_CHILD_OBJECTS = "SUCCESS: copied child objects for the query template:\n";

// agreement after clone
var cAFTER_CLONE = "Please wait...";
var cSUCCESS_AFTER_CLONE = "SUCCESS: cloned the agreement:\n";

// template after clone
var cAFTER_TEMPLATE_CLONE = "Please wait...";
var cSUCCESS_AFTER_TEMPLATE_CLONE = "SUCCESS: cloned the template:\n";

// agreement rule after clone
var cAFTER_AGREEMENTRULE_CLONE = "Please wait...";
var cSUCCESS_AFTER_AGREEMENTRULE_CLONE = "SUCCESS: cloned the agreement rule:\n";

// query template after clone
var cAFTER_QUERYTEMPLATE_CLONE = "Please wait...";
var cSUCCESS_AFTER_QUERYTEMPLATE_CLONE = "SUCCESS: cloned the query template:\n";

// after create 
var cAFTER_CREATE_AGREEMENT = "Please wait...";
var cSUCCESS_AFTER_CREATE_AGREEMENT = "SUCCESS: created the agreement:\n";

// after amend
var cAFTER_AMEND = "Please wait...";
var cSUCCESS_AFTER_AMEND = "SUCCESS: amended the agreement:\n";

// after renew
var cAFTER_RENEW = "Please wait...";
var cSUCCESS_AFTER_RENEW = "SUCCESS: renewed the agreement:\n";

// after sent for review
var cAFTER_SENT_FOR_REVIEW = "Please wait...";
var cSUCCESS_AFTER_SENT_FOR_REVIEW = "SUCCESS: sent the agreement for review:\n";

// after sent for signatures
var cAFTER_SENT_FOR_SIGNATURES = "Please wait...";
var cSUCCESS_AFTER_SENT_FOR_SIGNATURES = "SUCCESS: sent the agreement for signatures:\n";

// document actions
var cGENERATE_DOC = "Generating document - Please wait...";
var cPROTECT_DOC = "Protecting documents - Please wait...";
var cUNPROTECT_DOC = "Unprotecting documents - Please wait...";
var cUPDATE_DOC = "Updating documents - Please wait...";

// wait message
var cPLEASE_WAIT = "Please wait...";

function showMsgProgress(msg) {
    var html = "<center><p><p><h2>" + msg + "</h2>" +
        "<p><img src=\"/img/waiting_dots.gif\" border=\"0\" width=156 height=25></center>";
    
    setMain(html);
    showMain();
}

function hideMsgProgress() {
	resetMain();
    hideMain();
}

function resetMain() {
    setMain("");
}

function setMain(html) {
    document.getElementById("divMain").innerHTML = html;
}

function showMain() {
    document.getElementById("divMain").style.visibility = "visible";
}

function hideMain() {
    document.getElementById("divMain").style.visibility = "hidden";
}

function erroralert(msg,exception) {
    
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
function navigateTo(url) {
    top.location.replace(url);
}

/**
 * Navigates to the given url after a delay of millis
 * @param url the url to navigate to 
 * @param millis the millisecs to wait before navigating to the url
 * @return the timer object
 */
function navigateToDeferred(url, millis) {
    return setTimeout(function () {
    					navigateTo(url);
    		  		  }, millis);
}

/**
 * Gets the text content of the given node
 * @param node the node to get the text content for 
 * @return the text content
 */
function getTextContent(node) {
	
	if (node == null) {
		return null;
	}
	
	// string buffer to accumulate text from child nodes
	var sb = [];
	// get the text content from the subtree
	getText(node, sb);
	// concatenate child text elements
	return sb.join("");
	
	// function to recursively descend the subtree and add text content to the buffer
	function getText(node, sb) {
		if (node.nodeType == 3) {
			// text node
			sb.push(node. data);
		} else if (node.nodeType == 1) {
			// element node, descend the subtree
			for (var child = node.firstChild; child != null; child = child.nextSibling) {
				getText(child, sb);
			}
		}
	}
}

/**
 * Copies child sobjects from the source agreement to the destination agreement
 * @param sourceAgreementId the source agreement id to copy child sobjects from 
 * @param destAgreementId the destination agreement id to copy child sobjects to 
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function doCopyAgreementChildSObjects(sourceAgreementId, destAgreementId) {
	
	// show the progress section
	//showMain();
	
	try {
		
		// get child relationship names
		var result = sforce.apex.execute('Apttus.ComplyWebService','getAgreementChildRelationshipNamesForClone',{});
		
		var count = result.length;
		var relationshipNames = new Array();
		var copyAttachments = false;
		
		// STEP I - Copy child objects (skip attachments)
		//batchSize = 1;
		// copy child sobjects for each child relationship
		for (var i = 0; i < count; i++) {
			// process one relationship at a time (skip attachments in this phase)
			if (result[i] == cRELATIONSHIP_NAME_ATTACHMENTS) {
				copyAttachments = true;
				
			} else {
				relationshipNames[0] = result[i];
				// copy child objects
				copyAgreementChildSObjects(sourceAgreementId, destAgreementId, relationshipNames);
			}
			
		}
		
		// STEP II - Copy attachments
		// get list of attachment ids to copy
		if (copyAttachments) {
			result = sforce.apex.execute('Apttus.ComplyWebService','getAttachmentIDsForParent',{parentId:sourceAgreementId});
			
			count = result.length;
			// copy attachments
			for (var i = 0; i < count; i++) {
				// copy one attachment at a time
				copyAttachment(destAgreementId, result[i]);
			}
		}
		
	} catch(e) {
		erroralert(cERROR_UNKNOWN,e);
	} finally {
		// hide the progress section
		//hideMain();
	}
	
}

/**
 * Copies child sobjects from the source agreement to the destination agreement
 * @param sourceAgreementId the source agreement id to copy child sobjects from 
 * @param destAgreementId the destination agreement id to copy child sobjects to 
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function doCopyAgreementChildSObjectsBatch(sourceAgreementId, destAgreementId) {
	
	// show the progress section
	//showMain();
	
	try {
		
		// get child relationship names
		var result = sforce.apex.execute('Apttus.ComplyWebService','getAgreementChildRelationshipNamesForClone',{});
		
		var count = result.length;
		var relationshipNames = new Array();
		
		//batchSize = 10;
		// copy child sobjects for each child relationship
		for (var i = 0; i < count; i+= 10) {
			// truncate the array
			relationshipNames.length = 0;
			// batch relationship names
			for (var j = i, k = 0; j < count && j < i+10; j++,k++) {
				relationshipNames[k] = result[j];
			}
			
			// copy child objects
			copyAgreementChildSObjects(sourceAgreementId, destAgreementId, relationshipNames);
		}
	} catch(e) {
		erroralert(cERROR_UNKNOWN,e);
	} finally {
		// hide the progress section
		//hideMain();
	}
	
}

/**
 * Copies child sobjects from the source agreement to the destination agreement
 * @param sourceAgreementId the source agreement id to copy child sobjects from 
 * @param destAgreementId the destination agreement id to copy child sobjects to 
 * @param relationshipNames the list of child relationship names to do the copy for
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function copyAgreementChildSObjects(sourceAgreementId, destAgreementId, relationshipNames) {
	
	// display the message
	//showMsgProgress(cCOPY_CHILD_OBJECTS);
	
	// copy agreement child objects
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'copyAgreementChildSObjects',
									 {sourceAgreementId:sourceAgreementId,
									  destAgreementId:destAgreementId,
									  relationshipNames:relationshipNames});
	
	if (result == null || result == '') {
		throw(cERROR_COPY_CHILD_OBJECTS);
	} 
	
	return result.valueOf();
	
}

/**
 * Copies child sobjects from the source template to the destination template
 * @param sourceTemplateId the source template id to copy child sobjects from 
 * @param destTemplateId the destination template id to copy child sobjects to 
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function doCopyTemplateChildSObjects(sourceTemplateId, destTemplateId) {
	
	// show the progress section
	//showMain();
	
	try {
		
		// get child relationship names
		var result = sforce.apex.execute('Apttus.ComplyWebService','getTemplateChildRelationshipNamesForClone',{});
		
		var count = result.length;
		var relationshipNames = new Array();
		
		// STEP I - Copy child objects (skip attachments)
		//batchSize = 1;
		// copy child sobjects for each child relationship
		for (var i = 0; i < count; i++) {
			// process one relationship at a time (skip attachments in this phase)
			if (result[i] != cRELATIONSHIP_NAME_ATTACHMENTS) {
				relationshipNames[0] = result[i];
				// copy child objects
				copyTemplateChildSObjects(sourceTemplateId, destTemplateId, relationshipNames);
			}
		}
		
		// STEP II - Copy attachments
		// get list of attachment ids to copy
		result = sforce.apex.execute('Apttus.ComplyWebService','getAttachmentIDsForParent',{parentId:sourceTemplateId});
		
		count = result.length;
		// copy attachments
		for (var i = 0; i < count; i++) {
			// copy one attachment at a time
			copyAttachment(destTemplateId, result[i]);
		}
		
	} catch(e) {
		erroralert(cERROR_UNKNOWN,e);
	} finally {
		// hide the progress section
		//hideMain();
	}
	
}

/**
 * Copies child sobjects from the source template to the destination template
 * @param sourceTemplateId the source template id to copy child sobjects from 
 * @param destTemplateId the destination template id to copy child sobjects to 
 * @param relationshipNames the list of child relationship names to do the copy for
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function copyTemplateChildSObjects(sourceTemplateId, destTemplateId, relationshipNames) {
	
	// display the message
	//showMsgProgress(cCOPY_TEMPLATE_CHILD_OBJECTS);
	
	// copy agreement child objects
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'copyTemplateChildSObjects',
									 {sourceTemplateId:sourceTemplateId,
									  destTemplateId:destTemplateId,
									  relationshipNames:relationshipNames});
	
	if (result == null || result == '') {
		throw(cERROR_COPY_TEMPLATE_CHILD_OBJECTS);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement is cloned
 * @param originalId the id of the original agreement object 
 * @param cloneId the id of the agreement clone object
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterAgreementClone(originalId, cloneId) {
	
	// display the message
	//showMsgProgress(cAFTER_CLONE);
	
	// perform after clone tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterAgreementClone',
									 {originalId:originalId,
									  cloneId:cloneId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_CLONE);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after a template is cloned
 * @param originalId the id of the original template object 
 * @param cloneId the id of the template clone object
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterTemplateClone(originalId, cloneId) {
	
	// display the message
	//showMsgProgress(cAFTER_TEMPLATE_CLONE);
	
	// perform after clone tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterTemplateClone',
									 {originalId:originalId,
									  cloneId:cloneId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_TEMPLATE_CLONE);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement rule is cloned
 * @param originalId the id of the original agreement rule object 
 * @param cloneId the id of the agreement rule clone object
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterAgreementRuleClone(originalId, cloneId) {
	
	// display the message
	//showMsgProgress(cAFTER_AGREEMENTRULE_CLONE);
	
	// perform after clone tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterAgreementRuleClone',
									 {originalId:originalId,
									  cloneId:cloneId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_AGREEMENTRULE_CLONE);
	} 
	
	return result.valueOf();
	
}

/**
 * Clones the given email template object
 * @param templateId the email template object id to clone 
 * @return the id of the email template clone
 */
function cloneEmailTemplate(templateId) {
	
	// clone email template
	var cloneId = sforce.apex.execute('Apttus.ComplyWebService',
									  'cloneEmailTemplate',
									  {originalId:templateId});
	
	if (cloneId == null || cloneId == '') {
		throw(cERROR_EMAILTEMPLATE_CLONE);
	} 
	
	// perform after clone tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterEmailTemplateClone',
									 {originalId:templateId,
									  cloneId:cloneId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_EMAILTEMPLATE_CLONE);
	} 
	
	return cloneId;
	
}

/**
 * Callback invoked after an email template is cloned
 * @param originalId the id of the original template object 
 * @param cloneId the id of the template clone object
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterEmailTemplateClone(originalId, cloneId) {
	
	// perform after clone tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterEmailTemplateClone',
									 {originalId:originalId,
									  cloneId:cloneId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_EMAILTEMPLATE_CLONE);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after a query template is cloned
 * @param originalId the id of the original query template object 
 * @param cloneId the id of the query template clone object
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterQueryTemplateClone(originalId, cloneId) {
	
	// display the message
	//showMsgProgress(cAFTER_QUERYTEMPLATE_CLONE);
	
	// perform after clone tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterQueryTemplateClone',
									 {originalId:originalId,
									  cloneId:cloneId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_QUERYTEMPLATE_CLONE);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement is created from an opportunity
 * @param agreementId the id of the agreement object 
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterCreateFromOpportunity(agreementId) {
	
	// display the message
	//showMsgProgress(cAFTER_CREATE_AGREEMENT);
	
	// perform after create tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterCreateFromOpportunity',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_CREATE_AGREEMENT);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an executed agreement is stored
 * @param agreementId the id of the agreement object 
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterStoreExecuted(agreementId) {
	
	// display the message
	//showMsgProgress(cAFTER_CREATE_AGREEMENT);
	
	// perform after store tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterStoreExecuted',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_CREATE_AGREEMENT);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement is created offline
 * @param agreementId the id of the agreement object 
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterCreateOffline(agreementId) {
	
	// display the message
	//showMsgProgress(cAFTER_CREATE_AGREEMENT);
	
	// perform after store tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterCreateOffline',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_CREATE_AGREEMENT);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after a child agreement is created
 * @param agreementId the id of the child agreement object 
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterCreateChild(agreementId) {
	
	// display the message
	//showMsgProgress(cAFTER_CREATE_AGREEMENT);
	
	// perform after store tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterCreateChild',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_CREATE_AGREEMENT);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement is amended
 * @param originalId the id of the original agreement object 
 * @param amendmentId the id of the agreement amendment object
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterAmend(originalId, amendmentId) {
	
	// display the message
	//showMsgProgress(cAFTER_AMEND);
	
	// perform after amend tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterAmend',
									 {originalId:originalId,
									  amendmentId:amendmentId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_AMEND);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement is renewed
 * @param originalId the id of the original agreement object 
 * @param renewalId the id of the agreement renewal object
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterRenew(originalId, renewalId) {
	
	// display the message
	//showMsgProgress(cAFTER_RENEW);
	
	// perform after renew tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterRenew',
									 {originalId:originalId,
									  renewalId:renewalId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_RENEW);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement is sent for review
 * @param agreementId the id of the agreement object 
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterSentForReview(agreementId) {	
	
	// perform after sent for review tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterSentForReview',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_SENT_FOR_REVIEW);
	} 
	
	return result.valueOf();
	
}

/**
 * Callback invoked after an agreement is sent for signatures
 * @param agreementId the id of the agreement object 
 * @return <code>true</code> if the callback was successful, <code>false</code> otherwise
 */
function afterSentForSignatures(agreementId) {
	
	// perform after sent for signatures tasks
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'afterSentForSignatures',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_AFTER_SENT_FOR_SIGNATURES);
	} 
	
	return result.valueOf();
	
}

/**
 * Creates a new temporary object instance
 * @return the id of the new temporary object
 */
function createTemporaryObject() {
	
	// create temporary object
	var tobjectId = sforce.apex.execute('Apttus.ComplyWebService',
									    'createTemporaryObject',
									    {});
	
	if (tobjectId == null || tobjectId == '') {
		throw(cERROR_CREATE_TEMPOBJECT);
	} 
	
	return tobjectId;
	
}

/**
 * Copies the given attachment sobjects to the destination parent
 * @param destParentId the destination parent sobject id to copy the attachment sobjects to 
 * @param attIds the attachment sobjects to copy 
 * @return the list of copied attachment sobjects
 */
function copyAttachments(destParentId, attIds) {
	
	// copy attachment child objects
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'copyAttachments',
									 {destParentId:destParentId,
									  attIds:attIds});
	
	if (result == null || result == '') {
		throw(cERROR_ATTACHMENT_COPY);
	} 
	
	return result;
	
}

/**
 * Copies the given attachment sobject to the destination parent
 * @param destParentId the destination parent sobject id to copy the attachment sobject to 
 * @param attId the attachment sobject id to copy 
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function copyAttachment(destParentId, attId) {
	
	// copy attachment child object
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'copyAttachment',
									 {destParentId:destParentId,
									  attId:attId});
	
	if (result == null || result == '') {
		throw(cERROR_ATTACHMENT_COPY);
	} 
	
	return result.valueOf();
	
}

/**
 * Deletes the given attachment sobjects from the database 
 * @param attIds the attachment sobjects to delete 
 * @return <code>true</code> if the delete was successful, <code>false</code> otherwise
 */
function deleteAttachments(attIds) {
	
	// delete attachment objects
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'deleteAttachments',
									 {attIds:attIds});
	
	if (result == null || result == '') {
		throw(cERROR_ATTACHMENT_DELETE);
	} 
	
	return result.valueOf();
	
}

/**
 * Creates a searchable agreement document for the given attachment 
 * @param agreementId the agreement associated with the document
 * @param attId the id of the attachment holding the content
 * @return the agreement document object id
 */
function createAgreementDocument(agreementId, attId) {
	
	// create the agreement document
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'createAgreementDocument',
									 {agreementId:agreementId,
									  attId:attId});
	
	if (result == null || result == '') {
		throw(cERROR_CREATE_AGREEMENT_DOC);
	} 
	
	return result.toString();
	
}

/**
 * Creates a chatter feed for the given agreement attachment content
 * @param agreementId the agreement id to create the feed for
 * @param attId the id of the attachment holding the content
 * @return the chatter feed item object id
 */
function createChatterFeedForAgreement(agreementId, attId) {
	
	// create the chatter feed
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'createChatterFeedForAgreement',
									 {agreementId:agreementId,
									  attId:attId});
	
	if (result == null || result == '') {
		throw(cERROR_CREATE_CHATTER_FEED);
	} 
	
	return result.toString();
	
}

/**
 * Protects the documents associated with the given agreement
 * @param agreementId the agreement id to protect the documents for 
 * @param pLevel the protection level to apply to the document
 * @param docIds the ids of the documents to protect. If null all documents associated 
 * with the agreement will be protected
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function protectAgreementDocs(agreementId, pLevel, docIds) {
	
	// protect agreement documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'protectAgreementDocs',
									 {agreementId:agreementId,
									  pLevel:pLevel,
									  docIds:docIds});
	
	if (result == null || result == '') {
		throw(cERROR_PROTECT_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Protects the documents associated with the given email template
 * @param templateId the email template id to protect the documents for 
 * @param pLevel the protection level to apply to the document
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function protectEmailDocs(templateId, pLevel) {
	
	// protect email documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'protectEmailDocs',
									 {templateId:templateId,
									  pLevel:pLevel});
	
	if (result == null || result == '') {
		throw(cERROR_PROTECT_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Protects the documents associated with the given temporary object
 * @param tobjectId the temporary object id to protect the documents for 
 * @param pLevel the protection level to apply to the document
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function protectTemporaryDocs(tobjectId, pLevel) {
	
	// protect temporary documents 
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'protectTemporaryDocs',
									 {tobjectId:tobjectId,
									  pLevel:pLevel});
	
	if (result == null || result == '') {
		throw(cERROR_PROTECT_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Unprotects the documents associated with the given agreement
 * @param agreementId the agreement id to unprotect the documents for 
 * @param docIds the ids of the documents to unprotect. If null all documents associated 
 * with the agreement will be unprotected
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function unprotectAgreementDocs(agreementId, docIds) {
	
	// unprotect agreement documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'unprotectAgreementDocs',
									 {agreementId:agreementId,
									  docIds:docIds});
	
	if (result == null || result == '') {
		throw(cERROR_UNPROTECT_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Unprotects the documents associated with the given email template
 * @param templateId the email template id to protect the documents for 
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function unprotectEmailDocs(templateId) {
	
	// unprotect email documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'unprotectEmailDocs',
									 {templateId:templateId});
	
	if (result == null || result == '') {
		throw(cERROR_UNPROTECT_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Unprotects the documents associated with the given temporary object
 * @param tobjectId the temporary object id to unprotect the documents for 
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function unprotectTemporaryDocs(tobjectId) {
	
	// unprotect temporary documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'unprotectTemporaryDocs',
									 {tobjectId:tobjectId});
	
	if (result == null || result == '') {
		throw(cERROR_UNPROTECT_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Updates the documents associated with the given cloned agreement
 * @param agreementId the agreement id to update the documents for 
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function updateClonedAgreementDocs(agreementId) {
	
	// update cloned agreement documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'updateClonedAgreementDocs',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_UPDATE_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Updates the documents associated with the given agreement
 * @param agreementId the agreement id to update the documents for 
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function updateAgreementDocs(agreementId) {
	
	// update agreement documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'updateAgreementDocs',
									 {agreementId:agreementId});
	
	if (result == null || result == '') {
		throw(cERROR_UPDATE_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Updates the documents associated with the given template
 * @param templateId the template id to update the documents for 
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function updateTemplateDocs(templateId) {
	
	// update agreement documents
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'updateTemplateDocs',
									 {templateId:templateId});
	
	if (result == null || result == '') {
		throw(cERROR_UPDATE_DOC);
	} 
	
	return result.valueOf();
	
}

/**
 * Updates the given agreement sobject
 * @param agreement the agreement sobject to update 
 * @return <code>true</code> if the operation was successful, <code>false</code> otherwise
 */
function updateAgreement(agreement) {
	
	// update the agreement 
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'updateAgreement',
									 {agreement:agreement});
	
	if (result == null || result == '') {
		throw(cERROR_UPDATE_AGREEMENT);
	} 
	
	return result.valueOf();
	
}

/**
 * Deletes the given email template sobject
 * @param templateId the id of the email template sobject to delete 
 * @return <code>true</code> if the delete was successful, <code>false</code> otherwise
 */
function deleteEmailTemplate(templateId) {
	
	// delete the email template object
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'deleteEmailTemplate',
									 {templateId:templateId});
	
	if (result == null || result == '') {
		throw(cERROR_EMAILTEMPLATE_DELETE);
	} 
	
	return result.valueOf();
	
}

/**
 * Builds the page using the given parameters
 * @param paramNames the list of query string parameter names 
 * @param paramValues the list of query string parameter values 
 * @return the page url
 */
function buildPageURL(paramNames, paramValues) {
	
	// build the page url 
	var result = sforce.apex.execute('Apttus.ComplyWebService',
									 'buildPageURL',
									 {paramNames:paramNames,
								  	  paramValues:paramValues});
	
	if (result == null || result == '') {
		throw(cERROR_BUILD_PAGE);
	} 
	
	//return decodeURIComponent(result);
	return result;
	
}

/**
 * Gets the FQDN url
 * @return the FQDN url
 */
function getFQDNUrl() {
	
	// get the url detail for the agreement
	var result = sforce.connection.describeSObject("Apttus__APTS_Agreement__c");
    
	if (result == null || result == '') {
		throw(cERROR_UNKNOWN);
	} 
	
	// return the domain component
	return result.urlDetail.split("/{")[0];
	
}