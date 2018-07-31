//
//  MainViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }
    let reuseIdentifier = "tabName"
    var tabNames = ["IN CINEMA", "POPULAR", "COMEDIES", "DRAMA", "HISTORICAL"]
    
    lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "IN CINEMA"),
            self.getViewController(withIdentifier: "POPULAR")
        ]
    }()
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionTabNames: UICollectionView! {
        didSet {
            collectionTabNames.delegate = self
            collectionTabNames.dataSource = self
        }
    }
    
    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func customize() {
        view.backgroundColor = UIColor.FMainBackgroundColor
        navigationBar.barTintColor = UIColor.FMainBackgroundColor
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.FTitleTextColor
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            if let firstVC = pages.first {
                pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    var tabNamesRouting = TabNamesRouting()
    var currentTab: UIButton?
    
    @IBAction func showContent(_ sender: UIButton) {
        if currentTab != nil {
            currentTab?.setTitleColor(UIColor.FContentTextColor, for: .normal)
        }
        currentTab = sender
        currentTab?.setTitleColor(UIColor.FActiveTextColor, for: .normal)
        
        
        
    }
    
    
    
    
    
    
    
}
