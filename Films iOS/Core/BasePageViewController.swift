//
//  BasePageViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol BasePageViewControllerHandler: class {
    func set(pages: [String], storyboardName: String)
    var pageDelegate: BasePageViewControllerDelegate? { get set }
    var viewPages: [UIViewController] { get }
}

protocol BasePageViewControllerDelegate: class {
    func pageWasChanged(at index: Int)
}

class BasePageViewController: UIPageViewController, BasePageViewControllerHandler, ModuleInputProvider {

    var moduleInput: ModuleInput!

    private var storyboardName: String = "Main"

    var viewPages: [UIViewController] = []

    func set(pages: [String], storyboardName: String) {
        self.storyboardName = storyboardName
        pages.forEach { page in
            viewPages.append(getViewController(withIdentifier: page))
        }
    }

    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    weak var pageDelegate: BasePageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }

    //setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)

    // Текущий индекс
    private var currentIndex: Int?
    private var pendingIndex: Int?

//    var pagedViewControllers: [String: UIViewController] = [:]
//
//    func openModule(withName name: String) {
//
//    }
//
//    func closeModule() {
//
//    }
//
//    func configureModule(withName name: String, configurationClosure: @escaping ConfigurationClosure) {
//        guard let vc = pagedViewControllers[name] as? ModuleInputProvider else { fatalError("") }
//        configurationClosure(vc.moduleInput)
//    }

}

extension BasePageViewController: UIPageViewControllerDelegate {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        pendingIndex = viewPages.index(of: pendingViewControllers.first!)
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageDelegate?.pageWasChanged(at: index)
            }
        }
    }

}

extension BasePageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = viewPages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard viewPages.count > previousIndex else { return nil }
        return viewPages[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = viewPages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < viewPages.count else { return nil }
        guard viewPages.count > nextIndex else { return nil }
        return viewPages[nextIndex]
    }

}
