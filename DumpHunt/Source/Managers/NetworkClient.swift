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
        case form = "application/x-www-form-urlencoded"
        case version = "v1"
    }
    
    enum HTTPHeaderField: String {
        
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case apiVersion = "Api-Version"
    }
    
    let userDefaults = UserDefaults.standard
    
    private var headers: HTTPHeaders {
        return [
            HTTPHeaderField.contentType.rawValue: ContentType.form.rawValue,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.apiVersion.rawValue: ContentType.version.rawValue
        ]
    }
    

    private let ApiUrlPath = "http://0.0.0.0:8000/api/v1/reports/"


    
    func postSaveReport(report: Report?,
                        success: ReportCompletion?,
                        failure: ErrorCompletion?) {
        
        let parameters: [String : Any] = ["lat": 64.513695,
                                          "long": 40.507912,
                                          "comment": "Здесь все грязно",
                                          "feedback_info": "Serik"]
        
//        guard let latitude = report?.latitude,
//            let longitude = report?.longitude else { return }
//
//        let parameters: [String : Any] = ["lat": latitude,
//                                          "long": longitude,
//                                          "comment": report?.comment ?? "",
//                                          "feedback_info": report?.fio ?? ""]
        
        var imageData: Data!
        if let image = report?.photo {
            imageData = image.jpegData(compressionQuality: 0.5)
        } else {
            let image = UIImage(named: "hunt.jpg")
            imageData = image!.jpegData(compressionQuality: 0.5) // placeholder
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                
//                if let values = value as? [String] {
//                    for item in values {
//                        multipartFormData.append(item.data(using: .utf8)!, withName: key)
//                    }
//                }
                
            }
            multipartFormData.append(imageData, withName: "photo",
                                     fileName: "swift_file.png",
                                     mimeType: "image/png")
        }, to: ApiUrlPath,
           usingThreshold: UInt64.init(),
           method: .post,
           headers: headers).validate(statusCode: 200..<300).response { response in
            
            guard let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
            
            switch response.result {
            case .success:
                if let report = self.reportMap(data: data) {
                    success?(report)
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

    private func reportMap(data: Data?) -> Report? {
        guard let data = data else { return nil }
        let report: Report = try! JSONDecoder().decode(Report.self, from: data)
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
                return
        }
        
        Utill.printInTOConsole("Error StatusCode - \(String(describing: statusCode))")
        success?(message)
    }
    
}
