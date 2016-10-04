import Foundation

class FDatabaseModelRoom:FDatabaseModel
{
    var name:String
    var access:Access
    var presentation:Presentation
    let owner:String
    let created:TimeInterval
    
    enum Property:String
    {
        case name = "name"
        case owner = "owner"
        case created = "created"
        case access = "access"
        case presentation = "presentation"
    }
    
    enum Access:Int
    {
        case invitationOnly = 0
        case freeJoin = 1
    }
    
    enum Presentation:Int
    {
        case owner = 0
        case everyone = 1
    }
    
    init(name:String, access:Access, owner:String)
    {
        self.name = name
        self.access = access
        self.owner = owner
        presentation = Presentation.owner
        created = NSDate().timeIntervalSince1970
        
        super.init()
    }
    
    required init(snapshot:[String:Any])
    {
        print(snapshot)
        
        let rawAccess:Int = snapshot[Property.access.rawValue] as! Int
        let rawPresentation:Int = snapshot[Property.presentation.rawValue] as! Int
        name = snapshot[Property.name.rawValue] as! String
        owner = snapshot[Property.owner.rawValue] as! String
        created = snapshot[Property.created.rawValue] as! TimeInterval
        access = Access(rawValue:rawAccess)!
        presentation = Presentation(rawValue:rawPresentation)!
        
        super.init()
    }
    
    override func modelJson() -> [String:Any]
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.owner.rawValue:owner,
            Property.created.rawValue:created,
            Property.access.rawValue:access.rawValue,
            Property.presentation.rawValue:presentation.rawValue
        ]
        
        return json
    }
}
