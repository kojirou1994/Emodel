//
//  SingleFeatureViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class SingleFeatureViewController: UIViewController {
    var number:Int!
    let colorMap=[
        1:UIColor.blackColor(),
        2:UIColor.orangeColor(),
        3:UIColor.blueColor()
    ]
    
    init(number initNumber:Int){
        self.number = initNumber
        super.init(nibName:nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        var numberLabel = UILabel(frame:CGRectMake(self.view.frame.width/2-20,self.view.frame.height-200,100,100))
        //        numberLabel.center = self.view.center
        numberLabel.text = "第\(number)页"
        numberLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(numberLabel)
        self.view.backgroundColor = colorMap[number]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
