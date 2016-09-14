import UIKit

class CChatDisplayDetail:CController
{
    weak var viewDetail:VChatDisplayDetail!
    
    init()
    {
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