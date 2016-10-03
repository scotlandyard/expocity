import UIKit

class CHome:CController
{
    weak var viewHome:VHome!
    let model:MHome
    
    init()
    {
        model = MHome()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedSessionLoaded(sender:)),
            name:Notification.Notifications.sessionLoaded.Value,
            object:nil)
        
        MSession.sharedInstance.load()
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewHome.sessionLoaded()
        }
    }
    
    //MARK: public
    
    func createChat()
    {
        let modelChat:MChat = model.chat()
        let chat:CChat = CChat(model:modelChat)
        parentController.push(controller:chat)
    }
}
