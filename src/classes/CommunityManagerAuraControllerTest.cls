@isTest
// this testclass covers CommunityManagerAuraController
public class CommunityManagerAuraControllerTest {
    
    static testMethod void testYourAccountManager() {
                
        Id profileId = [select id from profile where name='Partner Community User'].id;
        
        // create the account with contact
        Account acc = new Account(name ='EuroFiberTestAccount') ;
        insert acc; 
        Contact con = new Contact(FirstName='Pieter',LastName ='van Tester',AccountId = acc.Id);
        insert con;
        
        // create the portal user
        User portalUser = new User(alias = 'Tester2', email='testUserOne@eurofiber.nl',
                                    emailencodingkey='UTF-8', lastname='van Tester', languagelocalekey='en_US',
                                    localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,
                                    ContactId = con.Id,
                                    timezonesidkey='America/Los_Angeles', username='testUserOne@eurofiber.nl');
        insert portalUser;
        
        // run as portalUser , to check if can be retrieved
        system.runAs(portalUser){
            // get the account with its owner/manager
            Account usersAccount = [Select OwnerId FROM Account where id = :con.AccountId];
            // check if the users manager is the account owner
            system.assertEquals(usersAccount.OwnerId,  CommunityManagerAuraController.getManagerUser().id);
        }
        //run as admin user so that there will not ba a accountmanager
        system.assertEquals(null,  CommunityManagerAuraController.getManagerUser());
    }
}