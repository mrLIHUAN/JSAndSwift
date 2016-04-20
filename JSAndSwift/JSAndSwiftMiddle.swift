//
//  JSAndSwiftMiddle.swift
//  JSAndSwift
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import JavaScriptCore


/**
 *  @author 李欢, 16-04-19 15:04:17
 *
 *  对外开放的代理
 */
@objc protocol JSAndSwiftModdleDelegate : NSObjectProtocol{
    
    /**
     调用系统Alert
     
     - parameter Title:Title
     - parameter msg:
     */
    optional func JSCallSwiftWithAlert(Title : String, msg: String)
    /**
     JS调用Swift传递参数字典
     
     - parameter dict: 参数字典
     */
    optional func JSCallSwiftWithDict(dict: [String : AnyObject])
    /**
     JS调用系统--不带参数
     */
    optional func JSCallSwiftSystem()
    
}


@objc protocol JavaScriptSwiftDelegate : JSExport{
    
    func showAlert(title: String, msg : String)
    
    func callWithDict(dict: [String :AnyObject])
    
    func callSystem();
    
}

@objc class JSAndSwiftMiddle: NSObject,JavaScriptSwiftDelegate {
    
//    weak var controller : UIViewController?
//    weak var jsContext: JSContext?
    weak var delegate:JSAndSwiftModdleDelegate!
    
    
    func showAlert(title: String, msg: String) {
        if delegate.respondsToSelector(Selector("JSCallSwiftWithAlert:msg:")) {
           self.delegate.JSCallSwiftWithAlert!(title, msg: msg)
        }
    }
    func callWithDict(dict: [String : AnyObject]) {
        if delegate.respondsToSelector(Selector("JSCallSwiftWithDict:")){
            self.delegate.JSCallSwiftWithDict!(dict)
        }
    }
    func callSystem() {
        if delegate.respondsToSelector(Selector("JSCallSwiftSystem")){
            self.delegate.JSCallSwiftSystem!()
        }
    }
    

}
