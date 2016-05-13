//
//  ViewController.swift
//  Carousel
//
//  Created by German Pereyra on 13/May/16.
//  Copyright © 2016 Neon Roots. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let c = Carousel(frame: self.view.frame, padding: 30, delegate: self)
        self.view.backgroundColor = UIColor.blackColor()
        self.view.addSubview(c)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: CarouselDelegate {
    
    func numberOfItemsInCarousel() -> Int {
        return 5
    }
    
    func carousel(carousel: Carousel, viewAtIndex: Int, frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: frame.height))
        view.addSubview(button)
        button.addTarget(self, action: #selector(ViewController.buttonPressed(_:)), forControlEvents: .TouchUpInside)
        button.setTitle("\(viewAtIndex)", forState: .Normal)
        button.backgroundColor = UIColor.getRandomColor()
        return view
    }
    
    func buttonPressed(sender: UIButton) {
        print("buttonPressed \(sender.titleLabel!.text)")
    }
}

extension UIColor {
    class func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}

