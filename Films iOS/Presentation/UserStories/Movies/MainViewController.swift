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
    
    private var prevSelectedCell: TabNameCollectionViewCell?
    
    private var tabDisplayManager: TabDisplayManager? {
        didSet {
            tabDisplayManager!.collectionTabNames = self.collectionTabNames
            tabDisplayManager!.delegate = self
        }
    }
    
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
    @IBOutlet weak var collectionTabNames: UICollectionView!
    
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
        
        tabDisplayManager = TabDisplayManager()
        
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
}

extension MainViewController: UIPageViewControllerDelegate {
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension MainViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}

extension MainViewController: TabDisplayManagerDelegate {
    
    func tabWasSelected(at indexPath: IndexPath) {
        
        let selectedCell = collectionTabNames.cellForItem(at: indexPath) as! TabNameCollectionViewCell
        
        if let psc = prevSelectedCell {
            psc.changeActive(active: false)
        }
        
        selectedCell.changeActive(active: true)
        
        prevSelectedCell = selectedCell
        
    }
}
