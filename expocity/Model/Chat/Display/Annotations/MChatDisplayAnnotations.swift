import Foundation

class MChatDisplayAnnotations
{
    var items:[MChatDisplayAnnotationsItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func addAnnotation() -> MChatDisplayAnnotationsItem
    {
        let newItem:MChatDisplayAnnotationsItem = MChatDisplayAnnotationsItem()
        items.append(newItem)
        
        return newItem
    }
    
    func removeAnnotation(_ item:MChatDisplayAnnotationsItem)
    {
        let countItems:Int = items.count
        var indexToRemove:Int = 0
        
        for index:Int in 0 ..< countItems
        {
            let currentAnnotation:MChatDisplayAnnotationsItem = items[index]
            
            if currentAnnotation === item
            {
                indexToRemove = index
                
                break
            }
        }
        
        items.remove(at: indexToRemove)
    }
}
