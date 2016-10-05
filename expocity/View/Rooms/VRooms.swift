import UIKit

class VRooms:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CRooms!
    weak var spinner:VMainLoader?
    weak var collectionView:UICollectionView!
    
    convenience init(controller:CRooms)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        clipsToBounds = true
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        self.spinner = spinner
        
        addSubview(spinner)
    }
    
    //MARK: public
    
    func roomsReload()
    {
        spinner?.removeFromSuperview()
    }
    
    //MARK: collection delegate
    
}
