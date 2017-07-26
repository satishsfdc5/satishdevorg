public class ProjectCreateExtension {
    Private ApexPages.StandardController sc;
    
    Public ProjectCreateExtension(ApexPages.StandardController standardController){
        //storing reference to standard controller
        sc = standardController;
    }
    Public pageReference ToPage1(){
        return Page.ProjectCreate1;
    }
    Public pageReference ToPage2(){
        return Page.ProjectCreate2;
    }
    Public pageReference ToPage3(){
        return Page.ProjectCreate3;
    }

}