//
//  PostTestAppTests.swift
//  PostTestAppTests
//
//  Created by CrownSDS on 10/01/2023.
//

import XCTest
@testable import PostTestApp

final class PostTestAppTests: XCTestCase {
    private var postsViewModel:PostsViewModel!
    private var commentsViewModel: PostCommentsViewModel!
    private var post:Post!
    
    override func setUp() {
        post = Post(id: 1, title: "dfdfdf", body: "eerreee")
        postsViewModel = PostsViewModel()
        commentsViewModel = .init(post: post) 
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        postsViewModel = nil
        commentsViewModel = nil
        post = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testLoadAllPostsServiceSuccessIsTrueOrNot()
    {
        // Create an expectation
        let expectation = self.expectation(description: "LoadAllPosts")
        self.postsViewModel.loadAllPosts(dataResult: { (success, data) in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(postsViewModel.success)
    }
    func testLoadAllPostsServiceErrorIsNilOrNot()
    {
        // Create an expectation
        let expectation = self.expectation(description: "LoadAllPosts")
        postsViewModel.loadAllPosts(dataResult: { (success, data) in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(postsViewModel.error)
    }
    func test_posts_not_empty()
    {
        let expectation = self.expectation(description: "LoadAllPosts")
        postsViewModel.loadAllPosts(dataResult: { (success, data) in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(postsViewModel.posts.count)
    }
    
    func testGetPostCommentsServiceSuccessIsTrueOrNot()
    {
        // Create an expectation
        let expectation = self.expectation(description: "GetPostComments")
        commentsViewModel.getPostComments(withID: 2, dataResult: { (success, data) in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(commentsViewModel.success)
        
    }
    func testGetPostCommentsServiceErrorIsNilOrNot()
    {
        // Create an expectation
        let expectation = self.expectation(description: "GetPostComments")
        commentsViewModel.getPostComments(withID: 11, dataResult: { (success, data) in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(postsViewModel.error)
    }
    func test_comments_not_empty()
    {
        // Create an expectation
        let expectation = self.expectation(description: "GetPostComments")
        commentsViewModel.getPostComments(withID: 2, dataResult: { (success, data) in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(commentsViewModel.comments.count)
    }
    
    //    func testExample() throws {
    //
    //        XCTAssertEqual(sut.Mynumber(), 100)
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //        // Any test you write for XCTest can be annotated as throws and async.
    //        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    //        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    //
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
}
