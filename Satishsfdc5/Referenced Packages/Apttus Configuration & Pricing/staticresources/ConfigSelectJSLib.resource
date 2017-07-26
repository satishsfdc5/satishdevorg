// Create a namespace for our custom functions
//YAHOO.namespace("force.com");

//YAHOO.force.com.optionPage = false;

// wait panel

/**
 * Callback when the pagesize value is changed
 */
function onChangePagesize() {
	// show the modal panel
	YAHOO.force.com.waitPanel.show();
	// dispatch the action
	invokeDoAdjustPageSize();

}

// detail panel
//YAHOO.force.com.globalCtx = new Object();
//YAHOO.force.com.clsNodes = new Array();
//YAHOO.force.com.selectedNode = new Object();

/**
 * Sets the selected node
 * @param ctxNode the context node
 */
YAHOO.force.com.setNode = function(ctxNode) {

	// save current selection
	YAHOO.force.com.selectedNode = ctxNode;
	
}										

// Function called when we want to hide the dialog
YAHOO.force.com.hideDialog = function() {
	YAHOO.force.com.myDialog.hide();
}

/**
 * Hides the detail panel
 */
YAHOO.force.com.hideDetail = function() {
	YAHOO.force.com.detailPanel.hide();
}

/**
 * When a node is exapanded 
 */
YAHOO.force.com.onExpand = function(node) { 
	node.multiExpand = true;
    //alert('expand = ' + node.data.object.label + ', node.multiExpand = ' + node.multiExpand);
    YAHOO.force.com.expandList[node.data.object.Id] = true;
	if(YAHOO.force.com.collapseList[node.data.object.Id]){
		delete YAHOO.force.com.collapseList[node.data.object.Id];
	}
	
}

/**
* When a node is collapsed 
*/
YAHOO.force.com.onCollapse = function(node) { 
	node.multiExpand = true;
    //alert('collapse = ' + node.data.object.label);
    YAHOO.force.com.collapseList[node.data.object.Id] = true;
	if(YAHOO.force.com.expandList[node.data.object.Id]){
		delete YAHOO.force.com.expandList[node.data.object.Id];
	}

}

/**
 * Callback when the remove item button is clicked
 */
function onRemoveItemClick() {
	
	// show the modal panel
	document.getElementById("confirmationPanel").style.display = "block";
	YAHOO.force.com.confimationPanel.show();
	
}
	
/**
 * Builds the detail panel.
 */
YAHOO.force.com.buildDetailPanel = function() {
	//document.body.className = document.body.className + " yui-pe-content";
	// create the detail panel
	YAHOO.force.com.detailPanel = new YAHOO.widget.Panel(
	    "detailPanel",  // The id of our dialog container
	    { 
		    width              :   "auto",  // You can play with this until it's right
		    visible            :   false,   // Should be invisible when rendered
		    draggable          :   true,    // Make the dialog draggable
		    close              :   true,    // Include a close title button
		    modal              :   false,   // Make it modal
		    fixedcenter        :   true,    // Keep centered if window is scrolled
		    zindex             :   5060,      // Make sure it's on top of everything
		    constraintoviewport:   true     // Constrain to viewport
	
	    }
	 );
	
	// Render the panel to the document.body level of the DOM
	//YAHOO.force.com.detailPanel.render(document.body);
	YAHOO.force.com.detailPanel.render();

}

/**
 * Builds the tree
 */
