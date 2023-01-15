//
//  NetworkingHelpers.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//


import SwiftUI
//import Combine
import Foundation
import Alamofire

func header() -> HTTPHeaders{
     let headers : HTTPHeaders = [
         "Content-Type": "application/json; charset=utf-8"
     ]
     return headers
}

func baseURL() -> String {
    return "https://jsonplaceholder.typicode.com/"
}

func baseImageURL() -> String {
    return "https://jsonplaceholder.typicode.com/"
}
