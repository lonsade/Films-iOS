//
//  BaseViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import UIKit

// TODO: Перенести в Core
open class BaseViewController: UIViewController, BaseHandlerController {
    func openModule(withName name: String) {
        self.performSegue(withIdentifier: name, sender: nil)
    }

    // FIXME: Здесь не нужен параметр, ведь мы можем закрыть только текущий модуль.
    func closeModule(withName name: String) {
        // FIXME: Если не будет navigation controller'а, твоё приложение упадёт, хотя оно должно попробовать закрыть модальный экран тоже.
        // Падать оно должно только в том случае, когда происходит попытка закрыть корнейвой view controller, перед которым ничего нет.
        //
        // Строка "if (navigationController?.viewControllers.count)! > 1 {" выглядет не очень читабельно из-за этих скобок.
        // Было бы правильней так: "if navigationController!.viewControllers.count > 1 {".
        
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
