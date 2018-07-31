//
//  BaseViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController, BaseHandlerController {
    func openModule(withName name: String) {
        self.performSegue(withIdentifier: name, sender: nil)
    }
    
    func closeModule(withName name: String) {
        
        if (navigationController?.viewControllers.count)! > 1 {
            
            if (navigationController?.presentingViewController?.isModalInPopover)! {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                navigationController?.popViewController(animated: true)
            }
        }
        else {
            fatalError("")
        }
        
    }
    
    
}
