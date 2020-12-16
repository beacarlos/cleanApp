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
    private let httpClient: HttpClientPost
    
    init(url: URL, httpClient: HttpClientPost) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        httpClient.post(url: url)
    }
}

// protocolo que testa o metodo post do client, ou seja, cadastra uma conta.
protocol HttpClientPost {
    func post(url: URL)
}

// pesquisa uma conta no client API.
protocol HttpClientGet {
    func get(url: URL)
}

// teste que implementa a criação de uma conta nova utilizando API
class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        guard let url = URL(string: "http://any-url.com") else { return }
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    // mocking de um retorno de requiisição da API.
    class HttpClientSpy: HttpClientPost {
        var url: URL?
        func post(url: URL) {
            self.url = url
        }
    }
}
