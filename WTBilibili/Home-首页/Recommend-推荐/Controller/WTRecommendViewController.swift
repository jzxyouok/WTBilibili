//
//  WTRecommendViewController.swift
//  WTBilibili
//
//  Created by 无头骑士 GJ on 16/5/3.
//  Copyright © 2016年 无头骑士 GJ. All rights reserved.
//  推荐控制器

import UIKit

private let recommendCell = "recommendCell"

class WTRecommendViewController: UITableViewController
{
    // MARK: 控件
    /// headerView
    private var headerView = WTRecommendBannerHeaderView()
    
    // MARK: 系统回调函数
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 1、设置UI
        setupUI()
        
        // 2、加载数据
        loadData()
    }
}

// MARK: - 自定义函数
extension WTRecommendViewController
{
    // MARK: 设置UI
    private func setupUI()
    {
        // 0、tableView基本属性
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: recommendCell)
        
        // 1、设置tableView的headerView
        headerView.frame = CGRect(x: 0, y: 0, width: WTScreenWidth, height: recommendBannerHeaderViewHeight)
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        
    }
    
    // MARK: 加载数据
    private func loadData()
    {
        // 1、加载headerView的数据
        loadHeaderViewData()
        
        // 2、加载tableView的数据
        loadTableViewData()
    }
}

// MARK: - 网络请求
extension WTRecommendViewController
{
    // MARK: 加载headerView的数据
    private func loadHeaderViewData()
    {
        NetworkTools.shareInstance.loadHomeRecommendBanner { (result, error) in
            // 1.错误校验
            if error != nil
            {
                print(error)
                return
            }
            
            // 2.获取结果
            var recommendBannerItems = [WTRecommendBannerItem]()
            for itemDict in result!
            {
                recommendBannerItems.append(WTRecommendBannerItem(dict: itemDict))
            }
            
            // 3、刷新数据
            self.headerView.recommendbannerItems = recommendBannerItems
        }
    }
    
    // MARK: 加载tableView的数据
    private func loadTableViewData()
    {
        
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension WTRecommendViewController
{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(recommendCell)!
        
        
        return cell
    }
}

// MARK: - WTRecommendBannerHeaderViewDelegate
extension WTRecommendViewController: WTRecommendBannerHeaderViewDelegate
{
    func headerView(headerView: WTRecommendBannerHeaderView, value: String)
    {
        if value.matchesAllNumber()   // 数字,打开视频页面
        { 
            print("数字")
        }
        else                                                        // http请求,打开webView
        {
            print("url")
        }
    }
}
