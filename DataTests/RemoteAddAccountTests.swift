//
//  DataTests.swift
//  DataTests
//
//  Created by Beatriz Carlos on 16/12/20.
//

import XCTest
import Domain

// resposabilidade de saber sobre a URL
class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpClientPost
    
    init(url: URL, httpClient: HttpClientPost) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }
}

// protocolo que testa o metodo post do client, ou seja, cadastra uma conta.
protocol HttpClientPost {
    func post(to url: URL, with data: Data?)
}

//// pesquisa uma conta no client API.
//protocol HttpClientGet {
//    func get(to url: URL, with data: Data?)
//}

// teste que implementa a criação de uma conta nova utilizando API
class RemoteAddAccountTests: XCTestCase {
    // verifica se a URL de requisição está correta e faz o mocking da criação de uma conta.
    func test_add_should_call_httpClient_with_correct_url() {
        guard let url = URL(string: "http://any-url.com") else { return }
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel = AddAccountModel(name: "Beatriz Carlos", email: "whobeatrizcarlos@gmail.com", password: "12345", passwordConfirmation: "12345")
        sut.add(addAccountModel: addAccountModel)
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    // teste que testa se o dado seja igual ao data abstraido pelo AddAccountModel.
    func test_add_should_call_httpClient_with_correct_data() {
        guard let url = URL(string: "http://any-url.com") else { return }
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel = AddAccountModel(name: "Beatriz Carlos", email: "whobeatrizcarlos@gmail.com", password: "12345", passwordConfirmation: "12345")
        sut.add(addAccountModel: addAccountModel)
        
        let data = try? JSONEncoder().encode(addAccountModel)
        
        XCTAssertEqual(httpClientSpy.data, data)
    }
}

extension RemoteAddAccountTests {
    // class mocking de um retorno de requiisição da API.
    class HttpClientSpy: HttpClientPost {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
