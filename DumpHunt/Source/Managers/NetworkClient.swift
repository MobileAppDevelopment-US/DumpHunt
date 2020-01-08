//
//  NetworkClient.swift
//  DumpHunt
//
//  Created by Serik on 22.12.2019.
//  Copyright © 2019 Serik_Klement. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkClient: NSObject {

    enum ContentType: String {
        case json = "application/json"
    }

    enum HTTPHeaderField: String {
        case contentType = "text/plain"
    }

    private var headers: HTTPHeaders {
        return [
            HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
        ]
    }
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    // MARK: - API
    
    private let GetReports         = "\(Design.ApiUrlPath)/reports/?all=true/"
    private let PostReport         = "\(Design.ApiUrlPath)/reports/"
    private let PostComplainReport = "\(Design.ApiUrlPath)/reports/"

    // MARK: - Methods
    
    func getReports(success: ReportsCompletion?,
                    failure: ErrorCompletion?) {
        
        //let parameters : Parameters =  ["all" : "true"]

        AF.request(GetReports,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
                    guard let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                            failure?("Ошибка сервера")
                            return
                    }
                    Utill.printInTOConsole("GetReports = \(String(data: data, encoding: .utf8) ?? "")")

                    switch response.result {
                    case .success:
                        if let reportsData = self.reportsDataMap(data: data) {
                            success?(reportsData)
                        }
                        break
                        
                    case .failure:
                        self.errorHandler(json: json,
                                          response: response,
                                          success:
                            { (message) in
                                failure?(message)
                        })
                    }
        }
    }

    func postSaveReport(reportVM: ReportVM?,
                        success: VoidCompletion?,
                        failure: ErrorCompletion?) {
        
        guard let latitude = reportVM?.latitude,
            let longitude = reportVM?.longitude else {
                failure?("Отсутствуют координаты")
                return
        }
        var fio = ""
        var phone = ""
        var comment = ""

        if let tempFio = reportVM?.fio {
            fio = "ФИО - \(tempFio);"
        }
        if let tempPhone = reportVM?.phone {
            phone = "Номер телефона - \(tempPhone);"
        }
        if let tempComment = reportVM?.comment {
            comment = "Комментарий - \(tempComment)"
        }
        
        let parameters: Parameters = ["lat": latitude,
                                      "long": longitude,
                                      "comment": "\(comment)",
                                      "feedback_info": "\(fio) \(phone)"]

        var imageData: Data!
        if let image = reportVM?.photo {
            imageData = image.jpegData(compressionQuality: 0.5)
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            multipartFormData.append(imageData, withName: "photo",
                                     fileName: "swift_file.png",
                                     mimeType: "image/png")
        }, to: PostReport,
           usingThreshold: UInt64.init(),
           method: .post,
           headers: headers).validate(statusCode: 200..<300).response { response in
            
            guard let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    failure?("Ошибка сервера")
                    return
            }

            Utill.printInTOConsole("PostReport = \(String(data: data, encoding: .utf8) ?? "")")
            
            switch response.result {
            case .success:
                success?()
                break
                
            case .failure:
                self.errorHandler(json: json,
                                  response: response,
                                  success:
                    { (message) in
                        failure?(message)
                })
            }
        }
    }
    
    func postComplainReport(reportID: Int?,
                            complain: String?,
                            success: VoidCompletion?,
                            failure: ErrorCompletion?) {
        
        guard let reportID = reportID,
            let complain = complain else {
                failure?("Ошибка сервера")
                return
        }
        
        let parameters : Parameters =  ["body": complain]
        let urlPath = "\(PostComplainReport)\(reportID)/content-complain/"
        
        AF.request(urlPath,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers).validate(statusCode: 200..<300).response { response in
                    
            guard let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    failure?("Ошибка сервера")
                    return
            }

            Utill.printInTOConsole("PostReport = \(String(data: data, encoding: .utf8) ?? "")")
            
            switch response.result {
            case .success:
                success?()
                break
                
            case .failure:
                self.errorHandler(json: json,
                                  response: response,
                                  success:
                    { (message) in
                        failure?(message)
                })
            }
        }
    }
    
}

// MARK: - MAPPING

extension NetworkClient {

    private func reportsDataMap(data: Data?) -> ReportsData? {
        guard let data = data else { return nil }
        let report: ReportsData = try! JSONDecoder().decode(ReportsData.self, from: data)
        return report
    }
    
}

// MARK: - ERROR HANDLER

extension NetworkClient {
    
    func errorHandler(json: [String : Any],
                      response: AFDataResponse<Data?>,
                      success: StringCompletion?) {
        
        guard let statusCode = response.response?.statusCode,
            let message: String = json["msg"] as? String else {
                success?("Ошибка сервера")
                return
        }
        
        Utill.printInTOConsole("Error StatusCode - \(String(describing: statusCode))")
        success?(message)
    }
    
}
