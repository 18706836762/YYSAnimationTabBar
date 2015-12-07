//
//  MainTabBarViewController.swift
//  studySwift1
//
//  Created by 王园园 on 15/9/18.
//  Copyright (c) 2015年 王园园. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    //let M_Width:CGFloat = UIScreen.mainScreen().bounds.width
    let M_Height:CGFloat = UIScreen.mainScreen().bounds.height
    let tabBarWidth = UIScreen.mainScreen().bounds.width
    let tabBarHeight: CGFloat = 49
    
    var tempItemView = SubItemView()
    var barView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do view setup here.

        let firstVC = HomeViewController()
        let firstNav = UINavigationController(rootViewController: firstVC)
       // firstNav.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "tab_home_icon"), selectedImage: UIImage(named: "tab_home_icon"))
        
        let secVC = FavoritesViewController()
        let secNav = UINavigationController(rootViewController: secVC)
        
        let thiVC = ProfileViewController()
        let thiNav = UINavigationController(rootViewController: thiVC)
        
        let fourVC = PinViewController()
        let  fourNav = (UINavigationController(rootViewController: fourVC))
    
        self.viewControllers = [firstNav,secNav,thiNav,fourNav]
    
        self.initSubViews()
    }
    
    func setbarView(){
    
        self.barView = UIView(frame: CGRectMake(0, M_Height-tabBarHeight, tabBarWidth, tabBarHeight))
        barView!.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        self.view.addSubview(barView!)
    }
    
    func initSubViews(){
        
        self.tabBar.hidden = true
        self.setbarView()
        
        let ItemsDatas: NSArray = [
            ["title":"Home","imageStr":"icon_1","selectimage":"icon_1"],
            ["title":"Faverote","imageStr":"icon_2","selectimage":"icon_2"],
            ["title":"Profile","imageStr":"icon_3","selectimage":"icon_3"],
            ["title":"Pin","imageStr":"icon_4","selectimage":"icon_4"]]
        self .setItemsWithItemDatas(ItemsDatas)
        self.setDefaultSelectIndex(0)
    }
    
    
    func setItemsWithItemDatas(itemArray:NSArray){
        for index in 0...itemArray.count-1{
            let itemDict:NSDictionary = itemArray[index] as! NSDictionary
            let itemWitdh = CGFloat(tabBarWidth/4)
            let oringex = itemWitdh*CGFloat(index)
            
            var item:Item = Item()
            item = item.initWithItemDict(itemDict)
            
            let subItem: SubItemView = SubItemView(frame:  CGRectMake(oringex, 0,itemWitdh , tabBarHeight))
            subItem.item(item)
            subItem.tag = index + 2000
            barView!.addSubview(subItem)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: Selector("ItemTap:"))
            subItem.addGestureRecognizer(tapGesture)
        }
    }
    
    //设置默认选择index
    func setDefaultSelectIndex(index:Int){
        self.selectedIndex = index
        let subItem:SubItemView = barView!.viewWithTag(index+2000) as! SubItemView
        tempItemView = subItem
        subItem.setItemSelected { () -> () in
        }
    }
    
    
    func ItemTap(tap:UITapGestureRecognizer){
        let view = tap.view
        let index = Int(view!.tag) - 2000
        self.ItemSelectIndex(index)
    }
    
    
    func ItemSelectIndex(index:Int){
        self.selectedIndex = index
        let subItem = barView!.viewWithTag(index+2000) as! SubItemView
        if index != (tempItemView.tag-2000){
            // 选中动画
            subItem .setItemSelected({ () -> () in
                //回调恢复动画
                self.tempItemView.setItemNomal()
            })
        }
        tempItemView = subItem
    }
    
}
