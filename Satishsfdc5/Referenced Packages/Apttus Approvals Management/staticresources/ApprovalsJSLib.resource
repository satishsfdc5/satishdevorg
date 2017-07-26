/**
 *	Apttus Approvals Management
 *	ApprovalsJSLib.js
 *	 
 *	@2011 Apttus Inc. All rights reserved.
 * 
 */

/**
 * Show error message dialog
 */
function ap_erroralert(msg, exception) {
    
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
 * Submit given approval context
 * @param sObjectType the approval context sobject type 
 * @param sObjectId the approval context sobject identifier
 * @return <code>true</code> if successful
 */
function ap_submitForApprovals(sObjectType, sObjectId) {
	
	// submit approvals
	var result = sforce.apex.execute('Apttus_Approval.ApprovalsWebService',
									 'submitForApprovals',
									 {sObjectType:sObjectType,
									  sObjectId:sObjectId});
	
	if (result == null || result == '') {
		throw(ap_cERROR_SUBMIT_APPROVALS);
		
	} 
	
	return result.valueOf();
	
}

/**
 * Preview given approval context
 * @param sObjectType the approval context sobject type 
 * @param sObjectId the approval context sobject identifier
 * @return <code>true</code> if successful
 */
function ap_previewApprovals(sObjectType, sObjectId) {
	
	// preview approvals
	var result = sforce.apex.execute('Apttus_Approval.ApprovalsWebService',
									 'previewApprovals',
									 {sObjectType:sObjectType,
									  sObjectId:sObjectId});
	
	if (result == null || result == '') {
		throw(ap_cERROR_PREVIEW_APPROVALS);
		
	} 
	
	return result.valueOf();
	
}

/**
 * Cancel given approval context
 * @param sObjectType the approval context sobject type 
 * @param sObjectId the approval context sobject identifier
 * @return <code>true</code> if successful
 */
function ap_cancelApprovals(sObjectType, sObjectId) {
	
	// cancel approvals
	var result = sforce.apex.execute('Apttus_Approval.ApprovalsWebService',
									 'cancelApprovals',
									 {sObjectType:sObjectType,
									  sObjectId:sObjectId});
	
	if (result == null || result == '') {
		throw(ap_cERROR_CANCEL_APPROVALS);
		
	} 
	
	return result.valueOf();
	
}

/**
 * Copies the given attachment sobject to the destination parent
 * @param destParentId the destination parent sobject id to copy the attachment sobject to 
 * @param attId the attachment sobject id to copy 
 * @return <code>true</code> if the copy was successful, <code>false</code> otherwise
 */
function ap_copyAttachment(destParentId, attId) {
	
	// copy attachment child object
	var result = sforce.apex.execute('Apttus_Approval.ApprovalsWebService',
									 'copyAttachment',
									 {destParentId:destParentId,
									  attId:attId});
	
	if (result == null || result == '') {
		throw(ap_cERROR_ATTACHMENT_COPY);
		
	} 
	
	return result.valueOf();
	
}
