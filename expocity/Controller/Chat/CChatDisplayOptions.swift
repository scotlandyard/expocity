import UIKit

class CChatDisplayOptions:CController
{
    weak var viewOptions:VChatDisplayOptions!
    
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
        let viewOptions:VChatDisplayOptions = VChatDisplayOptions(controller:self)
        self.viewOptions = viewOptions
        view = viewOptions
    }
    
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated)
        viewDetail.animateBlur()
    }
}