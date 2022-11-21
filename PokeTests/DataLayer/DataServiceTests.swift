//
//  DataServiceTests.swift
//  PokeTests
//
//  Created by Javier Calatrava on 18/11/22.
//
@testable import Poke
import XCTest

final class DataServiceTests: XCTestCase {

    var sut: DataServiceProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DataService()
    }

    func testFetch() throws {
        let exp = expectation(description: "Test finished")
        
        sut.fetch { result in
            switch result {
            case .success(let resultContainer):
                XCTAssertEqual(resultContainer.count, 1154)
                XCTAssertEqual(resultContainer.results[0].name, "bulbasaur")
            case .failure:
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testFetchAsync() async {
        let exp = expectation(description: "Test finished")
        let result = await sut.fetch()
        switch result {
        case .success(let resultContainer):
            XCTAssertEqual(resultContainer.count, 1154)
            XCTAssertEqual(resultContainer.results[0].name, "bulbasaur")
        case .failure:
            XCTFail()
        }
        exp.fulfill()
        await waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testFetchWhenLink() throws {
        let exp = expectation(description: "Test finished")
        
        sut.fetch(link: "https://pokeapi.co/api/v2/pokemon/2/") { result in
            switch result {
            case .success(let resultContainer):
                XCTAssertEqual(resultContainer.id, 2)
                XCTAssertEqual(resultContainer.name, "ivysaur")
                XCTAssertEqual(resultContainer.sprites.frontDefault,
                               "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")
            case .failure:
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 200.0, handler: nil)
    }
    
    func testFetchWhenLinkAsync() async {
        let exp = expectation(description: "Test finished")
        let result = await sut.fetch(link: "https://pokeapi.co/api/v2/pokemon/2/")
        switch result {
        case .success(let resultContainer):
            XCTAssertEqual(resultContainer.id, 2)
            XCTAssertEqual(resultContainer.name, "ivysaur")
            XCTAssertEqual(resultContainer.sprites.frontDefault,
                           "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")
        case .failure:
            XCTFail()
        }
        exp.fulfill()
        await waitForExpectations(timeout: 200.0, handler: nil)
    }
}
