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
        httpClient.post(to: url, with: addAccountModel.toData())
    }
}

// protocolo que testa o metodo post do client, ou seja, cadastra uma conta.
protocol HttpClientPost {
    func post(to url: URL, with data: Data?)
}

// teste que implementa a criação de uma conta nova utilizando API
class RemoteAddAccountTests: XCTestCase {
    // verifica se a URL de requisição está correta e faz o mocking da criação de uma conta.
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAccountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    // teste que testa se o dado seja igual ao data abstraido pelo AddAccountModel.
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut: sut, httpClientSpy: httpClientSpy)
    }
    
    func makeAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "Beatriz Carlos", email: "whobeatrizcarlos@gmail.com", password: "12345", passwordConfirmation: "12345")
    }
    
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
