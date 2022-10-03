//
//  ContainerViewController.swift
//  Menu&Blur
//
//  Created by Stanislav Sobolevsky on 22.09.22.
//

import UIKit

class ContainerViewController: UIViewController, ViewControllerDelegate {
    var controller: ViewController!
    var menuViewController: MenuViewController!
    var isMove = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureMenuViewController()
    }

    func configureViewController() {
        let myViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        myViewController.delegate = self
        controller = myViewController
        view.addSubview(controller.view)
        addChild(controller)
    }
    func configureMenuViewController() {
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            print("Добавили mainViewController")
        }
    }
    func showMenuViewController(shouldMove: Bool) {
        if shouldMove {
            // показываем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = self.controller.view.frame.width - 140
            })
            { _ in
            }
        } else {
            // убираем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = 0
            }) { _ in
            }
        }
    }
    func didTapped() {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blur)
        let vibraEf = UIVibrancyEffect(blurEffect: blur)
        let vibraView = UIVisualEffectView(effect: vibraEf)
        self.controller.view.addSubview(blurView)
        blurView.contentView.addSubview(vibraView)
            blurView.translatesAutoresizingMaskIntoConstraints = false
            vibraView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.controller.view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.controller.view.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.controller.view.trailingAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.controller.view.leadingAnchor),
            vibraView.heightAnchor.constraint(equalTo: blurView.contentView.heightAnchor),
            vibraView.widthAnchor.constraint(equalTo: blurView.contentView.widthAnchor),
            vibraView.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            vibraView.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            controller.view.centerXAnchor.constraint(equalTo: vibraView.contentView.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: vibraView.contentView.centerYAnchor)])
    }
    // MARK: ViewControllerDelegate
    func toggleMenu() {
        didTapped()
        configureMenuViewController()
        isMove = !isMove
        showMenuViewController(shouldMove: isMove)
    }
}
