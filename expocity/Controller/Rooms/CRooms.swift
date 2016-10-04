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
        
        let path:String = ""
        
        listenId = FMain.sharedInstance.database.listen(
            eventType:FIRDataEventType.value,
            path:path,
            modelType:FDatabaseModelUserRooms.self)
        { [weak self] (object:FDatabaseModelUserRooms) in
            
        }
    }
}
