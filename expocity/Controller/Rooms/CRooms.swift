import UIKit

class CRooms:CController
{
    weak var viewRooms:VRooms!
    
    override func loadView()
    {
        let viewRooms:VRooms = VRooms(controller:self)
        self.viewRooms = viewRooms
        view = viewRooms
    }
}