//
//  DataTests.swift
//  DataTests
//
//  Created by Beatriz Carlos on 16/12/20.
//

import XCTest
import Domain
import Data

// teste que implementa a criação de uma conta nova utilizando API
class RemoteAddAccountTests: XCTestCase {
    // verifica se a URL de requisição está correta e faz o mocking da criação de uma conta.
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAccountModel()) { _ in}
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    // teste que testa se o dado seja igual ao data abstraido pelo AddAccountModel.
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in}
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    // tratamento de erros do callback no func add AddAccount
    func test_add_should_complete_with_error_if_client_fail() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAccountModel()) { error in
            XCTAssertEqual(error, .unexpected)
            exp.fulfill()
        }
        httpClientSpy.completeError(.noConnectivity)
        wait(for: [exp], timeout: 1)
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
        var urls = [URL]()
        var data: Data?
        var completion: ((HttpError) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping(HttpError) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeError(_ error: HttpError)  {
            completion?(error)
        }
    }
}

