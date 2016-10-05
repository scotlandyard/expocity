import Foundation

class MRoomsItem
{
    let roomId:String
    
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
        
        
        FMain.sharedInstance.database.listenOnce(
            path: <#T##String#>,
            modelType: <#T##ModelType.Type#>,
            completion: <#T##((ModelType) -> ())##((ModelType) -> ())##(ModelType) -> ()#>)
    }
}
