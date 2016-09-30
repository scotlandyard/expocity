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
