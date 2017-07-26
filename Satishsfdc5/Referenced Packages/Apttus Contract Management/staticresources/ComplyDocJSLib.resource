/**
 *	Apttus Contract Management
 *	complydoc.js
 *	 
 *	@2009 Apttus Inc. All rights reserved.
 * 
 *  Include <script type="text/javascript" src="/js/dojo/0.9/dojo/dojo.js"></script> before this file
 */

// constants actions
var cDOWNLOAD_DOC = "Downloading document... ";

/**
 * Downloads the document in a new window
 * @param docId the id of the document to download 
 * @param docName the name of the document to download 
 */
function downloadDoc(docId, docName) {
	
	// build the document url
	var docUrl = "/servlet/servlet.FileDownload";
	// add the document name
	if (docName != null) {
		docUrl += "/" + docName;
	}
	// add the document id
	docUrl += "?file=" + docId;
	
	// get the iframe to download the document
	var docFrame = document.getElementById("docFrame");
	if (docFrame != null) {
		docFrame.src = docUrl;
	}
	
}

