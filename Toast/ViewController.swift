//
//  ViewController.swift
//  Toast
//
//  Created by Naohiro Hamada on 2015/12/28.
//  Copyright © 2015年 HaNoHito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// Toastに表示するテキスト
    @IBOutlet weak var toastTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// 標準設定でToastの表示を行う
    @IBAction func showBasicToast(sender: UIButton) {
        guard let textForToast = toastTextField.text else {
            guard let _ = ToastView.showText("Please input text!") else {
                print("Failed to create toast")
                return
            }
            return
        }
        guard let _ = ToastView.showText(!textForToast.isEmpty ? textForToast : "Please input text!") else {
            print("Failed to create toast")
            return
        }
    }
    
    /// 表示時間Longの設定でToastの表示を行う
    ///
    /// その他の設定は、標準の設定
    @IBAction func showLongDurationToast(sender: UIButton) {
        guard let textForToast = toastTextField.text else {
            guard let _ = ToastView.showText("Please input text!") else {
                print("Failed to create toast")
                return
            }
            return
        }
        guard let _ = ToastView.showText(!textForToast.isEmpty ? textForToast : "Please input text!", duration: .Long) else {
            print("Failed to create toast")
            return
        }
    }
    @IBAction func onTopButtonTapped(sender: UIButton) {
        showToastWithImage(.Top)
    }
    @IBAction func onBottomButtonTapped(sender: UIButton) {
        showToastWithImage(.Bottom)
    }
    @IBAction func onLeftButtonTapped(sender: UIButton) {
        showToastWithImage(.Left)
    }
    @IBAction func onRightButtonTapped(sender: UIButton) {
        showToastWithImage(.Right)
    }
    
    /// MARK: - helper
    func showToastWithImage(imagePostion: ToastImagePosition) {
        guard let image = UIImage(named: "SampleImage") else {
            print("Failed to load image data")
            return
        }
        guard let textForToast = toastTextField.text else {
            guard let _ = ToastView.showText("Please input text!", image: image, imagePosition: imagePostion) else {
                print("Failed to create toast")
                return
            }
            return
        }
        guard let _ = ToastView.showText(!textForToast.isEmpty ? textForToast : "Please input text!", image: image, imagePosition: imagePostion) else {
            print("Failed to create toast")
            return
        }
    }
    
}

