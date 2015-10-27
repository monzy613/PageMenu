//
//  ViewController.swift
//  PageMenu
//
//  Created by Monzy on 15/10/27.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIScrollViewDelegate, UIPageViewControllerDelegate {

    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    var currentPage = 0
    var isDraggingRight = true
    var pageViewController: UIPageViewController?
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        for sView in pageViewController!.view.subviews {
            if sView.isKindOfClass(UIScrollView) {
                (sView as! UIScrollView).delegate = self
            }
        }

        pageViewController?.dataSource = self
        pageViewController?.delegate = self
        pageViewController?.setViewControllers([(self.storyboard?.instantiateViewControllerWithIdentifier("FirstViewController"))!], direction: .Forward, animated: true, completion: nil)
        pageViewController?.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 30)
        self.addChildViewController(pageViewController!)
        self.view.addSubview((pageViewController?.view)!)
        setCurrentIndex(0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setCurrentIndex(index: Int) {
        if index == 0 {
            firstButton.backgroundColor = .whiteColor()
            secondButton.backgroundColor = .clearColor()
            thirdButton.backgroundColor = .clearColor()
        } else if index == 1 {
            firstButton.backgroundColor = .clearColor()
            secondButton.backgroundColor = .whiteColor()
            thirdButton.backgroundColor = .clearColor()
        } else if index == 2 {
            firstButton.backgroundColor = .clearColor()
            secondButton.backgroundColor = .clearColor()
            thirdButton.backgroundColor = .whiteColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(FirstViewController) {
            return self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController")
        } else if viewController.isKindOfClass(SecondViewController) {
            return self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController")
        } else if viewController.isKindOfClass(ThirdViewController) {
            return nil
        } else {
            return nil
        }

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(FirstViewController) {
            return nil
        } else if viewController.isKindOfClass(SecondViewController) {
            return self.storyboard?.instantiateViewControllerWithIdentifier("FirstViewController")
        } else if viewController.isKindOfClass(ThirdViewController) {
            return self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController")

        } else {
            return nil
        }
    }
    
    

    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.x > 0 {
            //-->
            isDraggingRight = true
        } else if velocity.x < 0 {
            //<--
            isDraggingRight = false
        }
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == false {
            return
        }
        
        if isDraggingRight {
            if currentPage != 2 {
                currentPage++
                setCurrentIndex(currentPage)
            }
        } else {
            if currentPage != 0 {
                currentPage--
                setCurrentIndex(currentPage)
            }
        }
    }

}