YAHOO.force.com.buildTree = function() {

	// create tree
	YAHOO.force.com.tree = new YAHOO.widget.TreeView("treeDiv"); 
	//YAHOO.force.com.tree.singleNodeHighlight = true;

	YAHOO.force.com.tree.subscribe("expand", YAHOO.force.com.onExpand); 
	YAHOO.force.com.tree.subscribe("collapse", YAHOO.force.com.onCollapse); 
	YAHOO.force.com.expandList = {}; 
	YAHOO.force.com.collapseList = {}; 
				            
	//get root node for tree:
	var root = YAHOO.force.com.tree.getRoot();
	root.multiExpand = true;
	var nodeStack = new Array();
	var parentNode;
	var parentName;
	var childNode;
	var obj;
	var objLabel;

	for (i=0; i < YAHOO.force.com.clsNodes.length; i++) {
		parentNode = root;
		obj = YAHOO.force.com.clsNodes[i];
		objParentId = obj.parentId;

		for(x=0; x < nodeStack.length; x++) {
			if (nodeStack[x].data.object.Id == objParentId) {
				parentNode = nodeStack[x];
				break;
			}
		}
		if(YAHOO.force.com.optionPage){
			childNode = new YAHOO.widget.MenuNode({label: obj.label, object: obj}, parentNode, obj.expanded);
		}else{
			if ((obj.expanded == "true") || (obj.leaf == "true")) {					
				childNode = new YAHOO.widget.MenuNode({label: obj.label, object: obj}, parentNode, true);
			} else {
				childNode = new YAHOO.widget.MenuNode({label: obj.label, object: obj}, parentNode, false);
				childNode.setDynamicLoad(YAHOO.force.com.loadNodeData, 1);
			}
		}
		if (obj.imageUrl.length > 0) {
			childNode.labelStyle = obj.Id;
		}
		childNode.multiExpand = true;
		if (obj.leaf == "true") {
			childNode.enableHighlight = true;
			YAHOO.util.Event.addListener(childNode.getElId(), "click", YAHOO.force.com.onClickHandler);

			if (obj.Id == classificationId) {
				childNode.toggleHighlight();
			}
		} else {
			childNode.enableHighlight = false;
		}
		if(YAHOO.force.com.optionPage){
		    //not implemented
		}else{
			childNode.setUpLabel(obj.label);
		}
		
		nodeStack.push(childNode);
	}
	if(YAHOO.force.com.optionPage){		
		YAHOO.force.com.tree.subscribe('clickEvent',YAHOO.force.com.tree.onEventToggleHighlight); 
	}
	// draw the tree
	YAHOO.force.com.tree.render();

}

/**
 * returns the list of categoryIds expanded or collapsed
 */
YAHOO.force.com.getExpansionInfo = function(){
	var str = '';
	for(a in YAHOO.force.com.expandList){
		str += a+',';
	}
	str += '_expand_collapse_';
	for(a in YAHOO.force.com.collapseList){
		str += a+',';
	}
	return str;

}	

/**
 * Expands the tree
 * @param ctxNode the node to expand
 * @param onCompleteCallback callback to invoke after completion
*/
YAHOO.force.com.loadNodeData = function(ctxNode, onCompleteCallback) { 

	// show the modal panel
	YAHOO.force.com.waitPanel.show();
	
	YAHOO.force.com.clsNodes = new Array();
	ctxNode.data.object.expanded = "true";
	YAHOO.force.com.globalCtx.ctxNode = ctxNode;
	YAHOO.force.com.globalCtx.hasCallback = "true";
	YAHOO.force.com.globalCtx.completeCallback = onCompleteCallback;
	
	// invoke action function
	invokeDoSelectClassification(ctxNode.data.object.Id, YAHOO.force.com.getExpansionInfo());

}	


/**
 * Inject style element into dom for classifiction icons/images
 */
