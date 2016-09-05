import UIKit

class VBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private let model:MMenu
    weak var parent:CParent!
    
    init(parent:CParent)
    {
        model = MMenu()
        
        super.init(frame:CGRectZero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.main()
        self.parent = parent
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: col del
    
    
}