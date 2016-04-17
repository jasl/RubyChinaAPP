//
// Created by 姜军 on 12/16/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import SwiftyJSON
import MoyaX

extension RubyChinaV3 {
    struct Photos {
        static let Path = "photos"

        struct Create: EndpointType {
            let data: NSData
            let fileName: String

            init(photo: UIKit.UIImage, fileName: String = "uploading_photo.jpg") {
                // TODO: Needs optimize
                self.data = UIKit.UIImageJPEGRepresentation(photo, 1)!
                self.fileName = fileName
            }

            let baseURL = RubyChinaV3.BaseURL
            let path = "photos"
            let method =  HTTPMethod.POST
            var parameters: [String: Any] {
                return ["file": DataForMultipartFormData(data: self.data, fileName: self.fileName, mimeType: "image/jpeg")]
            }
            let parameterEncoding = ParameterEncoding.MultipartFormData

            typealias DeserializedType = Node

            func parseResponse(json: JSON) -> String? {
                return json["image_url"].string
            }
        }
    }
}
