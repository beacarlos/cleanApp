//
//  AddAcount.swift
//  Domain
//
//  Created by Beatriz Carlos on 16/12/20.
//

// caso de uso do domain
import Foundation

public protocol AddAccount {
    // metodo que adiciona uma conta via api
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

public struct AddAccountModel {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
}


