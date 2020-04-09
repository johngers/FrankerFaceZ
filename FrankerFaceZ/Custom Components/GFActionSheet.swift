//
//  GFActionSheet.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/5/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class GFActionSheet: UIAlertController {
    
    init(title:String?, message: String?) {
       // super.init(nibName: nil, bundle: nil)
        super.init(title: title, message: message, preferredStyle: .actionSheet)
        super.init
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure() {
        
    }
    

}
