//
//  MedlineLoginServiceManager.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation
import PromiseKit

extension MedlineServiceManager {
    
    /// This method is used to hit 'Login API', here parameter, httpmethod would be decided for this API
    /// - Parameters:
    ///   - email: string parameter has valid email
    ///   - password: string parameter has valid password
    ///   - completion: call back, it will return success or failure based on API result
    static func callLoginService(requestObject: MedlineLoginRequest) -> Promise<MedlineLoginResponse> {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        return Promise { seal in
            firstly {
                callGenericService(requestObject.bodyParams(),
                                   requestUrlPath: MedlineService.kLoginPath,
                                   httpMethod: requestObject.requestType())
            }.map(on: backgroundQueue, flags: nil) { (res) in
                try JSONDecoder().decode(MedlineLoginResponse.self, from: res)
            }.done(on: DispatchQueue.main, flags: nil) { (response) in
                seal.fulfill(response)
            }.catch { (error) in
                seal.reject(error)
            }
        }
    }
    
//        executeService(parameter,
//                       requestUrlPath: MedlineService.kLoginPath,
//                       httpMethod: MedlineServiceHttpMethod.post) { (results: Swift.Result<MedlineLoginResponse, Error>) in
//            switch results {
//                case .success(let res):
//                    completion(res, nil)
//                case .failure(let error):
//                    completion(nil, error)
//            }
//        }
   // }
    
    /// Method is used to call Register API
    /// - Parameter requestObject: passing request object to serive api
    /// - Returns: return response/ error in Promise
    static func callNewUserRegisterService(requestObject: MedlineRegisterRequest) -> Promise<MedlineRegisterResponse> {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        return Promise { seal in
            firstly {
                callGenericService(requestObject.bodyParams(),
                                   requestUrlPath: MedlineService.kRegisterPath,
                                   httpMethod: requestObject.requestType())
            }.map(on: backgroundQueue, flags: nil) { (res) in
                try JSONDecoder().decode(MedlineRegisterResponse.self, from: res)
            }.done(on: DispatchQueue.main, flags: nil) { (response) in
                seal.fulfill(response)
            }.catch { (error) in
                seal.reject(error)
            }
        }
    }
    
    /// Service for Reset Password
    /// - Parameter requestObject: Request object for reset password
    /// - Returns: Returning status
    static func callResetPasswordService(requestObject: MedlineResetPasswordRequest) -> Promise<MedlineResetPasswordResponse> {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        return Promise { seal in
            firstly {
                callGenericService(requestObject.bodyParams(), requestUrlPath: MedlineService.kResetPasswordPath, httpMethod: requestObject.requestType())
            }.map(on: backgroundQueue, flags: nil) { (res) in
                try JSONDecoder().decode(MedlineResetPasswordResponse.self, from: res)
            }.done(on: DispatchQueue.main, flags: nil) { (response) in
                print(response)
                seal.fulfill(response)
            }.catch { (error) in
                print(error.localizedDescription)
                seal.reject(error)
            }
        }
    }
    
    /// This method is used to hit 'Forget Password API'
    /// - Parameter requestObject: requests email string
    /// - Returns: returns the response
    static func callForgotPasswordService(requestObject: MedlineForgotPasswordRequest) -> Promise<MedlineForgotPasswordResponse> {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        return Promise { seal in
            firstly {
                callGenericService(requestObject.bodyParams(), requestUrlPath: MedlineService.kForgotPasswordPath, httpMethod: requestObject.requestType())
            }.map(on: backgroundQueue, flags: nil) { (res) in
                try JSONDecoder().decode(MedlineForgotPasswordResponse.self, from: res)
            }.done(on: DispatchQueue.main, flags: nil) { (response) in
                print(response)
                seal.fulfill(response)
            }.catch { (error) in
                print(error.localizedDescription)
                seal.reject(error)
            }
        }
    }
}
