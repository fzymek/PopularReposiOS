//
//  RepositoryListDataProviderTests.swift
//  PopularReposiOSTests
//
//  Created by Filip on 15/06/2021.
//

import XCTest
@testable import PopularReposiOS

class RepositoryListViewStub: RepositoryListView {
    var renderLoadingCalled = false
    var finishLoadingCalled = false
    var showErrorCalled = false
    var error: Error?
    var renderCalled = false
    
    func renderLoading() {
        renderLoadingCalled = true
    }
    
    func finishLoading() {
        finishLoadingCalled = true
    }
    
    func showError(error: Error) {
        showErrorCalled = true
        self.error = error
    }
    
    func render() {
        renderCalled = true
    }
}

struct HttpServiceStub: HttpService {    
    
    var errorToReturn: Error?
    var dataToReturn: Decodable?
    
    init(dataToReturn: Decodable) {
        self.dataToReturn = dataToReturn
    }
    
    init(errorToReturn: Error) {
        self.errorToReturn = errorToReturn
    }
    
    func get<T>(endpoint: String, parameters: [String : String], completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        
        if let err = self.errorToReturn {
            completion(nil, err)
            return
        }
        
        if let data = self.dataToReturn {
            completion(data as? T, nil)
            return
        }
    }
}

class RepositoryListDataProviderTests: XCTestCase {
    
    var dataProvider: RepositoryListDataProvider?
    var viewStub: RepositoryListViewStub?
    
    override func setUp() {
        viewStub = RepositoryListViewStub()
        dataProvider = RepositoryListDataProvider(view: viewStub!)
    }

    func test_shouldReturnViewModelItem() throws {
        let testData = buildTestData()
        dataProvider!.data = testData
        
        let indexPath = IndexPath(row: 0, section: 0)
        let item = dataProvider?.item(at: indexPath)
        
        XCTAssertNotNil(item)
        XCTAssertEqual("test", item!.name)
    }
    
    func test_shouldCallLoadingAndRenderWhenSucceded() throws {
        let serviceStub = HttpServiceStub(dataToReturn: buildTestData())
        dataProvider!.restService = serviceStub
        
        dataProvider!.startLoading()
        
        XCTAssertTrue(viewStub!.renderLoadingCalled)
        XCTAssertTrue(viewStub!.finishLoadingCalled)
        XCTAssertTrue(viewStub!.renderCalled)
    }


    private func buildTestData() -> RepositorySearchResponse {
        let testItems = [
            Repository(id: 0, name: "test", owner: Owner(id: 1, login: "test login", avatarUrl: "http://test.url"), isFork: false, language: nil, starCount: 1)
        ]
        return RepositorySearchResponse(totalCount: 1, items: testItems)
    }

}
