import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    var user:DObjectUser!
    
    //MARK: private
    
    private func createUser()
    {
        DManager.sharedInstance.createManagedObject(
            modelType:DObjectUser.self)
        { (object:DObjectUser) in
            
            self.user = object
            self.user.defaultName()
            
            DManager.sharedInstance.save()
            
            self.userLoaded()
        }
    }
    
    private func userLoaded()
    {
        if user.userId == nil
        {
            firebaseUser()
        }
        else
        {
            firebaseLoaded()
        }
    }
    
    private func firebaseUser()
    {
        let fUser:FDatabaseModelUser = FDatabaseModelUser()
        let json:[String:AnyObject] = fUser.modelJson()
        let userId:String = FMain.sharedInstance.database.createChild(FDatabase.FDatabaseReference.User, json:json)
        dbUser?.userId = userId
        DManager.sharedInstance.managerGandalla.saver.save(false)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue())
        { [weak self] in
            
            self?.askNotifications()
        }
    }
    
    private func firebaseLoaded()
    {
    }
    
    //MARK: public
    
    func load()
    {
        DManager.sharedInstance.fetchManagedObjects(
            modelType:DObjectUser.self,
            limit:1)
        { (objects:[DObjectUser]) in
            
            if objects.isEmpty
            {
                self.createUser()
            }
            else
            {
                self.user = objects.first
                self.userLoaded()
            }
        }
    }
}
