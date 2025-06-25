//
//  Extension.swift
//  WWSystemStatus
//
//  Created by William.Weng on 2025/6/5.
//

import UIKit

// MARK: - JSONSerialization (static function)
extension JSONSerialization {
    
    /// [JSONObject => JSON Data](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-jsonserialization-印出美美縮排的-json-308c93b51643)
    /// - ["name":"William"] => {"name":"William"} => 7b226e616d65223a2257696c6c69616d227d
    /// - Parameters:
    ///   - object: Any
    ///   - options: JSONSerialization.WritingOptions
    /// - Returns: Data?
    static func _data(with object: Any, options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data? {
        
        guard JSONSerialization.isValidJSONObject(object),
              let data = try? JSONSerialization.data(withJSONObject: object, options: options)
        else {
            return nil
        }
        
        return data
    }
}

// MARK: - Dictionary (function)
extension Dictionary {
    
    /// Dictionary => JSON Data
    /// - ["name":"William"] => {"name":"William"} => 7b226e616d65223a2257696c6c69616d227d
    /// - Parameter options: JSONSerialization.WritingOptions
    /// - Returns: Data?
    func _jsonData(options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data? {
        return JSONSerialization._data(with: self, options: options)
    }
}

// MARK: - Sequence (function)
extension Sequence {
    
    /// [仿javaScript的forEach()](https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach)
    /// - Parameter forEach: (Int, Element, Self)
    func _forEach(_ forEach: (Int, Element, Self) -> Void) {
        
        for (index, object) in self.enumerated() {
            forEach(index, object, self)
        }
    }
    
    /// Array => JSON Data
    /// - ["name","William"] => {"name","William"} => 5b226e616d65222c2257696c6c69616d225d
    /// - Returns: Data?
    func _jsonData(options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data? {
        return JSONSerialization._data(with: self, options: options)
    }
    
    /// Array => JSON Object
    /// - Parameters:
    ///   - writingOptions: JSONSerialization.WritingOptions
    ///   - readingOptions: JSONSerialization.ReadingOptions
    /// - Returns: Any?
    func _jsonObject(writingOptions: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions(), readingOptions: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        return self._jsonData(options: writingOptions)?._jsonObject(options: readingOptions)
    }
    
    /// Array => JSON String
    /// - Parameters:
    ///   - options: JSONSerialization.WritingOptions
    ///   - encoding: String.Encoding
    /// - Returns: String?
    func _jsonString(options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions(), using encoding: String.Encoding = .utf8) -> String? {
        return self._jsonData(options: options)?._string(using: encoding)
    }
}

// MARK: - Data (function)
extension Data {
        
    /// Data => Class
    /// - Parameter type: 要轉型的Type => 符合Decodable
    /// - Returns: T => 泛型
    func _class<T: Decodable>(type: T.Type) -> T? {
        let modelClass = try? JSONDecoder().decode(type.self, from: self)
        return modelClass
    }
    
    /// Data => 字串
    /// - Parameter encoding: 字元編碼
    /// - Returns: String?
    func _string(using encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    /// [Data => JSON](https://blog.zhgchg.li/現實使用-codable-上遇到的-decode-問題場景總匯-下-cb00b1977537)
    /// - 7b2268747470223a2022626f6479227d => {"http": "body"}
    /// - Returns: Any?
    func _jsonObject(options: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        let json = try? JSONSerialization.jsonObject(with: self, options: options)
        return json
    }
}

// MARK: - Encodable (function)
extension Encodable {
    
    /// Class => JSON Data
    /// - Returns: Data?
    func _jsonData() -> Data? {
        guard let jsonData = try? JSONEncoder().encode(self) else { return nil }
        return jsonData
    }
    
    /// Class => JSON String
    /// - Parameter encoding: String.Encoding
    /// - Returns: String?
    func _jsonString(using encoding: String.Encoding = .utf8) -> String? {
        guard let jsonData = self._jsonData() else { return nil }
        return jsonData._string(using: encoding)
    }
    
    /// Class => JSON Object
    /// - Returns: Any?
    func _jsonObject() -> Any? {
        guard let jsonData = self._jsonData() else { return nil }
        return jsonData._jsonObject()
    }
}
