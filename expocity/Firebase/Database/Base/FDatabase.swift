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
    
    func listenOnce<ModelType:FDatabaseModel>(path:String, modelType:ModelType.Type, completion:@escaping((ModelType) -> ()))
    {
        let pathReference:FIRDatabaseReference = reference.child(path)
        pathReference.observeSingleEvent(of:FIRDataEventType.value)
        { (snapshot:FIRDataSnapshot) in
            
            let json:[String:Any] = snapshot.value as! [String:Any]
            let model:ModelType = ModelType(snapshot:json)
            
            completion(model)
        }
    }
}
