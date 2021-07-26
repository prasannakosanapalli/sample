//
//  TempPromiseKit.swift
//  Medline-DigitalSkinHealth
//
//  Created by Hariharan A on 17/02/21.
//

import Foundation

import PromiseKit

// MARK: - UserResponseElement
struct UserResponseElement: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}

typealias UserResponse = [UserResponseElement]

extension MedlineServiceManager {
    static func promiseOne() -> Promise<UserResponse> {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        return Promise { seal in
            firstly {
                callGenericFakeService(nil, httpMethod: MedlineServiceHttpMethod.get)
            }.map(on: backgroundQueue, flags: nil) { (res) in
                try JSONDecoder().decode(UserResponse.self, from: res)
            }.done(on: DispatchQueue.main, flags: nil) { (response) in
                print(response)
                seal.fulfill(response)
            }.catch { (error) in
                print(error.localizedDescription)
                seal.reject(error)
            }
        }
        
    }
    
    static func promiseTwo() -> Promise<UserResponse> {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        return Promise { seal in
            firstly {
                callGenericFakeService(nil, httpMethod: MedlineServiceHttpMethod.get)
            }.map(on: backgroundQueue, flags: nil) { (res) in
                try JSONDecoder().decode(UserResponse.self, from: res)
            }.done(on: DispatchQueue.main, flags: nil) { (response) in
                print(response)
                seal.fulfill(response)
            }.catch { (error) in
                print(error.localizedDescription)
                seal.reject(error)
            }
        }
    }
    
    static func parallelcallFakeService() {
        firstly {
            when(fulfilled: promiseOne(), promiseTwo())
        }.done(on: DispatchQueue.main, flags: nil) { (UserResponse1, UserResponse2) in
            print(UserResponse1, UserResponse2)
        }.catch { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func singleCallFakeService() {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        
        firstly {
            callGenericFakeService(nil, httpMethod: MedlineServiceHttpMethod.get)
        }.map(on: backgroundQueue, flags: nil) { (res) in
            try JSONDecoder().decode(UserResponse.self, from: res)
        }.done(on: DispatchQueue.main, flags: nil) { (response) in
            print(response)
        }.catch { (error) in
            print(error.localizedDescription)
        }
    }
}
