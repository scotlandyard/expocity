import Foundation

class FDatabaseModelRoom:FDatabaseModel
{
    var name:String
    var access:Access
    let created:TimeInterval
    
    enum Property:String
    {
        case name = "name"
        case created = "created"
        case access = "access"
    }
    
    enum Access:Int
    {
        case invitationOnly = 0
        case freeAccess = 1
    }
    
    init(name:String, access:Access)
    {
        self.name = name
        self.access = access
        created = NSDate().timeIntervalSince1970
        
        super.init()
    }
    
    required init(snapshot:[String:Any])
    {
        let rawAccess:Int = snapshot[Property.access.rawValue] as! Int
        name = snapshot[Property.name.rawValue] as! String
        created = snapshot[Property.created.rawValue] as! TimeInterval
        access = Access(rawValue:rawAccess)!
        
        super.init()
    }
    
    override func modelJson() -> [String:Any]
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.created.rawValue:created,
            Property.access.rawValue:access.rawValue
        ]
        
        return json
    }
}
