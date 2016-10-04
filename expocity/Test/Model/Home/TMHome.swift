import XCTest
@testable import expocity

class TMHome:XCTestCase
{
    private var mHome:MHome?
    private let kRoomName:String = "MyWeirdRoomName with space"
    
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
        
        XCTAssertEqual(roomName, kRoomName, "Room name mismatch")
    }
    
    func testAccessInvitationOnly()
    {
        let accessInvitationOnly:FDatabaseModelRoom.Access = FDatabaseModelRoom.Access.invitationOnly
        mHome!.itemAccess.access = accessInvitationOnly
        let firebaseRoom:FDatabaseModelRoom = mHome!.room()
        let roomAccess:FDatabaseModelRoom.Access = firebaseRoom.access
        
        XCTAssertEqual(roomAccess, accessInvitationOnly, "Room access mismatch")
    }
    
    func testAccessFreeJoin()
    {
        let accessFreeJoin:FDatabaseModelRoom.Access = FDatabaseModelRoom.Access.freeJoin
        mHome!.itemAccess.access = accessFreeJoin
        let firebaseRoom:FDatabaseModelRoom = mHome!.room()
        let roomAccess:FDatabaseModelRoom.Access = firebaseRoom.access
        
        XCTAssertEqual(roomAccess, accessFreeJoin, "Room access mismatch")
    }
}
