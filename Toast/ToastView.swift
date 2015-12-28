//
//  ToastView.swift
//  Toast
//
//  Created by Naohiro Hamada on 2015/12/28.
//  Copyright © 2015年 HaNoHito. All rights reserved.
//

import UIKit

/**
 Toastの表示時間の設定
 
 * Short - 3秒
 * Long - 6秒
 */
enum ToastDuration {
    case Short
    case Long
}

/**
 Toast Viewクラス
 */
class ToastView: UIView {
    
    // MARK: - Class property
    
    /// ToastDuration.Longに対応した表示秒数
    static private let LongDurationInSeconds = 6.0
    
    /// ToastDuration.Shortに対応した表示秒数
    static private let ShortDurationInSeconds = 3.0
    
    /// Toastの表示・非表示にかかるアニメーションの秒数
    static private let FadeInOutDurationInSeconds = 0.4
    
    /// Toastの表示・非表示時のアニメーションのタイプ
    static private let ToastTransition = UIViewAnimationOptions.TransitionCrossDissolve
    
    /// Toastの背景色
    static var toastBackgroundColor: UIColor? {
        get {
            return UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
        }
    }
    
    /// Toastのテキストの色
    static var toastTextColor: UIColor {
        get {
            return UIColor.whiteColor()
        }
    }
    
    /// Toastを非表示にするためのタイマー
    var hideTimer: NSTimer? = nil
    
    // MARK: - Private methods
    
    /// Toast表示後に、非表示にするためのタイマーを起動させる
    private func startTimer(duration: ToastDuration) {
        switch duration {
        case .Short:
            hideTimer = NSTimer(timeInterval: ToastView.ShortDurationInSeconds, target: self, selector: Selector("hideSelf:"), userInfo: nil, repeats: false)
        case .Long:
            hideTimer = NSTimer(timeInterval: ToastView.LongDurationInSeconds, target: self, selector: Selector("hideSelf:"), userInfo: nil, repeats: false)
        }
        let runLoop = NSRunLoop.currentRunLoop()
        runLoop.addTimer(hideTimer!, forMode: NSDefaultRunLoopMode)
    }
    
    /// Toastを非表示にする
    internal func hideSelf(timer: NSTimer) {
        if timer.valid {
            timer.invalidate()
        }
        
        UIView.transitionWithView(self, duration: ToastView.FadeInOutDurationInSeconds, options: ToastView.ToastTransition, animations: nil, completion: { if $0 { self.removeFromSuperview() } } )
        self.hidden = true
    }
    
    // MARK: - Create Toast
    
    /**
      指定した設定でToastの表示を行う
      - parameters:
         - text:    Toastに表示するテキスト
         - duration:    Toastの表示時間を`ToastDuration`で指定。Defaultでは、`ToastDuration.Short`
      - returns:
         生成したToastのView
     */
    static func showText(text: String, duration: ToastDuration = .Short) -> ToastView? {
        guard let keyWindow = UIApplication.sharedApplication().keyWindow else {
            return nil
        }
        guard let targetView = keyWindow.rootViewController?.view else {
            return nil
        }
        
        let offset = CGPointMake(8, 8)
        let frame = CGRectMake(keyWindow.frame.origin.x + offset.x, keyWindow.frame.origin.y + offset.y, keyWindow.frame.size.width - offset.x, keyWindow.frame.size.height - offset.y)
        let toast = ToastView(frame: frame)
        toast.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView(frame: CGRectMake(0, 0, toast.frame.size.width, toast.frame.size.height))
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = ToastView.toastBackgroundColor
        backgroundView.layer.cornerRadius = 4
        
        let textLabel = UILabel(frame: CGRectMake(0, 0, toast.frame.size.width, toast.frame.size.height))
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 4
        textLabel.text = text
        textLabel.textColor = toastTextColor
        textLabel.textAlignment = .Center
        
        toast.addSubview(backgroundView)
        toast.addSubview(textLabel)
        
        targetView.addSubview(toast)
        
        let constraints = [NSLayoutConstraint(item: toast, attribute: .Bottom, relatedBy: .Equal, toItem: backgroundView, attribute: .Bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: toast, attribute: .Top, relatedBy: .Equal, toItem: backgroundView, attribute: .Top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: toast, attribute: .Leading, relatedBy: .Equal, toItem: backgroundView, attribute: .Leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: toast, attribute: .Trailing, relatedBy: .Equal, toItem: backgroundView, attribute: .Trailing, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: backgroundView, attribute: .Bottom, relatedBy: .Equal, toItem: textLabel, attribute: .Bottom, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint(item: backgroundView, attribute: .Top, relatedBy: .Equal, toItem: textLabel, attribute: .Top, multiplier: 1.0, constant: -10.0),
            NSLayoutConstraint(item: backgroundView, attribute: .Leading, relatedBy: .Equal, toItem: textLabel, attribute: .Leading, multiplier: 1.0, constant: -10.0),
            NSLayoutConstraint(item: backgroundView, attribute: .Trailing, relatedBy: .Equal, toItem: textLabel, attribute: .Trailing, multiplier: 1.0, constant: 10.0),
            
            NSLayoutConstraint(item: toast, attribute: .Bottom, relatedBy: .Equal, toItem: targetView, attribute: .BottomMargin, multiplier: 1.0, constant: -12.0),
            NSLayoutConstraint(item: toast, attribute: .Leading, relatedBy: .Equal, toItem: targetView, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: toast, attribute: .Trailing, relatedBy: .Equal, toItem: targetView, attribute: .TrailingMargin, multiplier: 1.0, constant: 0.0),
            ]
        
        NSLayoutConstraint.activateConstraints(constraints)
        targetView.layoutIfNeeded()
        toast.alpha = 0.0
        
        UIView.animateWithDuration(FadeInOutDurationInSeconds, delay: 0.0, options: ToastTransition, animations: { toast.alpha = 1.0 }, completion: { if $0 { toast.startTimer(duration) } } )
        
        return toast
    }
}
