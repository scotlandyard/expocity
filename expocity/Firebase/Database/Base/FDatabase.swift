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
}
