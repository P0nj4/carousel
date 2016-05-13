//
//  GPCarousel.swift
//  Carousel
//
//  Created by German Pereyra on 13/May/16.
//  Copyright © 2016 Neon Roots. All rights reserved.
//

import UIKit

protocol CarouselDelegate {
    func carousel(carousel: Carousel, viewAtIndex: Int, frame: CGRect) -> UIView
    func numberOfItemsInCarousel() -> Int
}

class Carousel: UIView {
    
    //UI
    private var scroll: UIScrollView!
    
    //Data
    private var padding: CGFloat!
    private var delegate: CarouselDelegate!
    
    convenience init(frame: CGRect, padding: CGFloat, delegate: CarouselDelegate) {
        self.init(frame: frame)
        self.padding = padding
        self.delegate = delegate
        self.scroll = UIScrollView(frame: CGRect(x: padding, y: 0, width: frame.width - padding * 2, height: frame.height))
        self.scroll.pagingEnabled = true
        self.scroll.clipsToBounds = false
        self.scroll.showsVerticalScrollIndicator = false
        self.scroll.showsHorizontalScrollIndicator = false
        
        let numberOfItems = self.delegate.numberOfItemsInCarousel()
        for i in 0..<numberOfItems {
            let view = self.delegate.carousel(self, viewAtIndex: i, frame: CGRectMake((self.scroll.frame.width) * CGFloat(i), 0, self.scroll.frame.width, self.scroll.frame.height))
            self.scroll.addSubview(view)
        }
        
        self.scroll.contentSize = CGSize(width: scroll.frame.width * CGFloat(numberOfItems), height: self.scroll.frame.height)
        
        self.clipsToBounds = false
        self.addSubview(scroll)
    }
    
    override func layoutSubviews() {
        self.scroll.frame = CGRect(x: padding, y: 0, width: frame.width - padding * 2, height: frame.height)
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if self.pointInside(point, withEvent: event) {
            if let result = self.findHitTest(self.scroll, point: point, event: event) {
                return result
            }
            return self.scroll
        }
        return nil
    }
    
    func findHitTest(view: UIView, point: CGPoint, event: UIEvent?) -> UIView? {
        for subview in view.subviews.reverse() {
            let convertedPoint = subview.convertPoint(point, toView: self)
            if let result = subview.hitTest(convertedPoint, withEvent: event) {
                return result
            } else {
                if subview.subviews.count > 0 {
                    if let result = self.findHitTest(subview, point: convertedPoint, event: event) {
                        return result
                    }
                }
            }
        }
        return nil
    }
}