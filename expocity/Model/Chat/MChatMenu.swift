import Foundation

class MChatMenu
{
    var status:MChatMenuStatus
    
    init()
    {
        status = MChatMenuStatusStandby()
    }
    
    //MARK: public
    
    func checkStatusAndReload(currentText:String) -> Bool
    {
        let reload:Bool
        let nextStatus:MChatMenuStatus? = status.shouldChangeStatus(currentText)
        
        if nextStatus == nil
        {
            reload = false
        }
        else
        {
            reload = true
            status = nextStatus!
        }
        
        return reload
    }
}