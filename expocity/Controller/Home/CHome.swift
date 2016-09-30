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
        
        MSession.sharedInstance.load()
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
}
