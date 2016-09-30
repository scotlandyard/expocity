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
            self.user.name = NSLocalizedString("DObjectUser_defaultName", comment:"")
            
            DManager.sharedInstance.save()
            
            self.userLoaded()
        }
    }
    
    private func userLoaded()
    {
        if user.userId == nil
        {
            createFirebaseUser()
        }
        else
        {
            loadFirebaseUser()
        }
    }
    
    private func createFirebaseUser()
    {
        let firebaseUser:FdatabaseModelUser = FdatabaseModelUser(name:user.name!)
        let json:[String:Any] = firebaseUser.modelJson()
        let path:String = FDatabase.Parent.User.rawValue
        let userId:String = FMain.sharedInstance.database.createChild(
            path:path,
            json:json)
        
        user.userId = userId
        DManager.sharedInstance.save()
        firebaseLoaded()
    }
    
    private func loadFirebaseUser()
    {
        let userReference:String = FDatabase.Parent.User.rawValue
        let userId:String = user.userId!
        let path:String = String(
            format:"%@/%@",
            userReference,
            userId)
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FdatabaseModelUser.self)
        { (object:FdatabaseModelUser) in
            
            self.firebaseLoaded()
        }
    }
    
    private func firebaseLoaded()
    {
        print("firebase loaded")
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
