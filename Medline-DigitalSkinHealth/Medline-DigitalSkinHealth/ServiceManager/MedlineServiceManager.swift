//
//  MedlineServiceManager.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class MedlineServiceManager {
    
    /// Method is used to execute serive api with PromiseKit support, will return response which is Generic <T>
    /// - Parameters:
    ///   - requestObject: Pass  request object in dictionary format
    ///   - requestUrlPath: url path path for service request, base url is configured in this method
    ///   - httpMethod: Serive HTTP method like 'GET' and  'POST'. this variable is already predefined in 'MedlineServiceHttpMethod'
    /// - Returns: will return response / error in Promise object
    static func callGenericService<T>(_ requestObject: [String: Any]?,
                                      requestUrlPath: String,
                                      httpMethod: MedlineServiceHttpMethod) -> Promise<T> where T: Any {
        return Promise { seal in
            guard isConnectedToInternet() else {
                seal.reject(GenericError.NoNetworkConnection)
                return
            }
            
            guard (requestObject != nil && httpMethod == MedlineServiceHttpMethod.post) || httpMethod == MedlineServiceHttpMethod.get else {
                seal.reject(GenericError.BadAPIRequest)
                return
            }
                
            let headers: HTTPHeaders = [
                "Content-Type": MedlineServiceConstant.accept,
                "Ocp-Apim-Subscription-Key": MedlineService.kSubscriptionKey
            ]
            let url: Alamofire.URLConvertible = URL(string: MedlineService.kBaseURL + requestUrlPath)!
            
            AF.request(url,
                       method: HTTPMethod(rawValue: httpMethod.rawValue),
                       parameters: requestObject,
                       encoding: JSONEncoding.default,
                       headers: headers)
                .responseData(completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        seal.fulfill(data as! T)
                    case .failure(let error):
                        seal.reject(error)
                    }
                })
        }
    }
    
//    static func uploadMultipartImage(param: [String: Any],
//                            arrImage: [UIImage],
//                            imageKey: String,
//                            URlName: String,
//                            withblock: @escaping (_ response: AnyObject?) -> Void) {
//
//        let headers: HTTPHeaders
//        headers = ["Content-type": "multipart/form-data",
//                   "Content-Disposition" : "form-data"]
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//
//            for (key, value) in param {
//                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
//            }
//
//            for img in arrImage {
//                guard let imgData = img.jpegData(compressionQuality: 1) else { return }
//                multipartFormData.append(imgData,
//                                         withName: imageKey,
//                                         fileName: String(describing: retrieveCurrentMillis()) + ".jpeg",
//                                         mimeType: "image/jpeg")
//            }
//
//        },to: URL.init(string: URlName)!, usingThreshold: UInt64.init(),
//        method: .post,
//        headers: headers).response { response in
//
//            if ((response.error != nil)) {
//                do {
//                    if let jsonData = response.data{
//                        let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
//                        print(parsedData)
//                    }
//                } catch {
//                    print("error message")
//                }
//            } else {
//                print(response.error!.localizedDescription)
//            }
//        }
//    }
}
