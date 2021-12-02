//
//  NetworkManager.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 4.10.21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func getServicesAndFilters(complition: @escaping ((RequestStatus, [Service]?, [CarType]?, [TypeService]?) -> Void)) {
        AF.request(Constants.api).validate().responseDecodable(of: ServiceInitData.self) { (response) in
            guard let data = response.value else {
                complition(.error, nil, nil, nil)
                return
            }
            complition(.ok, data.partners, data.types, data.works)
        }
    }
    
    func getServices(filterCarType: String, pageNumber: Int, search: String, latitude: Double, longitude: Double, filterWorksType: [String], complition: @escaping ((RequestStatus, [Service]?) -> Void)) {
        var parameters: [String: Any] = [
            "type": filterCarType,
            "name": search,
            "page": pageNumber,
            "latitude": latitude,
            "longitude": longitude,
        ]
        if filterWorksType.count > 0 {
            parameters["id"] = filterWorksType.joined(separator: ",")
        }
        AF.request(Constants.apiPartners, parameters: parameters).validate().responseDecodable(of: [Service].self) { (response) in
            guard let data = response.value else {
                complition(.error, nil)
                return
            }
            complition(.ok, data)
        }
    }
    
    func getFullInfoService(id: Int, complition: @escaping ((RequestStatus, Service?) -> Void)) {
        let url = Constants.apiPartners + "/\(id)"
        AF.request(url).validate().responseDecodable(of: Service.self) { (response) in
            guard let data = response.value else {
                complition(.error, nil)
                return
            }
            complition(.ok, data)
        }
    }
    
    func requestOnWorks(partnerId: Int, clientName: String, clientPhone: String, clientAuto: String, works: [TypeService], visitDate: String, currentDate: String, complition: @escaping ((RequestStatus) -> Void)) {
        let parameters: [String: Any] = [
            "partnerId": partnerId,
            "clientName": clientName,
            "clientPhone": clientPhone,
            "clientAuto": clientAuto,
            "bookingDate": visitDate,
            "createDate": currentDate,
            "lines": works.map({ work in
                return ["id": work.id, "price": work.price, "count": 1]
            })
        ]
        
        AF.request(Constants.apiCreateOrder, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: ResponseStatus.self) { (response) in
            guard let data = response.value else {
                complition(.error)
                return
            }
            complition(data.success ? .ok : .error)
        }
        
    }
    
    func addReview(serviceId: Int, name: String, description: String, rating: Int, complition: @escaping ((RequestStatus) -> Void)) {
        let url = Constants.apiPartners + "/\(serviceId)/reviews"
        let parameters: [String: Any] = [
            "ball": rating,
            "message": description,
            "name": name
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: ResponseStatus.self) { (response) in
            guard let data = response.value else {
                complition(.error)
                return
            }
            complition(data.success ? .ok : .error)
        }
    }
    
    func getOrders(complition: @escaping ((RequestStatus, [Order]?) -> Void)) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let headers: HTTPHeaders = ["Cookie": "JSESSIONID=\(token)"]
        
        AF.request(Constants.apiOrders, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: [Order].self) { (response) in
            guard let data = response.value else {
                complition(.error, nil)
                return
            }
            complition(.ok, data)
        }
    }
    
    func getInfoForPartnerCabinet(completion: @escaping ((RequestStatus, PersonalArea?) -> Void)) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = Constants.apiPersonalCabinet
        let headers: HTTPHeaders = ["Cookie": "JSESSIONID=\(token)"]
        
        AF.request(url, headers: headers).validate().responseDecodable(of: PersonalArea.self) { response in
            guard let data = response.value else {
                completion(.error, nil)
                return
            }
            completion(.ok, data)
        }
        
    }
    
    func getFullServicesList(completion: @escaping ((RequestStatus, [TypeService]?) -> Void)) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = Constants.apiServices
        let headers: HTTPHeaders = ["Cookie": "JSESSIONID=\(token)"]
        
        AF.request(url, headers: headers).validate().responseDecodable(of: [TypeService].self) { response in
            guard let data = response.value else {
                completion(.error, nil)
                return
            }
            completion(.ok, data)
        }
    }
    
    func saveServicesList(typeServices: [TypeService], completion: @escaping ((RequestStatus) -> Void)) {
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = Constants.apiUpdatingServices
        let headers: HTTPHeaders = ["Cookie": "JSESSIONID=\(token)"]
        
        var request = try! URLRequest(url: url, method: .post, headers: headers)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if typeServices.count > 0 {
            request.httpBody = try! JSONSerialization.data(withJSONObject: typeServices.map({ typeService in
                return ["id": typeService.id, "price": typeService.price]
            }))
        }
        
        AF.request(request).responseDecodable(of: ResponseStatus.self) { response in
            guard let data = response.value else {
                completion(.error)
                return
            }
            if data.success {
                completion(.ok)
            } else {
                completion(.error)
            }
        }
        
    }
    
    func savePersonalInfoPartner(id: Int, name: String, description: String, email: String, phone: String, address: String, schedule: String, longitude: Double, latitude: Double, carType: String, completion: @escaping ((RequestStatus) -> Void)) {
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = Constants.apiSavePersonalInfoPartner
        let headers: HTTPHeaders = ["Cookie": "JSESSIONID=\(token)"]
        let parameters: [String: Any] = ["id": id,
                                         "name": name,
                                         "description": description,
                                         "email": email,
                                         "phone": phone,
                                         "address": address,
                                         "schedule": schedule,
                                         "carType": carType,
                                         "longitude": longitude,
                                         "latitude": latitude]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: ResponseStatus.self) { response in
            guard let data = response.value else {
                print(response)
                completion(.error)
                return
            }
            if data.success {
                completion(.ok)
            } else {
                completion(.error)
            }
            
        }
    }
    
    func uploadPartnerPhoto(data: Data, completion: @escaping ((RequestStatus) -> Void)) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let headers: HTTPHeaders = ["Cookie": "JSESSIONID=\(token)"]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "image", fileName: UUID().uuidString + ".jpeg")
        }, to: Constants.apiUploadPartnerPhoto, headers: headers).responseDecodable(of: ResponseStatus.self) { response in
            guard let data = response.value else {
                completion(.error)
                return
            }
            if data.success {
                completion(.ok)
            } else {
                completion(.error)
            }
        }
    }
}
