public with sharing class AccountUtility 
{
    @AuraEnabled(cacheable=true)
    public static List<Student__c> getStudents()
    {
       return [Select Id, Name, Coarse_Fee__c, Date_Of_Birth__c from Student__c];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Book__c> getBooks()
    {
       return [Select Id, Name, Book_ID__c, Unit_Price__c from Book__c];
    }


    @AuraEnabled
    public static string updateAccRecord(string accId, string accTicker)
    {
        Account acc = new Account(Id = accId, TickerSymbol = accTicker);
        try {
            update acc;
        return 'Record Updated Successfully';
            
        } catch (Exception ex) {           
            return ex.getMessage();            
        }
        
        
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountWithIndustry(String passIndustry)
    {
        return [Select Id, Name, Industry, Rating, AnnualRevenue from Account WHERE Industry =: passIndustry];
    }
    @AuraEnabled
    public static string getAccountRecord(Id passId) 
    {
        Account acc = [Select Id, Name, Rating, Phone, Industry from Account where id=:passId];
        return  acc.Name;
       
    }

    @AuraEnabled(Cacheable=true)
    Public Static List<Account> getAccRec()
    {
        return [Select id, name, rating, industry from Account limit 10];
    }
    
    @AuraEnabled(Cacheable=true)
    public static List<AccountWrapper> getAccountByName(string passName)
    {
        List<AccountWrapper> lstwrap = new List<AccountWrapper>();      
                
        Account acc = [Select Id, Name, Rating, Industry, AnnualRevenue from Account where Name =: passName];
        AccountWrapper objwrap = new AccountWrapper();
        objwrap.accRecord = acc;
        objwrap.lstCon=[Select Id, FirstName, LastName, Phone, Email from Contact where AccountId =: acc.Id];
        objwrap.lstOpp=[Select Id, Name, Amount, StageName from Opportunity where AccountId =: acc.Id];
        lstwrap.add(objwrap);
        return lstwrap;              
    }

    public class AccountWrapper
    {
        @AuraEnabled
        public Account accRecord{get;set;}
        @AuraEnabled
        public List<Contact> lstCon{get;set;}
        @AuraEnabled
        public List<Opportunity> lstOpp{get;set;}
    }

    @AuraEnabled(cacheable=true)
    public static List<AccountWrapperclass> getAccountRelatedRecords(String inputId){
        List<Account> accRec=[Select Id, Name, Rating, Industry, Phone, AnnualRevenue,
                        (Select FirstName, LastName, Phone, Email, Title from Contacts),
                        (Select Name, Amount, StageName, CloseDate from Opportunities) 
                        from Account WHERE Id =: inputId];
                        List<AccountWrapperclass> aclstWrapper=new List<AccountWrapperclass>();
                       
                            for(Account accnt:accRec)
                            {
                                AccountWrapperclass wrapObject=new AccountWrapperclass();
                                wrapObject.acntrec=accnt;
                                wrapObject.lstConrec=accnt.Contacts;
                                wrapObject.lstOpp=accnt.Opportunities;
                                aclstWrapper.add(wrapObject);
                            }                           
                        
                        return aclstWrapper;  

    }
    public class AccountWrapperclass{
        @AuraEnabled
        public Account acntrec;
        @AuraEnabled
        public List<Contact> lstConrec;
        @AuraEnabled
        public List<Opportunity> lstOpp;

    }
}