import Foundation

class FdatabaseModelUser:FDatabaseModel
{
    let name:String
    let created:TimeInterval
    let status:Status
    var rooms:[String]
    
    enum Property:String
    {
        case name = "name"
        case created = "created"
        case status = "status"
        case rooms = "rooms"
    }
    
    enum Status:Int
    {
        case active = 0
        case banned = 1
    }
    
    init(name:String)
    {
        self.name = name
        created = NSDate().timeIntervalSince1970
        status = Status.active
        rooms = []
    }

    override func modelJson() -> [String:Any]
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.created.rawValue:created,
            Property.status.rawValue:status,
            Property.rooms.rawValue:rooms
        ]
        
        return json
    }
}
