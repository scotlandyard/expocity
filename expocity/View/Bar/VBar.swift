import UIKit

class VBar:UIView
{
    weak var parent:CParent!
    
    init(parent:CParent)
    {
        super.init(frame:CGRectZero)
        self.parent = parent
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}