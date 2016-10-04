import Foundation
import FirebaseDatabase

class FDatabase
{
    enum Parent:String
    {
        case user = "user"
        case room = "room"
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
    
    func updateChild(path:String, json:Any)
    {
        let childReference:FIRDatabaseReference = reference.child(path)
        childReference.setValue(json)
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
