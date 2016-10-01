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
}
