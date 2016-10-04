import XCTest
@testable import expocity

class TMHome:XCTestCase
{
    private let kRoomName:String = "MyWeirdRoomName with space"
    
    var mHome:MHome?
    
    override func setUp()
    {
        super.setUp()
        
        mHome = MHome()
    }
    
    override func tearDown()
    {
        mHome = nil
        
        super.tearDown()
    }
    
    //MARK: -
    
    func testRoomOwner()
    {
        let firebaseRoom:FDatabaseModelRoom = mHome!.room()
        let userId:String = firebaseRoom.owner
        XCTAssertFalse(userId.isEmpty, "Room has no owner")
    }
    
    func testEmptyRoomName()
    {
        let firebaseRoom:FDatabaseModelRoom = mHome!.room()
        let roomName:String = firebaseRoom.name
        XCTAssertFalse(roomName.isEmpty, "Room name is empty")
    }
    
    func testRoomName()
    {
        mHome!.itemTitle.title = kRoomName
        let firebaseRoom:FDatabaseModelRoom = mHome!.room()
        let roomName:String = firebaseRoom.name
        XCTAssertTrue(roomName == kRoomName, "Room name mismatch")
    }
}
