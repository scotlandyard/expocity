import Foundation
import CoreData

extension NSManagedObject
{
    class func entityName() -> String
    {
        let classType:AnyClass = object_getClass(self)
        
        return NSStringFromClass(classType)
    }
}
