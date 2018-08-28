//
//  BaseViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import UIKit
import InteractiveSideMenu

open class BaseViewController: MenuViewController, BaseHandlerController, ModuleInputProvider {
    var moduleInput: ModuleInput!

    // Для идентификации фильмы это или тв шоу (0 - films, 1 - tv)
    var type: Int!

    func openModule(withName name: String) {
        // Для изменения кнопки back
        navigationController?.topViewController?.navigationItem.title = nil
        self.performSegue(withIdentifier: name, sender: nil)
    }

    func openModule(withName name: String, configurationClosure: @escaping ConfigurationClosure) {
        self.performSegue(withIdentifier: name, sender: configurationClosure)
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Для изменения кнопки back
        navigationController?.topViewController?.navigationItem.title = nil

        guard let viewController = segue.destination as? ModuleInputProvider else {
            fatalError("Could not cust viewController to ModuleInputProvider")
        }
        guard let custSender = sender as? ConfigurationClosure else {
            fatalError("Could not cust sender to ConfigurationClosure")

        }

        custSender(viewController.moduleInput)
    }

    func closeModule() {
        if let navc = navigationController {
            if navc.viewControllers.count > 1 {
                if navc.presentingViewController!.isModalInPopover {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    navc.popViewController(animated: true)
                }
            } else {
                fatalError("Error close root controller")
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
