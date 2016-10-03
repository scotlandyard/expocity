import Foundation

class FdatabaseModelUser:FDatabaseModel
{
    let name:String
    let created:TimeInterval
    var rooms:[String]
    
    enum Property:String
    {
        case name = "name"
        case created = "created"
        case rooms = "rooms"
    }
    
    init(name:String)
    {
        self.name = name
        created = NSDate().timeIntervalSince1970
        rooms = []
        
        super.init()
    }
    
    required init(snapshot:[String:Any])
    {
        let rawRooms:[String]? = snapshot[Property.rooms.rawValue] as? [String]
        
        name = snapshot[Property.name.rawValue] as! String
        created = snapshot[Property.created.rawValue] as! TimeInterval
        
        if rawRooms == nil
        {
            rooms = []
        }
        else
        {
            rooms = rawRooms!
        }
        
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
