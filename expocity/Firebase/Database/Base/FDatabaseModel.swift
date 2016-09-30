import Foundation

class FDatabaseModel
{
    init()
    {
    }
    
    required init(snapshot:[String:Any])
    {
        fatalError()
    }
    
    //MARK: public
    
    func modelJson() -> [String:Any]
    {
        fatalError()
    }
}
