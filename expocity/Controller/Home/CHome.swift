import UIKit

class CHome:CController
{
    weak var viewHome:VHome!
    let model:MHome
    
    init()
    {
        model = MHome()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedSessionLoaded(sender:)),
            name:Notification.Notifications.sessionLoaded.Value,
            object:nil)
        
        MSession.sharedInstance.load()
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewHome.stopLoading()
        }
    }
    
    //MARK: private
    
    private func createFirebaseRoom()
    {
        let firebaseRoom:FDatabaseModelRoom = model.room()
        let json:Any = firebaseRoom.modelJson()
        let path:String = FDatabase.Parent.room.rawValue
        let roomId:String = FMain.sharedInstance.database.createChild(
            path:path,
            json:json)
        
        MSession.sharedInstance.createdRoom(roomId:roomId)
        
        DispatchQueue.main.async
        { [weak self] in
        
            self?.firebaseRoomCreated(roomId:roomId)
        }
    }
    
    private func firebaseRoomCreated(roomId:String)
    {
        viewHome.stopLoading()
        
        let chat:CChat = CChat(roomId:roomId)
        parentController.push(controller:chat)
    }
    
    //MARK: public
    
    func createChat()
    {
        viewHome.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.createFirebaseRoom()
        }
    }
}
