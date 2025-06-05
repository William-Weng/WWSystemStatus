//
//  WWSystemStatus.swift
//  WWSystemStatus
//
//  Created by William.Weng on 2025/6/5.
//

import UIKit
import WWNetworking

// MARK: - WWSystemStatus
open class WWSystemStatus {
    
    @MainActor
    public static let shared = WWSystemStatus()
}

// MARK: - public function
public extension WWSystemStatus {
    
    /// [取得各相關系統系統狀態數值](https://www.apple.com/tw/support/systemstatus/)
    /// - Parameter langCode: 語系名稱
    /// - Returns: Result<SystemStatus, Error>
    func check(langCode: String = "en_US") async -> Result<SystemStatus, Error> {
        
        let urlString = "https://www.apple.com/support/systemstatus/data/system_status_\(langCode).js"
        let result = await WWNetworking.shared.request(urlString: urlString)
        
        switch result {
        case .failure(let error): return .failure(error)
        case .success(let info):
            
            guard let response = info.response else { return .failure(CustomError.responseNull) }
            guard response.statusCode == 200 else { return .failure(CustomError.httpError(response.statusCode)) }
            
            guard let data = info.data,
                  let systemStatus = data._class(type: SystemStatus.self)
            else {
                return .failure(CustomError.formatError)
            }
            
            return .success(systemStatus)
        }
    }
}
