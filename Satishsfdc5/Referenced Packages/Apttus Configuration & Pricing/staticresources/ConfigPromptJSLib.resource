	var needMoreProcessing;
    // Create a namespace for our custom functions
    //YAHOO.namespace("force.com");

    // wait panel

    /**
     * Builds the wait panel.
     */
    YAHOO.force.com.buildWaitPanel = function() {
		document.body.className = document.body.className + " yui-skin-sam";
		YAHOO.force.com.waitPanel = new YAHOO.widget.Panel(
		    "waitPanel",  // The id of our dialog container
		    { 
			    width           :   "300px", // You can play with this until it's right
			    visible         :   false,   // Should be invisible when rendered
			    draggable       :   false,   // Make the dialog draggable
			    close           :   false,   // Don't include a close title button
			    modal           :   true,    // Make it modal
			    fixedCenter     :   true,    // Keep centered if window is scrolled
			    zindex          :   5041,      // Make sure it's on top of everything
			    constraintoviewport: true,
	
			    // This line adds the appear/disapper fade effect
			    effect          :   {effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25}
	
		    }
		);
	
		// header
		YAHOO.force.com.waitPanel.setHeader(aptLoadingPageHeader);//"{!$Label.LoadingPage}");
		// set image
		YAHOO.force.com.waitPanel.setBody(aptDialogBody);//'<center><img src="{!URLFOR($Resource.Image_LoadingPage)}" /></center>');
		// Render the dialog to the document.body level of the DOM
		YAHOO.force.com.waitPanel.render(document.body);

    }

    /**
     * Callback when the action button is clicked
     */
    function onActionClick() {
		// show the modal panel
		YAHOO.force.com.waitPanel.show();
		// return false to allow the action to proceed
		return false;

    }

    /**
     * Callback when the action is completed
     */
    function onActionComplete() {
		// hide the modal panel
		if(needMoreProcessing == undefined || needMoreProcessing == false){
			if(!(YAHOO == undefined || YAHOO.force.com.waitPanel == undefined)){
				YAHOO.force.com.waitPanel.hide();
			}
		}
		
    }

    // confirmation panel

    //YAHOO.force.com.myDialog = new Object();
    //YAHOO.force.com.selectedLineNbr = new Object();

    /**
     * Build remove confirmation panel
     */
    YAHOO.force.com.buildConfirmationPanel = function() {

		document.body.className = document.body.className + " yui-skin-sam";
		YAHOO.force.com.confirmationPanel = new YAHOO.widget.Panel(
		    "confirmationPanel",  // The id of our dialog container
		    { 
			    width           :   "300px", // You can play with this until it's right
			    visible         :   false,   // Should be invisible when rendered
			    draggable       :   true,    // Make the dialog draggable
			    close           :   false,   // Don't include a close title button
			    modal           :   true,    // Make it modal
			    fixedCenter     :   true,    // Keep centered if window is scrolled
			    zindex          :   5042      // Make sure it's on top of everything
		    }
		 );
	
		// Render the dialog to the document.body level of the DOM
		//YAHOO.force.com.confirmationPanel.render(document.body);
		YAHOO.force.com.confirmationPanel.render();

    }
    
    /**
     * Show remove confirmation dialog
     */
    YAHOO.force.com.showRemoveConfirmation = function(lineNumber) {
		// save selected line item line number
		YAHOO.force.com.selectedLineNbr = lineNumber;
	
		// show the confirmation panel
		document.getElementById("confirmationPanel").style.display = "block";
		YAHOO.force.com.confirmationPanel.show();

    }

    /**
     * Handle remove product option group or product option component
     */
    YAHOO.force.com.remove = function() {
		// hide the confirmation panel
		YAHOO.force.com.confirmationPanel.hide();
		// show modal panel
		YAHOO.force.com.waitPanel.show();
		// delete the line item
		invokeDoDeleteLineItem(YAHOO.force.com.selectedLineNbr);

    }
    
    /**
	 * Builds the choice panel.
	 */
	YAHOO.force.com.buildChoicePanel = function() {
		// create the choice panel
		YAHOO.force.com.choicePanel = new YAHOO.widget.Panel(
		    "choicePanel",  // The id of our dialog container 
		    { 
			    width              :   "600px",  // You can play with this until it's right
			    visible            :   false,   // Should be invisible when rendered
			    draggable          :   true,    // Make the dialog draggable
			    close              :   false,    // Include a close title button
			    modal              :   true,   // Make it modal
			    fixedcenter        :   true,    // Keep centered if window is scrolled
			    zindex             :   5043,      // Make sure it's on top of everything
			    constraintoviewport:   false     // Constrain to viewport
		    }
		 );
		YAHOO.force.com.choicePanel.setHeader(aptRuleAlertHeader);
		// Render the panel to the document.body level of the DOM
		//YAHOO.force.com.choicePanel.render(document.body);
		YAHOO.force.com.choicePanel.render();
	}
		
	/**
	 * Builds the alert panel.
	 */
	YAHOO.force.com.buildAlertPanel = function() {
		// create the alert panel
		YAHOO.force.com.alertPanel = new YAHOO.widget.Panel(
		    "alertPanel",  // The id of our dialog container
		    { 
			    width              :   "400px",  // You can play with this until it's right
			    visible            :   false,   // Should be invisible when rendered
			    draggable          :   true,    // Make the dialog draggable
			    close              :   false,    // Include a close title button
			    modal              :   true,   // Make it modal
			    fixedcenter        :   true,    // Keep centered if window is scrolled
			    zindex             :   5044,      // Make sure it's on top of everything
			    constraintoviewport:   true     // Constrain to viewport
		    }
		 );
		YAHOO.force.com.alertPanel.setHeader("Error Information");
		// Render the panel to the document.body level of the DOM
		//YAHOO.force.com.alertPanel.render(document.body);
		YAHOO.force.com.alertPanel.render();
	}
	
    // miscellaneous line item panel

    /**
     * Builds the miscellaneous item panel
     */
    YAHOO.force.com.buildMiscItemPanel = function() {
		//document.body.className = document.body.className + " yui-skin-sam";
	
		YAHOO.force.com.miscItemPanel = new YAHOO.widget.Panel(
		    "miscItemPanel",  // The id of our dialog container
		    { 
			    width           :   "400px", // You can play with this until it's right
			    visible         :   false,   // Should be invisible when rendered
			    draggable       :   true,    // Make the dialog draggable
			    close           :   false,   // Don't include a close title button
			    modal           :   true,    // Make it modal
			    fixedCenter     :   true,    // Keep centered if window is scrolled
			    zindex          :   5045,      // Make sure it's on top of everything
	
			    // This line adds the appear/disapper fade effect
			    effect          :   {effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25} 
		    }
		 );
	
		// Render the dialog to the document.body level of the DOM
		YAHOO.force.com.miscItemPanel.render(document.body);

    }

    /**
     * Callback when the add miscellaneous item button is clicked
     */
    function onAddMiscItemClick() {

		// reset panel field values
		fldMiscChargeType.value = "";
		fldMiscDescription.value = "";
		fldMiscAmount.value = "";
	
		// show the modal panel
		document.getElementById("miscItemPanel").style.display = "block";
		YAHOO.force.com.miscItemPanel.show();

    }       

    /**
     * Callback when the ok action button is clicked
     */
    function onOkActionClick() {
		// hide the miscellaneous line item panel
		YAHOO.force.com.miscItemPanel.hide();
		// show modal panel
		YAHOO.force.com.waitPanel.show();
		// return false to allow the action to proceed
		return false;

    }

    /**
     * Callback when the ok action is completed
     */
    function onOkActionComplete() {
		// hide the modal panel
		YAHOO.force.com.waitPanel.hide();

    }

    /**
     * Builds the product detail panel
     */
    YAHOO.force.com.buildProductDetailPanel = function() {
		//document.body.className = document.body.className + " yui-skin-sam";
	
		YAHOO.force.com.productDetailPanel = new YAHOO.widget.Panel(
		    "productDetailPanel",  // The id of our dialog container
		    { 
			    width           :   "600px", // You can play with this until it's right
			    fixedcenter     :   "contained",
			    visible         :   false,   // Should be invisible when rendered
			    draggable       :   true,    // Make the dialog draggable
			    modal           :   true,    // Make it modal
			    close           :   true,
			    zindex          :   5046,      // Make sure it's on top of everything
	
			    // This line adds the appear/disapper fade effect
			    effect          :   {effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25} 
		    }
		 );
	
		// Render the dialog to the document.body level of the DOM
		YAHOO.force.com.productDetailPanel.render();

    }       
    
    /**
     * Get product information and display in popup panel
     * using JavaScript remoting
     */
    function getProductDetail(RemoteController, productId){
		document.getElementById('ctxProductName').innerHTML = aptLoadingPageHeader;
	    document.getElementById('ctxProductDescription').innerHTML = '';
	        
		RemoteController.getProductDescription(productId, function(result, event){
		    if (event.status) {
		        document.getElementById('ctxProductName').innerHTML = result.Name;
		        if(result.Description != undefined){
		        	document.getElementById('ctxProductDescription').innerHTML = result.Description;
				}
			} else {
		    	document.getElementById('ctxProductDescription').innerHTML = event.message;
			}
       	}, {escape:true});
		
		showProductDetailPanel();
	}
	
	/**
     * Get product information and display in popup panel
     * using JavaScript remoting
     * @param removeFunction name of the remote function with complete namespace
     * @param productId id of the product 
     */
    function getProductDetail2(remoteFunction, productId){
		document.getElementById('ctxProductName').innerHTML = aptLoadingPageHeader;
	    document.getElementById('ctxProductDescription').innerHTML = '';
	        
		Visualforce.remoting.Manager.invokeAction(remoteFunction, productId, function(result, event){
			    if (event.status) {
			        document.getElementById('ctxProductName').innerHTML = result.Name;
			        if(result.Description != undefined){
			        	document.getElementById('ctxProductDescription').innerHTML = result.Description;
					}
				} else {
			    	document.getElementById('ctxProductDescription').innerHTML = event.message;
				}
	       	}, {escape:true});
		
		showProductDetailPanel();
	}
	           

    /**
     * Callback when mouseover product information icon
     */
    function showProductDetailPanel() {

		// show the modal panel
		document.getElementById("productDetailPanel").style.display = "block";              
		YAHOO.force.com.productDetailPanel.show();

    }
   
	//hide message and call doHideMessage function to update the appliedActionInfo record HideMessage field
	function aptHideMessage(ele, actionInfoId){
		if(ele.parentNode != undefined){
			ele.parentNode.style.visibility = "hidden";
		}
		invokeDoHideMessage(actionInfoId);
	}	
      
    // Function called when the DOM is ready to create the dialog,
    // render the dialog into the document body, add our dialog skin
    // css to the body tag, and wire up the buttons on our dialog   
    YAHOO.force.com.onDOMReady = function() {
		// build the confirmation panel
		YAHOO.force.com.buildConfirmationPanel();
		// build the misc item panel
		YAHOO.force.com.buildMiscItemPanel();
		// build the wait panel
		YAHOO.force.com.buildWaitPanel();
		// build the wait panel
		YAHOO.force.com.buildChoicePanel();
		// build the product detail panel
		YAHOO.force.com.buildProductDetailPanel();
		
		if(processWhenDomReady){
			processWhenDomReady();
		}

    }

    // build the tree as soon as the DOM is in a usable state
    //YAHOO.util.Event.onDOMReady(YAHOO.force.com.onDOMReady);  
    
    var ConfigPromptJSLibLoaded = true;  
