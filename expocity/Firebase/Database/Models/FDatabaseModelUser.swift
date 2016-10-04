import Foundation

class FDatabaseModelUser:FDatabaseModel
{
    let name:String
    let created:TimeInterval
    let rooms:FDatabaseModelUserRooms
    private let kEmptyString:String = ""
    private let kNonCreated:TimeInterval = 0
    
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
    
    required init(snapshot:Any?)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        let rawName:String? = snapshotDict?[Property.name.rawValue] as? String
        let rawCreated:TimeInterval? = snapshotDict?[Property.created.rawValue] as? TimeInterval
        let rawRooms:[String]? = snapshotDict?[Property.rooms.rawValue] as? [String]
        
        if rawName == nil
        {
            name = kEmptyString
        }
        else
        {
            name = rawName!
        }
        
        if rawCreated == nil
        {
            created = kNonCreated
        }
        else
        {
            created = rawCreated!
        }
        
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

    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.created.rawValue:created,
            Property.rooms.rawValue:rooms
        ]
        
        return json
    }
}
