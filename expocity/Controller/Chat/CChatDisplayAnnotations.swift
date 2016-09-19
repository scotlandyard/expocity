import UIKit

class CChatDisplayAnnotations:CController
{
    weak var viewDetail:VChatDisplayDetail!
    let imageRect:CGRect
    
    init(imageRect:CGRect)
    {
        self.imageRect = imageRect
        
        super.init(nibName:nil, bundle:nil)
        modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewDetail:VChatDisplayDetail = VChatDisplayDetail(controller:self)
        self.viewDetail = viewDetail
        view = viewDetail
    }
}