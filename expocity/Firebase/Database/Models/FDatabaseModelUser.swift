import Foundation

class FdatabaseModelUser:FDatabaseModel
{
    let name:String
    let created:TimeInterval
    
    enum Property:String
    {
        case name = "name"
        case created = "created"
    }
    
    init(name:String)
    {
        self.name = name
        created = NSDate().timeIntervalSince1970
    }

    override func modelJson() -> [String:Any]
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.created.rawValue:created
        ]
        
        return json
    }
}
