//
//  RemoteAddAccount.swift
//  CleanApp
//
//  Created by Beatriz Carlos on 16/12/20.
//

import Foundation
import Domain

// resposabilidade de saber sobre a URL
public final class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpClientPost
    
    public init(url: URL, httpClient: HttpClientPost) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (DomainError)-> Void) {
        httpClient.post(to: url, with: addAccountModel.toData()) { error in
            completion(.unexpected)
        }
    }
}
