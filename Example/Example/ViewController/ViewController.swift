//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2025/6/5.
//

import UIKit
import WWSystemStatus

// MARK: - ViewController
final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let result = await WWSystemStatus.shared.check(langCode: "zh_TW")
            print(result)
        }
    }
}
