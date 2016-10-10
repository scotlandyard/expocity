import UIKit
import FirebaseDatabase

class CRooms:CController
{
    weak var viewRooms:VRooms!
    var model:MRooms?
    var listenPath:String?
    var listenHandler:UInt?
    
    override func loadView()
    {
        let viewRooms:VRooms = VRooms(controller:self)
        self.viewRooms = viewRooms
        view = viewRooms
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.listenRooms()
        }
    }
    
    //MARK: private
    
    private func listenRooms()
    {
        let userReference:String = FDatabase.Parent.user.rawValue
        let userId:String = MSession.sharedInstance.user!.userId!
        let roomsReference:String = FDatabaseModelUser.Property.rooms.rawValue
        let path:String = String(
            format:"%@/%@/%@",
            userReference,
            userId,
            roomsReference)
        
        listenHandler = FMain.sharedInstance.database.listen(
            eventType:FIRDataEventType.value,
            path:path,
            modelType:FDatabaseModelUserRooms.self)
        { [weak self] (object:FDatabaseModelUserRooms) in
            
            self?.model = MRooms(rooms:object)
            self?.roomsLoaded()
        }
    }
    
    private func roomsLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewRooms.roomsReload()
        }
    }
    
    //MARK: public
    
    func showRoom(room:MRoomsItem)
    {
        let roomId:String = room.roomId
        let chatController:CChat = CChat(roomId:roomId)
        parentController.push(controller:chatController)
    }
    
    func createRoom()
    {
        let indexHome:Int = parentController.viewParent.bar.model.itemHome.index
        parentController.viewParent.bar.synthSelect(index:indexHome)
    }
}
