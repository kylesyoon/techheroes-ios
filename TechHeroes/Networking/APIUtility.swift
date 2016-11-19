//
//  APIUtility.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/15/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

// TODO: Clean this shit up once we're talking with our own API

import Foundation
import Alamofire

struct APIUtility {

    static func requestAccessToken(for authCode: String, success: @escaping (String, Int) -> Void, failure: @escaping (Error) -> Void) {
        let accessTokenURL = "https://www.linkedin.com/oauth/v2/accessToken"
        let grantType = "authorization_code"
        let params = ["grant_type": grantType,
                      "code": authCode,
                      "redirect_uri": "https://" + redirect + "/oauth",
                      "client_id": linkedInID,
                      "client_secret": linkedInSecret]
        let headers = ["Content-Type": "application/x-www-form-urlencoded;"]
        SessionManager.default.request(accessTokenURL,
                                       method: .post,
                                       parameters: params,
                                       encoding: URLEncoding.default,
                                       headers: headers)
            .responseJSON() { response in
                switch response.result {
                case .success:
                    guard let dictionary = response.result.value as? [String: Any],
                        let accessToken = dictionary["access_token"] as? String,
                        let expiresIn = dictionary["expires_in"] as? Int
                        else {
                            // TODO: Key-value association error
                            failure(NSError())
                            return
                    }
                    success(accessToken, expiresIn)
                case .failure(let error):
                    failure(error)
                }
        }
    }
    
    static func requestUserInfo(for accessToken: String, success: @escaping (User) -> Void, failure: @escaping (Error) -> Void) {
        let profileURL = "https://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,location:(name,country:(code)),industry,num-connections,num-connections-capped,summary,specialties,positions:(id,title,summary,start-date,end-date,is-current,company:(id,name,type,industry,ticker)),picture-url,picture-urls::(original),public-profile-url,email-address)"
        let headers = ["Content-Type": "application/x-www-form-urlencoded;",
                       "x-li-format": "json",
                       "Authorization": "Bearer \(accessToken)"]
        SessionManager.default.request(profileURL,
                                       method: .get,
                                       parameters: ["format": "json"],
                                       encoding: URLEncoding.default,
                                       headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let dictionary = response.result.value as? [String: Any],
                    let positionJSON = dictionary["positions"] as? [String: Any],
                        let positionValues = positionJSON["values"] as? [[String: Any]],
                        let imagesJSON =  dictionary["pictureUrls"] as? [String: Any],
                        let imagesValues = imagesJSON["values"] as? [String] else { return }
                    var positions = [Position]()
                    for values in positionValues {
                        let newPosition = Position(id: values["id"] as? String ?? "",
                                                   title: values["title"] as? String ?? "",
                                                   company: Company(id: (values["company"] as? [String: Any])?["id"] as? String ?? "",
                                                                    industry: (values["company"] as? [String: Any])?["industry"] as? String ?? "",
                                                                    name: (values["company"] as? [String: Any])?["name"] as? String ?? "",
                                                                    type: (values["company"] as? [String: Any])?["type"] as? String ?? ""),
                                                   startDate: ((values["startDate"] as? [String: Any])?["month"] as? Int ?? 0, (values["startDate"] as? [String: Any])?["year"] as? Int ?? 0),
                                                   endDate: ((values["endDate"] as? [String: Any])?["month"] as? Int ?? 0, (values["endDate"] as? [String: Any])?["year"] as? Int ?? 0),
                                                   isCurrent: values["isCurrent"] as? Bool ?? false,
                                                   summary: values["summary"] as? String ?? "")
                        positions.append(newPosition)
                    }
                    
                    let newUser = User(id: dictionary["id"] as? String ?? "",
                                       firstName: dictionary["firstName"] as? String ?? "",
                                       lastName: dictionary["lastName"] as? String ?? "",
                                       headline: dictionary["headline"] as? String ?? "",
                                       industry: dictionary["industry"] as? String ?? "",
                                       connectionsCount: dictionary["numConnections"] as? Int ?? 0,
                                       summary: dictionary["summary"] as? String ?? "",
                                       specialties: dictionary["specialties"] as? String ?? "",
                                       positions: positions,
                                       smallImageURL: dictionary["pictureUrl"] as? String ?? "",
                                       bigImageURLs: imagesValues,
                                       publicProfileURL: dictionary["publicProfileUrl"] as? String ?? "",
                                       location: (((dictionary["location"] as? [String: Any])?["country"] as? [String: Any])?["code"] as? String ?? "", (dictionary["location"] as? [String: Any])?["name"] as? String ?? ""))
                    success(newUser)
                case .failure(let error):
                    failure(error)
                }
        }
    }
    
}
