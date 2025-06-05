//
//  Constant.swift
//  WWSystemStatus
//
//  Created by William.Weng on 2025/6/5.
//

import Foundation

extension WWSystemStatus {
    
    /// 自定義錯誤
    enum CustomError: Error {
        case responseNull
        case formatError
        case httpError(_ code: Int)
    }
}
