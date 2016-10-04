import UIKit
import FirebaseDatabase

class CRooms:CController
{
    weak var viewRooms:VRooms!
    var model:MRooms?
    var listenId:UInt?
    
    override func loadView()
    {
        let viewRooms:VRooms = VRooms(controller:self)
        self.viewRooms = viewRooms
        view = viewRooms
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
        listenId = FMain.sharedInstance.database.listen(
            eventType:FIRDataEventType.value,
            path: <#T##String#>,
            modelType: <#T##ModelType.Type#>, completion: <#T##((ModelType) -> ())##((ModelType) -> ())##(ModelType) -> ()#>)*/
    }
}
