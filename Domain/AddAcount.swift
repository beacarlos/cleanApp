//
//  AddAcount.swift
//  Domain
//
//  Created by Beatriz Carlos on 16/12/20.
//

// caso de uso do domain
import Foundation

protocol AddAccount {
    // metodo que adiciona uma conta via api
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}


