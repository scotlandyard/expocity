import Foundation

class FDatabaseModelUserRooms:FDatabaseModel
{
    let rooms:[String]
    
    init(rooms:[String])
    {
        self.rooms = rooms
        
        super.init()
    }
    
    required init(snapshot:[String:Any])
    {
        rooms = []
        
        super.init()
    }
    
    override func modelJson() -> [String:Any]
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.created.rawValue:created,
            Property.rooms.rawValue:rooms
        ]
        
        return json
    }
}
