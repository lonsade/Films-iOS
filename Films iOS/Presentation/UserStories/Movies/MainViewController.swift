//
//  MainViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // Почему public?
    public let reuseIdentifier = "tabName"
    
    private var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }
    
    private var tabNamesString = ["IN CINEMA", "POPULAR", "COMEDIES", "DRAMA", "HISTORICAL"]
    
    private var currentTab: UIButton?
    
    /* с помощью такой обвертки фиксится ширина ячейки таба */
    
    lazy var tabNames: [NSAttributedString] = {
        var temp = [NSAttributedString]()
        for str in tabNamesString {
             temp.append(NSAttributedString(
                string: str,
                attributes: [
                    .foregroundColor: UIColor.FTabNameColor,
                    .font: UIFont.FTabName
                ]
            ))
        }
        return temp
    }()
    
    lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "IN CINEMA"),
            self.getViewController(withIdentifier: "POPULAR")
        ]
    }()
    
    @IBOutlet weak var borderView: UIView! {
        didSet{
            borderView.backgroundColor = UIColor.FHRColor
        }
    }
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionTabNames: UICollectionView! {
        didSet {
            collectionTabNames.delegate = self
            collectionTabNames.dataSource = self
        }
    }
    
    /* инициализация контроллеров, соответствующих таб вкладок */
    
    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    /* кастомизация navigationBar и установка главного фона */
    
    func customize() {
        view.backgroundColor = UIColor.FMainBackgroundColor
        navigationBar.barTintColor = UIColor.FMainBackgroundColor
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.FTitleTextColor,
            .font: UIFont.FAppName
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
    
    /* клик по табам */
    
    @IBAction func showContent(_ sender: UIButton) {
        if currentTab != nil {
            let tempStr =
                currentTab?.attributedTitle(for: .normal)?
                .getStringWithChangeColor(color: UIColor.FTabNameColor)
            currentTab?.setAttributedTitle(tempStr, for: .normal)
        }

        currentTab = sender
        let tempStr =
            currentTab?.attributedTitle(for: .normal)?
            .getStringWithChangeColor(color: UIColor.FActiveTextColor)
        currentTab?.setAttributedTitle(tempStr, for: .normal)
    }
    
}
