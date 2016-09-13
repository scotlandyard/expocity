import Foundation

class MChatMenu
{
    var items:[MChatMenuItem]
    var status:MChatMenuStatus!
    
    init()
    {
        items = []
        menuStandby()
    }
    
    //MARK: public
    
    func menuTyping()
    {
        status = MChatMenuStatusTyping()
        items = status.items()
    }
    
    func menuStandby()
    {
        status = MChatMenuStatusStandby()
        items = status.items()
    }
}