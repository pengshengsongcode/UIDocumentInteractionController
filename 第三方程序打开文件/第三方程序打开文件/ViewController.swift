//
//  ViewController.swift
//  第三方程序打开文件
//
//  Created by 彭盛凇 on 16/10/20.
//  Copyright © 2016年 huangbaoche. All rights reserved.
//

/*
 Xcode Log bug  真机不会出现问题
 Class PLBuildVersion is implemented in both /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/PrivateFrameworks/AssetsLibraryServices.framework/AssetsLibraryServices (0x1254ec910) and /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/PrivateFrameworks/PhotoLibraryServices.framework/PhotoLibraryServices (0x125316210). One of the two will be used. Which one is undefined.
 
     意思是PhotoLibraryServices.framework和AssetsLibraryServices.framework产生了冲突，系统不知道用哪个
 */

import UIKit

class ViewController: UIViewController {

    //此属性不能过早释放，如果再oc中开发，需要使用strong修饰词
    
    lazy var document: UIDocumentInteractionController = {
       
        let url = Bundle.main.url(forResource: "Steve", withExtension: "pdf")
        
        let vc = UIDocumentInteractionController(url: url!)
        
        vc.delegate = self
        
        return vc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.cyan
        
    }
    
//    1、只出现两个option 无 打印，copy等选项
    @IBAction func doAction1(_ sender: AnyObject) {
        
        document.presentOpenInMenu(from: view.bounds, in: view, animated: true)
    }
    
//    2、iOS 10中执行此代码，出现多个options
    @IBAction func doAction2(_ sender: AnyObject) {
        
        document.presentOptionsMenu(from: view.bounds, in: view, animated: true)

    }
    
//    3、快速阅读
    @IBAction func doAction3(_ sender: AnyObject) {
        
        document.presentPreview(animated: true)
    }
    
}

/*
 
 这个代理方法主要是用来指定UIDocumentInteractionController要显示的视图所在的父视图容器。这样UIDocumentInteractionController才清楚在哪里展示Quick Look预览内容， 我在这里就指定Button所在的UIViewController来做UIDocumentInteractionController的代理对象，并且实现上面的代理方法。在Button的触发方法中添加下面的代码

 */

extension ViewController: UIDocumentInteractionControllerDelegate {

    //快速查看，实现此功能present界面 出现多个options  才会有快速查看，只出现两个option的还是只有两个option
    //如果没有调用此方法，快速阅读方法失效
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}

