import UIKit

class CChatDisplayOptions:CController
{
    weak var viewOptions:VChatDisplayOptions!
    let model:MChatDisplayOptions
    
    init(modelChat:MChat)
    {
        model = MChatDisplayOptions(modelChat:modelChat)
        
        super.init(nibName:nil, bundle:nil)
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
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
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewOptions.animateBlur()
    }
}
