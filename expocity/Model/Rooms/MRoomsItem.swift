import Foundation

class MRoomsItem
{
    let roomId:String
    var roomName:String?
    weak var cell:VRoomsCell?
    
    init(roomId:String)
    {
        self.roomId = roomId
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadRoom()
        }
    }
    
    //MARK: private
    
    private func loadRoom()
    {
        let roomRerence:String = FDatabase.Parent.room.rawValue
        let path:String = String(
            format:"%@/%@",
            roomRerence,
            roomId)
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelRoom.self)
        { [weak self] (object:FDatabaseModelRoom) in
            
            self?.roomName = object.name
            self?.roomLoaded()
        }
    }
    
    private func roomLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.cell?.label.text = self?.roomName
        }
    }
}
