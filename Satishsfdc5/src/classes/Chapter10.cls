public class Chapter10 {
    
    /** Listing 10-1
SforceServiceLocator locator = new SforceServiceLocator();
SoapBindingStub binding = (SoapBindingStub)locator.getSoap();
LoginResult loginResult = binding.login(user, pass + securityToken);
binding._setProperty(SoapBindingStub.ENDPOINT_ADDRESS_PROPERTY,
  loginResult.getServerUrl());
SessionHeader sh = new SessionHeader();
sh.setSessionId(loginResult.getSessionId());
binding.setHeader(new SforceServiceLocator().getServiceName()
  .getNamespaceURI(), "SessionHeader", sh);
    */
    
    /** Listing 10-2
SforceService binding = new SforceService();
LoginResult result = binding.login(user, pass + securityToken);
binding.SessionHeaderValue = new SessionHeader();
binding.SessionHeaderValue.sessionId = result.sessionId;
binding.Url = result.serverUrl;
    */
    
    /** Listing 10-3
List<Proj__c> projects = new ArrayList<Proj__c>();
QueryResult qr = binding.query("SELECT Id, Name FROM Proj__c");
boolean done = false;
if (qr.getSize() > 0) {
  while (!done) {
    SObject[] records = qr.getRecords();
    if (records != null) {
      for (SObject record : records) {
        projects.add((Proj__c)record);
      }
      if (qr.isDone()) {
        done = true;
      } else {
        qr = binding.queryMore(qr.getQueryLocator());
      }
    }
  }
}
    */
    
    /** Listing 10-4
List<Proj__c> projects = new List<Proj__c>();
QueryResult qr = binding.query("SELECT Id, Name FROM Proj__c");
Boolean done = false;
if (qr.size > 0) {
  while (!done) {
    sObject[] records = qr.records;
    if (records != null) {
    foreach (sObject record in records) {
      projects.Add((Proj__c)record);
    }
    if (qr.done) {
      done = true;
    } else {
      qr = binding.queryMore(qr.queryLocator);
    }
  }
}
    */
    
    /** Listing 10-5
QueryOptions qo = new QueryOptions();
qo.setBatchSize(2000);
binding.setHeader(new SforceServiceLocator().
  getServiceName().getNamespaceURI(), "QueryOptions", qo);
    */
    
    /** Listing 10-6
binding.QueryOptionsValue = new QueryOptions();
binding.QueryOptionsValue.batchSize = 2000;
binding.QueryOptionsValue.batchSizeSpecified = true;
    */
    
    /** Listing 10-7
String newResourceId = null;
Contact contact = new Contact();
contact.setFirstName(firstName);
contact.setLastName(lastName);
SaveResult[] result = binding.create(
  new SObject[] { contact });
if (result != null && result.length == 1) {
  if (result[0].isSuccess()) {
    Resource__c resource = new Resource__c();
    resource.setActive__c(true);
    resource.setName(firstName + " " + lastName);
    resource.setContact__c(result[0].getId());
    SaveResult[] result2 = binding.create(
      new SObject[] { resource });
    if (result2 != null && result2.length == 1) {
      if (result2[0].isSuccess()) {
        newResourceId = result2[0].getId();
      } else {
        System.out.println("Failed to create resource: " + 
          result2[0].getErrors(0).getMessage());
      }
    }
  } else {
    System.out.println("Failed to create contact: " + 
      result[0].getErrors(0).getMessage());
  }
}
    */
    
    /** Listing 10-8
String newResourceId = null;
Contact contact = new Contact();
contact.FirstName = firstName;
contact.LastName = lastName;
SaveResult[] result = binding.create(
  new sObject[] { contact });
if (result != null && result.Length == 1) {
  if (result[0].success) {
    Resource__c resource = new Resource__c();
    resource.Active__c = true;
    resource.Name = firstName + " " + lastName;
    resource.Contact__c = result[0].id;
    SaveResult[] result2 = binding.create(
      new sObject[] { resource });
    if (result2 != null && result2.Length == 1) {
      if (result2[0].success) {
        newResourceId = result2[0].id;
      } else {
        Console.WriteLine("Failed to create resource: " + 
          result2[0].errors[0].message);
      }
    }
  } else {
    Console.WriteLine("Failed to create contact: " + 
      result[0].errors[0].message);
  }
}
    */
    
    /** Listing 10-9
global class Custom {
  webservice static ID createProject(String name) {
    Proj__c proj = new Proj__c(Name = name);
    insert proj;
    return proj.Id;
  }
}
    */
    
    /** Listing 10-10
public String createProject(String sessionId, String name)
  throws ServiceException, RemoteException {
  CustomServiceLocator locator = new CustomServiceLocator();
  CustomBindingStub serviceBinding =
    (CustomBindingStub)locator.getCustom();
  SessionHeader sh = new SessionHeader();
  sh.setSessionId(sessionId);
  serviceBinding.setHeader(locator.getServiceName()
    .getNamespaceURI(), "SessionHeader", sh);
  return serviceBinding.createProject(name);
}
    */
    
    /** Listing 10-11
public String CreateProject(String sessionId, String name) {
  CustomService service = new CustomService();
  service.SessionHeaderValue = new CustomWS.SessionHeader();
  service.SessionHeaderValue.sessionId = sessionId;
  return service.createProject(name);
}
    */
    
    /** Listing 10-12
public void createObject(String name, String pluralName) {
  MetadataServiceLocator locator = new MetadataServiceLocator();
  try {
    MetadataBindingStub mdBinding =
      (MetadataBindingStub)locator.getMetadata();
    SessionHeader sh = new SessionHeader();
    sh.setSessionId(sessionId);
    mdBinding.setHeader(locator.getServiceName()
      .getNamespaceURI(), "SessionHeader", sh);
    CustomObject obj = new CustomObject();
    obj.setFullName(name + "__c");
    obj.setLabel(name);
    obj.setPluralLabel(pluralName);
    obj.setDeploymentStatus(DeploymentStatus.Deployed);
    obj.setSharingModel(SharingModel.ReadWrite);
    CustomField nameField = new CustomField();
    nameField.setType(FieldType.AutoNumber);
    nameField.setLabel("Name");
    obj.setNameField(nameField);
    AsyncResult[] result = mdBinding.create(
      new Metadata[] { obj });
    if (result == null) {
      System.out.println("create failed");
      return;
      }
    boolean done = false;
    AsyncResult[] status = null;
    long waitTime = 1000;
    while (!done) {
      status = mdBinding.checkStatus(
        new String[] { result[0].getId() } );
      if (status != null) {
        done = status[0].isDone();
        if (status[0].getStatusCode() != null ) {
          System.out.println("Error: " +
            status[0].getStatusCode() + ": " +
            status[0].getMessage());
        }
        Thread.sleep(waitTime);
        waitTime *= 2;
        System.out.println("Current state: " +
          status[0].getState());
      }
    }
    System.out.println("Created object: " +
      status[0].getId());
  } catch (Throwable t) {
    t.printStackTrace();
  }
}
    */
    
    /** Listing 10-13
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import javax.xml.rpc.ServiceException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.sforce.soap.enterprise.Error;
import com.sforce.soap.enterprise.LoginResult;
import com.sforce.soap.enterprise.SessionHeader;
import com.sforce.soap.enterprise.SforceServiceLocator;
import com.sforce.soap.enterprise.SoapBindingStub;
import com.sforce.soap.enterprise.UpsertResult;
import com.sforce.soap.enterprise.fault.ApiFault;
import com.sforce.soap.enterprise.fault.LoginFault;
import com.sforce.soap.enterprise.sobject.Resource__c;
import com.sforce.soap.enterprise.sobject.SObject;
public class IntegrationDemo {
  SoapBindingStub binding;
  String sessionId;
  public void login(String user, String pass, String securityToken) {
    try {
      SforceServiceLocator locator = new SforceServiceLocator();
      binding = (SoapBindingStub)locator.getSoap();
    } catch (ServiceException e) {
      e.printStackTrace();
    }
    try {
      LoginResult loginResult = binding.login(user, pass +
        securityToken);
      binding._setProperty(SoapBindingStub.ENDPOINT_ADDRESS_PROPERTY,
        loginResult.getServerUrl());
      SessionHeader sh = new SessionHeader();
      sessionId = loginResult.getSessionId();
      sh.setSessionId(sessionId);
      binding.setHeader(new SforceServiceLocator().getServiceName()
        .getNamespaceURI(), "SessionHeader", sh);
    } catch (LoginFault e) {
      System.out.println("ExceptionCode: " +
        e.getExceptionCode());
    } catch (ApiFault e) {
      e.printStackTrace();
    } catch (RemoteException e) {
      e.printStackTrace();
    }
  }
  public void processImportFile(String jsonFile) {
    List<SObject> changes = new ArrayList<SObject>();
    try {
      String json = readFileAsString(jsonFile);
      JSONArray array = new JSONArray(json);
      for (int i=0; i<array.length(); i++) {
        changes.add(importResource(array.getJSONObject(i)));
      }
      if (changes.size() > 0) {
        UpsertResult[] results = binding.upsert("Resource_ID__c",
          changes.toArray(new SObject[changes.size()]));
        int line = 0;
        for (UpsertResult result : results) {
          System.out.print(line + ": ");
          if (!result.isSuccess()) {
            for (Error e : result.getErrors()) {
              System.out.println(e.getStatusCode() + ": " +
                e.getMessage());
            }
          } else {
            System.out.println("success");
          }
          line++;
        }
      }
    } catch (Throwable t) {
      t.printStackTrace();
    }
  }
  private Resource__c importResource(JSONObject rec)
    throws JSONException {
    Resource__c result = new Resource__c();
    result.setResource_ID__c(Double.valueOf(
      rec.getInt("ResourceID")));
    result.setActive__c(rec.getBoolean("Active"));
    return result;
  }
  private static String readFileAsString(String filePath)
    throws IOException {
    StringBuffer fileData = new StringBuffer(1000);
    BufferedReader reader = new BufferedReader(
      new FileReader(filePath));
    char[] buf = new char[2048];
    int numRead = 0;
    while((numRead = reader.read(buf)) != -1){
        fileData.append(buf, 0, numRead);
    }
    reader.close();
    return fileData.toString();
  }
  public static void main(String[] args) {
    IntegrationDemo demo = new IntegrationDemo();
    demo.login("USERNAME", "PASSWORD", "SECURITYTOKEN");
    demo.processImportFile("import.json");
  }
}
    */
    
    /** Listing 10-14
[
  {
    "ResourceID": 100000,
    "Active": false
  },
  {
    "ResourceID": 100001,
    "Active": false
  }
]
    */
    
    testmethod public static void test() {}
}