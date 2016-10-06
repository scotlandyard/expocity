import Foundation

class FDatabaseModelMessage:FDatabaseModel
{/*
    let name:String
    var access:Access
    var presentation:Presentation
    let owner:String
    let created:TimeInterval
    private let kEmptyString:String = ""
    private let kNonCreated:TimeInterval = 0
    
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
        case unknown = 999
    }
    
    enum Presentation:Int
    {
        case owner = 0
        case everyone = 1
        case unknown = 999
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
    
    required init(snapshot:Any?)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        let rawIntAccess:Int? = snapshotDict?[Property.access.rawValue] as? Int
        let rawIntPresentation:Int? = snapshotDict?[Property.presentation.rawValue] as? Int
        let rawName:String? = snapshotDict?[Property.name.rawValue] as? String
        let rawOwner:String? = snapshotDict?[Property.owner.rawValue] as? String
        let rawCreated:TimeInterval? = snapshotDict?[Property.created.rawValue] as? TimeInterval
        
        if rawIntAccess == nil
        {
            access = Access.unknown
        }
        else
        {
            let rawAccess:Access? = Access(rawValue:rawIntAccess!)
            
            if rawAccess == nil
            {
                access = Access.unknown
            }
            else
            {
                access = rawAccess!
            }
        }
        
        if rawIntPresentation == nil
        {
            presentation = Presentation.unknown
        }
        else
        {
            let rawPresentation:Presentation? = Presentation(rawValue:rawIntPresentation!)
            
            if rawPresentation == nil
            {
                presentation = Presentation.unknown
            }
            else
            {
                presentation = rawPresentation!
            }
        }
        
        if rawName == nil
        {
            name = kEmptyString
        }
        else
        {
            name = rawName!
        }
        
        if rawOwner == nil
        {
            owner = kEmptyString
        }
        else
        {
            owner = rawOwner!
        }
        
        if rawCreated == nil
        {
            created = kNonCreated
        }
        else
        {
            created = rawCreated!
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.name.rawValue:name,
            Property.owner.rawValue:owner,
            Property.created.rawValue:created,
            Property.access.rawValue:access.rawValue,
            Property.presentation.rawValue:presentation.rawValue
        ]
        
        return json
    }*/
}