YAHOO.force.com.createStyle = function(classId, imageUrl) {
	var styleElm = document.getElementById(classId);

	if (styleElm == null) {
		styleElm = document.createElement('style');
		styleElm.setAttribute("type", "text/css");
		styleElm.setAttribute("id", classId);

		var styleAttrs = new String('.' + classId);

		styleAttrs = styleAttrs.concat(' {background-color:transparent;');
		styleAttrs = styleAttrs.concat('background-image:url(\'').concat(imageUrl).concat('\');');
		styleAttrs = styleAttrs.concat('display:block;');
		//styleAttrs = styleAttrs.concat('height:22px;');
		styleAttrs = styleAttrs.concat('padding-left:20px;');
		styleAttrs = styleAttrs.concat('background-repeat:no-repeat;');
		styleAttrs = styleAttrs.concat('background-position:left top;');
		styleAttrs = styleAttrs.concat('background-attachment:0;}');

		if(styleElm.styleSheet){// IE
			styleElm.styleSheet.cssText = styleAttrs;

		} else {// w3c
			var styleBody = document.createTextNode(styleAttrs);
			styleElm.appendChild(styleBody);

		}

		document.getElementsByTagName('head')[0].appendChild(styleElm);

	}

}	

/**
 * Handle leaf node click event
 */
YAHOO.force.com.onClickHandler = function(event) {

	// hide the detail panel
	YAHOO.force.com.hideDetail();

	// get the event target	
    var target = YAHOO.util.Event.getTarget(event);
	// get the context node
    var ctxNode = YAHOO.force.com.tree.getNodeByElement(target);

    if (!ctxNode) {
		// Cancel the display of the ContextMenu instance.
		this.cancel();

    }

	// set the selected node
	YAHOO.force.com.setNode(ctxNode);

	// if no node selected, abort
	if (!YAHOO.force.com.selectedNode) {
		// Cancel the display of the ContextMenu instance.
		this.cancel();

    }

	var hiLiteNodes = YAHOO.force.com.tree.getNodesByProperty('highlightState',1);   

	// show the modal panel
	YAHOO.force.com.waitPanel.show();
	
	if (YAHOO.lang.isNull(hiLiteNodes)) {
		if(YAHOO.force.com.optionPage){    
			invokedoGetGroupOptions(ctxNode.data.object.Id);
		
		}else{
			invokeDoGetClassificationProducts(ctxNode.data.object.Id, YAHOO.force.com.getExpansionInfo());

		}

	} else {       
		if (ctxNode.highlightState == 1) {
			if(YAHOO.force.com.optionPage){    
				invokeDoClearOptions(ctxNode.data.object.Id);
				YAHOO.force.com.waitPanel.hide();
			}else{
				invokeDoGetClassificationProducts(ctxNode.data.object.Id, YAHOO.force.com.getExpansionInfo()); //added by dd. only problem is in hilite color 
				//invokeDoRemoveClassificationProducts(ctxNode.data.object.Id);
			}	
			//YAHOO.force.com.waitPanel.hide();
		} else {
			if(YAHOO.force.com.optionPage){    
				invokedoGetGroupOptions(ctxNode.data.object.Id);
			
			}else{
				invokeDoGetClassificationProducts(ctxNode.data.object.Id, YAHOO.force.com.getExpansionInfo());
			}	

		}

	} 
	
}	

/**
 * Invoke search if Enter key was pressed
 * TODO: move to ConfigJSLib, combine with SearchFilter.component 
 */
function handleEnterKeySearch(event){ 
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
		YAHOO.force.com.waitPanel.show(); 

		// invoke search
		invokeDoSearch(); 
		
		return true; 
	}
	return false; 
} 

/**
 * Handles "contextmenu" events for the element(s) that
 * triggered the display of the ContextMenu instance - used
 * to set a reference to the TextNode instance that triggered
 * the display of the ContextMenu instance.
 * @param event the contextmenu event
 */
YAHOO.force.com.onDOMReady2 = function() {

	// add our custom skin css to the body tag
	document.body.className = document.body.className + " yui-skin-sam";					

	// build the tree
	YAHOO.force.com.buildTree();							

	// build the detail panel
	YAHOO.force.com.buildDetailPanel();						

	// build the product description panel
	//YAHOO.force.com.buildProductDetailPanel();

	// build the wait panel
	//YAHOO.force.com.buildWaitPanel();

}	

// build the tree as soon as the DOM is in a usable state
//YAHOO.util.Event.onDOMReady(YAHOO.force.com.onDOMReady2);   	
