//
//  BaseMainPageViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 21.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol BaseMainPageViewControllerHandler: class {
    func set(pages: [TabName], storyboardName: String)
    var pageDelegate: BaseMainPageViewControllerDelegate? { get set }
    var pagedViewControllers: [TabName: UIViewController] { get }
    var genres: [TabName] { get }
    var viewPages: [UIViewController] { get }
    // Для определения муви или тв шоу
    var type: Int! { get set }
}

protocol BaseMainPageViewControllerDelegate: class {
    func pageWasChanged(to toIndex: Int, from fromIndex: Int)
}

final class BaseMainPageViewController: UIPageViewController, BaseMainPageViewControllerHandler, ModuleInputProvider {

    weak var pageDelegate: BaseMainPageViewControllerDelegate?

    var pagedViewControllers: [TabName: UIViewController] = [:]

    var genres: [TabName] = []

    var type: Int!

    var viewPages: [UIViewController] = []

    var moduleInput: ModuleInput!

    var currentViewController: UIViewController?

    private var storyboardName: String!

    override func setViewControllers(
        _ viewControllers: [UIViewController]?,
        direction: UIPageViewControllerNavigationDirection,
        animated: Bool,
        completion: ((Bool) -> Void)? = nil
    ) {
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
        guard let viewController = viewControllers?.first else {
            fatalError("Could not set empty viewController")
        }
        currentViewController = viewController
    }

    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }

    func set(pages: [TabName], storyboardName: String) {
        self.storyboardName = storyboardName
        self.genres = pages

        // Clear for each menuitemcontroller

        pagedViewControllers = [:]
        viewPages = []
        currentViewController = nil
        currentIndex = 1
        prevIndex = 1
        pendingIndex = nil

        pages.forEach { page in
            pagedViewControllers[page] = getViewController(withIdentifier: "Films")
            viewPages.append(pagedViewControllers[page]!)
        }
    }

    func configureModule(withName name: TabName, configurationClosure: @escaping ConfigurationClosure) {
        guard let pagedvc = pagedViewControllers[name] as? ModuleInputProvider else { fatalError("") }
        configurationClosure(pagedvc.moduleInput)
    }

    // Текущий индекс
    var currentIndex: Int = 1   // Popular
    private var pendingIndex: Int?

    //Предыдущий индекс
    var prevIndex: Int = 1  // Popular

}

extension BaseMainPageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = viewPages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard viewPages.count > previousIndex else { return nil }

        if let pageController = pageViewController as? BaseMainPageViewController {
            pageController.configureModule(withName: pageController.genres[previousIndex]) { moduleInput in
                guard let filmsInput = moduleInput as? FilmsPresenterInput else {
                    fatalError("Could not cust moduleInput to FilmsPresenterInput")
                }
                filmsInput.set(genre: pageController.genres[previousIndex], type: self.type)
            }
        }

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

        if let pageController = pageViewController as? BaseMainPageViewController {
            pageController.configureModule(withName: pageController.genres[nextIndex]) { moduleInput in
                guard let filmsInput = moduleInput as? FilmsPresenterInput else {
                    fatalError("Could not cust moduleInput to FilmsPresenterInput")
                }
                filmsInput.set(genre: pageController.genres[nextIndex], type: self.type)
            }
        }

        return viewPages[nextIndex]
    }
}

extension BaseMainPageViewController: UIPageViewControllerDelegate {
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
            if let index = pendingIndex {
                currentIndex = index
                prevIndex = viewPages.index(of: previousViewControllers.last!)!
                pageDelegate?.pageWasChanged(to: index, from: prevIndex)
            }
        }
    }
}
