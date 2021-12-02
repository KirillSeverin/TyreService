//
//  AuthManager.swift
//  TyreService
//
//  Created by Kirill Severin on 20.10.21.
//

import Foundation
import Alamofire

class AuthManager {
    
    func createPartner(parter: Partner, completion: @escaping ((RequestStatus, String?) -> Void)) {
        
        let url = Constants.apiRegistration
        
        AF.request(url, method: .post, parameters: parter, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: ResponseStatus.self) { response in
            guard let data = response.value else {
                print(response)
                completion(.error, nil)
                return
            }
            if data.success {
                completion(.ok, nil)
            } else {
                completion(.error, data.errors?[0])
            }
            
        }
    }
    
    func authorizationPartner(email: String, password: String, completion: @escaping (RequestStatus, String?) -> Void) {
        
        let url = Constants.apiAuthorization
        let headers: HTTPHeaders = [
            .authorization(username: email, password: password),
            .accept("application/json")
        ]
        
        AF.request(url, method: .get, headers: headers).response { (response) in
            switch response.response?.statusCode ?? 500 {
            case 200..<299:
                guard let data = response.data, let token = String(data: data, encoding: .utf8) else {
                    completion(.error, nil)
                    return
                }
                completion(.ok, token)
            default:
                completion(.error, nil)
            }
        }
    }
    
}
