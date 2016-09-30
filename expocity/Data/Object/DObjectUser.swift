import Foundation
import CoreData

@objc(DObjectUser)
class DObjectUser:NSManagedObject
{
    @NSManaged var userId:String?
    @NSManaged var name:String?
    
    override class func entityName() -> String
    {
        return "User"
    }
    
    //MARK: public
    
    func defaultName()
    {
        name = NSLocalizedString("DObjectUser_defaultName", comment:"")
    }
}
