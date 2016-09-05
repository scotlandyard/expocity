import UIKit

class VBar:UIView
{
    weak var parent:CParent!
    
    init(parent:CParent)
    {
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
}