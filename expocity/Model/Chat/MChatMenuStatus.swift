import Foundation

class MChatMenuStatus
{
    let items:[MChatMenuItem]
    
    init(items:[MChatMenuItem])
    {
        self.items = items
    }
    
    //MARK: public
    
    func shouldChangeStatus(currentText:String) -> MChatMenuStatus?
    {
        fatalError()
    }
}