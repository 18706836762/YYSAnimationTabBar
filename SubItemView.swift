//
//  SubItemView.swift
//  studySwift1
//
//  Created by 王园园 on 15/12/3.
//  Copyright © 2015年 王园园. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var title:NSString = ""
    var imageStr:NSString = ""
    var imageStr_s:NSString = ""
    func initWithItemDict(ItemDict:NSDictionary)->Self{
        title = ItemDict["title"] as! String
        imageStr = ItemDict["imageStr"] as! String
        imageStr_s = ItemDict["selectimage"] as! String
        return self
    }
}


class SubItemView: UIView {
    
    var item:Item?
    var iconImg:UIImageView?
    var titleLable:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(frame: CGRectMake(self.frame.width/2-15, 3, 30 , 30))
        imageView.userInteractionEnabled = false
        self.addSubview(imageView)
        
        let lable = UILabel(frame: CGRectMake(0, 35, frame.width, 15))
        lable.textColor = UIColor.whiteColor()
        lable.font = UIFont.systemFontOfSize(11.0)
        lable.textAlignment = NSTextAlignment.Center
        lable.userInteractionEnabled = false
        self.addSubview(lable)
        
        self.iconImg = imageView
        self.titleLable = lable
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func item(itemDict:Item){
        self.item = itemDict
        self.titleLable?.text = itemDict.title as String
        self.iconImg?.image = UIImage(named: itemDict.imageStr as String)
    }
    
    //选中动画
    func setItemSelected(complete:()->()){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            ////
            //缩放动画
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = NSNumber(float: 1.0)
            scaleAnimation.toValue = NSNumber(float: 2.0)
            scaleAnimation.duration = 0.5
            scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            //透明度变化
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = NSNumber(float: 1.0)
            opacityAnimation.toValue = NSNumber(float: 0.1)
            //位置移动
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(CGPoint: (self.titleLable?.layer.position)!)
            var toPoint = self.titleLable?.layer.position
            toPoint!.y -= 80;
            animation.toValue = NSValue(CGPoint:toPoint!)
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 0.5
            animationGroup.autoreverses = false//是否重播，原动画的倒播
            animationGroup.repeatCount = 0;
            animationGroup.animations = NSArray(objects: opacityAnimation,scaleAnimation,animation) as? [CAAnimation]
            self.titleLable?.layer.addAnimation(animationGroup, forKey: "animationGroup")
            ////
        }) { (ture) -> Void in
            //////
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.iconImg?.transform = CGAffineTransformMakeScale(4/3, 4/3)
                self.iconImg?.frame = CGRectMake(self.frame.size.width/2-20, 3.7, 40, 40)
            }) { (ture) -> Void in
                self.titleLable?.alpha = 0
                self.titleLable?.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 15)
            }
            /////
        }
        
        complete()
    }
    
    
    //未选中恢复动画
    func setItemNomal(){
        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.iconImg?.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.iconImg?.frame = CGRectMake(self.frame.size.width/2-15, 3, 30, 30)
            self.titleLable?.alpha = 1.0
            self.titleLable?.frame = CGRectMake(0, 32, self.frame.size.width, 15)
        }) { (Bool) -> Void in
                
        }
    }
    
}
