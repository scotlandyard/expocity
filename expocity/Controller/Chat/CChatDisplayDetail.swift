import UIKit

class CChatDisplayDetail:CController
{
    weak var viewDetail:VChatDisplayDetail!
    weak var displayOption:MChatDisplayOptionsItem!
    let image:UIImage?
    let imageRect:CGRect
    
    init(image:UIImage?, imageRect:CGRect, displayOption:MChatDisplayOptionsItem)
    {
        self.image = image
        self.imageRect = imageRect
        self.displayOption = displayOption
        
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
    
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated)
        viewDetail.animateImage()
    }
}