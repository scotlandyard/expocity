import UIKit

class CRooms:CController
{
    weak var viewRooms:VRooms!
    var model:MRooms?
    
    override func loadView()
    {
        let viewRooms:VRooms = VRooms(controller:self)
        self.viewRooms = viewRooms
        view = viewRooms
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
}
