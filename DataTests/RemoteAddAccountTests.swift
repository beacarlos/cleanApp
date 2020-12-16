//
//  DataTests.swift
//  DataTests
//
//  Created by Beatriz Carlos on 16/12/20.
//

import XCTest

// resposabilidade de saber sobre a URL
class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpClient
    
    init(url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        httpClient.post(url: url)
    }
}

// protocolo que defini o que o client http vai fazer.
protocol HttpClient {
    func post(url: URL)
}

// teste que implementa a criação de uma conta nova utilizando API
class RemoteAddAccountTests: XCTestCase {

    func test_() {
        guard let url = URL(string: "http://any-url.com") else { return }
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    // mocking de um retorno de requiisição da API.
    class HttpClientSpy: HttpClient {
        var url: URL?
        func post(url: URL) {
            self.url = url
        }
    }
}
