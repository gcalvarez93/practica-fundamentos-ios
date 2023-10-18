//
//  DragonBallSuperHeroesTests.swift
//  DragonBallSuperHeroesTests
//
//  Created by Gabriel Castro on 28/9/23.
//

import XCTest
@testable import DragonBallSuperHeroes

final class DragonBallSuperHeroesTests: XCTestCase {
    private var sut: NetworkModel!
    
    override class func setUp() {
        super.setUp()
    }
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrl.self]
        let session = URLSession(configuration: configuration)
        sut = NetworkModel(session: session)
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    //Testeamos el login
    func testLogin() {
        let expectedToken = "Some Token"
        let someUser = "SomeUser"
        let somePassword = "SomePassword"
        
        MockUrl.requestHandler = { request in
            let loginString = String(format: "%@:%@", someUser, somePassword)
            
            let loginData = loginString.data(using: .utf8)!
            let base64LogingString = loginData.base64EncodedString()
            
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField: "Authorization"),
                "Basic \(base64LogingString)"
            )
            
            let data = try XCTUnwrap(expectedToken.data(using: .utf8))
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: URL(string: "https://dragonball.keepcoding.education")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"]
                )
            )
            
            return (response, data)
        }
        
        // Código asíncrono
        let expect = expectation(description: "Login succes")
        
        sut.login(
            user: someUser,
            password: somePassword
        ) { result in
            guard case let .success(token) = result else {
                XCTFail("X - Expected success but recived \(result)")
                return
            }
            
            XCTAssertEqual(token, expectedToken)
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }
}

final class MockUrl: URLProtocol {
    static var error: NetworkModel.NetworkError?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockUrl.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = MockUrl.requestHandler else {
            assertionFailure("X - Recived unexpected request with no handler")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        
    }
}
