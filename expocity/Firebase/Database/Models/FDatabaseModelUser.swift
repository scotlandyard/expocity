import Foundation

class FdatabaseModelUser:FDatabaseModel
{
    let name:String
    let created:TimeInterval
    let status:Status
    
    enum Property:String
    {
        case name = "name"
        case created = "created"
        case status = "status"
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
    }

    override func modelJson() -> [String:Any]
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.created.rawValue:created,
            Property.status.rawValue:status
        ]
        
        return json
    }
}
