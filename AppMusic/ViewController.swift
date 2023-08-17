//
//  ViewController.swift
//  AppMusic
//
//  Created by Thanh Duong on 16/08/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate() // Gọi hàm này để cập nhật trạng thái thanh trạng thái
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // Màu chữ và biểu tượng trạng thái sáng trên nền màn hình đen
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide // Hiệu ứng khi cập nhật trạng thái thanh trạng thái
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
       
//        Do any additional setup after loading the view.
       
        
    }


}

