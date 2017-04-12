import XCTest
@testable import MastodonKit

class AccountsTests: XCTestCase {
    static var allTests = [
        ("testAccount", testAccount),
        ("testCurrentUser", testCurrentUser),
        ("testFollowers", testFollowers),
        ("testFollowing", testFollowing),
        ("testStatuses", testStatuses),
        ("testFollow", testFollow),
        ("testUnfollow", testUnfollow),
        ("testBlock", testBlock),
        ("testUnblock", testUnblock),
        ("testMute", testMute),
        ("testUnmute", testUnmute),
        ("testSearchWithoutLimit", testSearchWithoutLimit),
        ("testSearchWithLimit", testSearchWithLimit)
    ]

    func testAccount() {
        let resource = Accounts.account(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testCurrentUser() {
        let resource = Accounts.currentUser()

        XCTAssertEqual(resource.path, "/api/v1/accounts/verify_credentials")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testFollowers() {
        let resource = Accounts.followers(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/followers")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testFollowing() {
        let resource = Accounts.following(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/following")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testStatuses() {
        let resource = Accounts.statuses(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/statuses")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testFollow() {
        let resource = Accounts.follow(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/follow")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testUnfollow() {
        let resource = Accounts.unfollow(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/unfollow")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testBlock() {
        let resource = Accounts.block(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/block")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testUnblock() {
        let resource = Accounts.unblock(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/unblock")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testMute() {
        let resource = Accounts.mute(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/mute")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testUnmute() {
        let resource = Accounts.unmute(id: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/42/unmute")
        XCTAssertNil(resource.parameters)
        XCTAssertNotNil(resource.parse)
    }

    func testSearchWithoutLimit() {
        let resource = Accounts.search(query: "Ash")

        XCTAssertEqual(resource.path, "/api/v1/accounts/search")
        XCTAssertEqual(resource.parameters?.first?.name, "q")
        XCTAssertEqual(resource.parameters?.first?.value, "Ash")
        XCTAssertEqual(resource.parameters?.last?.name, "limit")
        XCTAssertEqual(resource.parameters?.last?.value, "40")
        XCTAssertNotNil(resource.parse)
    }

    func testSearchWithLimit() {
        let resource = Accounts.search(query: "Ash", limit: 42)

        XCTAssertEqual(resource.path, "/api/v1/accounts/search")
        XCTAssertEqual(resource.parameters?.first?.name, "q")
        XCTAssertEqual(resource.parameters?.first?.value, "Ash")
        XCTAssertEqual(resource.parameters?.last?.name, "limit")
        XCTAssertEqual(resource.parameters?.last?.value, "42")
        XCTAssertNotNil(resource.parse)
    }
}