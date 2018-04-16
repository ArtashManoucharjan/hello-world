/********************************************************************************************
* Short Description: Controller to provide the manager information to the PortalUser
* @author          : Artash Manoucharjan
* @organisation    : ABSI NL
* @since           : 30/03/2018
*  ********************************************************************************************
*/
public class CommunityManagerAuraController {
    @AuraEnabled
    public static User getManagerUser(){
        
        //get the current user
        User communityUser = [select id, contactId from User where id = : UserInfo.getUserId()];
        
        //
        User managerUser =null;
        try{
            Contact c = [Select id,Account_Manager_ID__c FROM Contact WHERE id =:communityUser.ContactId];
            
            managerUser = [Select id,Name,Phone,LinkedIn__c,FullPhotoUrl FROM user where id =: c.Account_Manager_ID__c];
            //        User managerUser = [Select id,Name,Phone,FullPhotoUrl FROM user where id = '0050O000007BmIm'];
        }catch(Exception e){
            // coudn't find the manager of this user
            system.debug('coudn\'t find a manager for this user');
        }
        //return the manager if found, else null will be returned
        return managerUser;
    }
}