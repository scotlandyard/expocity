import Foundation
import FirebaseDatabase

class FDatabase
{
    enum Parent:String
    {
        case User = "user"
    }
    
    private let reference:FIRDatabaseReference
    
    init()
    {
        reference = FIRDatabase.database().reference()
    }
    
    //MARK: public
    
    func createChild(path:String, json:[String:Any]) -> String
    {
        let childReference:FIRDatabaseReference = reference.child(path).childByAutoId()
        let childId:String = childReference.key
        childReference.setValue(json)
        
        return childId
    }
}
