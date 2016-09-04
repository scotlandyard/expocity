import UIKit

class CGame:CController
{
    weak var viewGame:VGame!
    weak var timer:NSTimer!
    private let kTimerInterval:NSTimeInterval = 0.01
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewGame.load()
        timer = NSTimer.scheduledTimerWithTimeInterval(kTimerInterval, target:self, selector:#selector(self.timerTick(sender:)), userInfo:nil, repeats:true)
    }
    
    override func loadView()
    {
        let viewGame:VGame = VGame(controller:self)
        self.viewGame = viewGame
        view = viewGame
    }
    
    func timerTick(sender timer:NSTimer)
    {
        viewGame.tick()
    }
}