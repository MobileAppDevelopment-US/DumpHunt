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
    
    static let ApiUrlPath = "http://teachyourself.pythonanywhere.com/api/v1"

    private let PostReport = "\(ApiUrlPath)/reports/"
    private let GetReports = "\(ApiUrlPath)/reports/"

    // MARK: - Methods
    
    func postSaveReport(report: Report?,
                        success: VoidCompletion?,
                        failure: ErrorCompletion?) {
        
        guard let latitude = report?.latitude,
            let longitude = report?.longitude else {
                failure?("Отсутствуют координаты")
                return
        }

        let fio = report?.fio ?? ""
        let phone = report?.phone ?? ""
        let comment = report?.comment ?? ""

        let parameters: [String : Any] = ["lat": latitude,
                                          "long": longitude,
                                          "feedback_info": "ФИО - \(fio);  Номер телефона - \(phone);  Комментарий - \(comment)"]

        var imageData: Data!
        if let image = report?.photo {
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

            Utill.printInTOConsole("response = \(String(data: data, encoding: .utf8) ?? "")")
            
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
    
    func getReports(success: ReportsCompletion?,
                    failure: ErrorCompletion?) {
        
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
                    
                    switch response.result {
                    case .success:
                        if let reports = self.reportsMap(data: data) {
                            success?(reports)
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
    
}

// MARK: - MAPPING

extension NetworkClient {

    private func reportsMap(data: Data?) -> [Report]? {
        guard let data = data else { return nil }
        let report: [Report] = [try! JSONDecoder().decode(Report.self, from: data)]
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
