import UIKit

class CChatDisplayDetail:CController
{
    weak var viewDetail:VChatDisplayDetail!
    
    init()
    {
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewDetail:VChatDisplayDetail = VChatDisplayDetail(controller:self)
    }
}