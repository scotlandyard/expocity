import UIKit

class CChatDisplayAnnotations:CController
{
    weak var viewAnnotations:VChatDisplayAnnotations!
    weak var controllerChat:CChat!
    
    init(controllerChat:CChat)
    {
        self.controllerChat = controllerChat
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
        let viewAnnotations:VChatDisplayAnnotations = VChatDisplayAnnotations(controller:self)
        self.viewAnnotations = viewAnnotations
        view = viewAnnotations
    }
    
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated)
        viewAnnotations.animateShades()
    }
    
    //MARK: public
    
    func addAnnotation()
    {
        
    }
}