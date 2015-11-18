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
    var pageControl: UIPageControl?
    
    
    @IBAction func firstButtonPressed(sender: UIButton) {
        if currentPage == 0 {
            return
        }
        var animationDirection: UIPageViewControllerNavigationDirection = .Forward
        if currentPage > 0 {
            animationDirection = .Reverse
        }
        pageViewController?.setViewControllers([(self.storyboard?.instantiateViewControllerWithIdentifier("FirstViewController"))!], direction: animationDirection, animated: true, completion: nil)
        currentPage = 0
        setCurrentIndex(0)
    }
    
    @IBAction func secondButtonPressed(sender: UIButton) {
        if currentPage == 1 {
            return
        }
        var animationDirection: UIPageViewControllerNavigationDirection = .Forward
        if currentPage > 1 {
            animationDirection = .Reverse
        } else {
            animationDirection = .Forward
        }
        pageViewController?.setViewControllers([(self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController"))!], direction: animationDirection, animated: true, completion: nil)
        currentPage = 1
        setCurrentIndex(1)
    }
    
    @IBAction func thirdButtonPressed(sender: UIButton) {
        if currentPage == 2 {
            return
        }
        var animationDirection: UIPageViewControllerNavigationDirection = .Forward
        if currentPage < 2 {
            animationDirection = .Forward
        }
        pageViewController?.setViewControllers([(self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController"))!], direction: animationDirection, animated: true, completion: nil)
        currentPage = 2
        setCurrentIndex(2)
    }
    
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
        
        
        pageControl = UIPageControl(frame: CGRect(x: self.view.frame.width / 2 - 20, y: self.view.frame.height - 30, width: 40, height: 30))
        pageControl!.numberOfPages = 3
        pageControl!.currentPage = 0
        pageControl?.addTarget(self, action: "pageAction", forControlEvents: .ValueChanged)
        self.view.addSubview(pageControl!)
        setCurrentIndex(0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func pageAction () {
        let lastPage = currentPage
        let newPage = pageControl!.currentPage
        
        if lastPage == currentPage {
            return
        }
        print("last: \(lastPage) current: \(newPage)")
    }
    
    func setCurrentIndex(index: Int) {
        pageControl?.currentPage = index
        if index == 0 {
            firstButton.enabled = false
            secondButton.enabled = true
            thirdButton.enabled = true
            firstButton.backgroundColor = .whiteColor()
            secondButton.backgroundColor = .clearColor()
            thirdButton.backgroundColor = .clearColor()
        } else if index == 1 {
            firstButton.enabled = true
            secondButton.enabled = false
            thirdButton.enabled = true
            firstButton.backgroundColor = .clearColor()
            secondButton.backgroundColor = .whiteColor()
            thirdButton.backgroundColor = .clearColor()
        } else if index == 2 {
            firstButton.enabled = true
            secondButton.enabled = true
            thirdButton.enabled = false
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

