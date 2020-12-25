//
//  HttpClientPost.swift
//  CleanApp
//
//  Created by Beatriz Carlos on 16/12/20.
//

import Foundation

// protocolo que testa o metodo post do client, ou seja, cadastra uma conta.
public protocol HttpClientPost {
    func post(to url: URL, with data: Data?)
}
