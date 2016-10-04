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
        rooms = []
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [:
        ]
        
        return json
    }
}
