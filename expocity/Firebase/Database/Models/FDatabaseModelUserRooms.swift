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
        let rawName:String? = snapshot[Property.name.rawValue] as? String
        let rawCreated:TimeInterval? = snapshot[Property.created.rawValue] as? TimeInterval
        let rawRooms:[String]? = snapshot[Property.rooms.rawValue] as? [String]
        
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
