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


/**
 *  @author 李欢, 16-04-20 11:04:48
 *
 *  这里面放的都是供H5调用原生的方法，每个方法都有不同的参数
 */
@objc protocol JavaScriptSwiftDelegate : JSExport{
    
    
    /**
     当H5调用原生的Alert框时，在点击事件中需要写--OCModel.showAlertMsg('js title', 'js message')
     
     - parameter title: js title
     - parameter msg:   js message
     */
    func showAlert(title: String, msg : String)
    
    /**
     当H5调用此方法传字典参数----OCModel.callWithDict({'name': 'testname', 'age': 10, 'height': 170})
     
     - parameter dict: 参数字典
     */
    func callWithDict(dict: [String :AnyObject])
    
    
    /**
     当H5调用此方法不传递参数----OCModel.callSystem()
     */
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
