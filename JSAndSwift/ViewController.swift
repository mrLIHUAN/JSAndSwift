//
//  ViewController.swift
//  JSAndSwift
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController,UIWebViewDelegate,JSAndSwiftModdleDelegate {
    
    var webView:UIWebView!

    var jscontext: JSContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(self.webView)
        self.webView.delegate = self
        self.webView.scalesPageToFit = true
        let url = NSBundle.mainBundle().URLForResource("test", withExtension: "html")
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)
    
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        // 初始化model
        let model = JSAndSwiftMiddle()
        model.delegate = self
//        model.controller = self
//        model.jsContext = context
        model.webView = webView
        self.jscontext = model.jsContext
        
        self.jscontext?.setObject(model
            , forKeyedSubscript: "OCModel")
        self.jscontext?.exceptionHandler = { (context,exception) in
            
            print("exception @",exception)
        }
    }
    
    
    //mark: --JSAndSwiftModdleDelegate
    
    func JSCallSwiftWithAlert(Title: String, msg: String) {
        print("\(Title),\(msg)")
    }
    
    func JSCallSwiftWithDict(dict: [String : AnyObject]) {
        print("\(dict)")
    }
    func JSCallSwiftSystem() {
        print("调用系统不带参数")
        
        let jsFunc = self.jscontext?.objectForKeyedSubscript("jsFunc");
        jsFunc?.callWithArguments([])
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

