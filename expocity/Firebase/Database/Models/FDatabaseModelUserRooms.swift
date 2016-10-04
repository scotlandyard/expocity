import Foundation

class FDatabaseModelUserRooms:FDatabaseModel
{
    let rooms:[String]
    
    init(rooms:[String])
    {
        self.rooms = rooms
        
        super.init()
    }
    
    required init(snapshot:Any?)
    {
        let snapshotArray:[String]? = snapshot as? [String]
        
        if snapshotArray == nil
        {
            rooms = []
        }
        else
        {
            rooms = snapshotArray!
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        return rooms
    }
}
