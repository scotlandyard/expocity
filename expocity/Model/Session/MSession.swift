import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    var user:DObjectUser!
    private(set) var rooms:[String]
    
    init()
    {
        rooms = []
    }
    
    //MARK: private
    
    private func loadUser()
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
        let firebaseUser:FDatabaseModelUser = FDatabaseModelUser(name:user.name!)
        let json:[String:Any] = firebaseUser.modelJson()
        let path:String = FDatabase.Parent.User.rawValue
        let userId:String = FMain.sharedInstance.database.createChild(
            path:path,
            json:json)
        
        rooms = []
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
            modelType:FDatabaseModelUser.self)
        { (object:FDatabaseModelUser) in
            
            self.rooms = object.rooms
            self.firebaseLoaded()
        }
    }
    
    private func firebaseLoaded()
    {
        NotificationCenter.default.post(
            name:Notification.Notifications.sessionLoaded.Value,
            object:nil)
    }
    
    //MARK: public
    
    func load()
    {
        if user == nil
        {
            loadUser()
        }
        else
        {
            userLoaded()
        }
    }
    
    func createdRoom(roomId:String)
    {
        rooms.append(roomId)
        
        let userReference:String = FDatabase.Parent.User.rawValue
        let userId:String = user.userId!
        let roomsReference:String = FDatabaseModelUser.Property.rooms.rawValue
        let path:String = String(
            format:"%@/%@/%@",
            userReference,
            userId,
            roomsReference)
        
        FMain.sharedInstance.database.updateChild(
            path:path,
            json:rooms)
    }
}
