//
//  ViewController.swift
//  fundapp
//
//  Created by suzhenpeng on 15/1/18.
//  Copyright (c) 2015年 suzhenpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var fundDataArray=[MoneyCls]()
    
    var sortType:Bool!=true
    var waitingDialog:UIAlertView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableview.dataSource=self
        tableview.delegate=self
        
        waitingDialog=UIAlertView()
        waitingDialog.title="Waiting...."
        
        initData()
        
        let userAction=UserAction()
        userAction.log()
    }
    
    //加载数据
    func initData(){
        waitingDialog.show()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let fundAction=FundAction()
            
            var request:Bool
            
            if fundAction.loadApiData(){
                self.fundDataArray=fundAction.getFundDataArray()
                request=true
            }else{
                request=false
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.waitingDialog.dismissWithClickedButtonIndex(0, animated: true)
                if request{
                    self.tableview.reloadData()
                }else{
//                    self.alertNetworkError()
                    self.fundDataArray=fundAction.getTempDataArray()
                    self.tableview.reloadData()
                }

            })
        })
    }

    //提示网络请求失败
    func alertNetworkError(){
        let alert = UIAlertView()
        alert.title = "警告！"
        alert.message = "网络请求失败，请检查您的网络"
        alert.addButtonWithTitle("确定")
        alert.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //数据条数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return fundDataArray.count
    }
    
    //返回每一条的view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let bean=fundDataArray[indexPath.row] as MoneyCls
        return getTableViewCell(bean)
    }
    
    //组数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //事件点击
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("openinfo", sender: indexPath.row)
    }
    
    //segue数据传递
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondUI=segue.destinationViewController as! DetailController
        secondUI.bean=fundDataArray[sender!.integerValue]
    }
    
    //排序点击事件
    @IBAction func sortBtn(sender: AnyObject) {
        if((sortType) == true){
            sortType=false
            fundDataArray.sortInPlace(MoneyCls.sortFuncAsc)
        }else{
            sortType=true
            fundDataArray.sortInPlace(MoneyCls.sortFuncDesc)
        }
        tableview.reloadData()
    }
    
    //返回cell
    func getTableViewCell(bean:MoneyCls)->UITableViewCell{
        let cell = tableview.dequeueReusableCellWithIdentifier("itemcell")
        let titleLabel=cell!.viewWithTag(1) as! UILabel
        let profit=cell!.viewWithTag(2) as! UILabel
        let myProfitTitle=cell!.viewWithTag(6) as! UILabel
        let myProfit=cell!.viewWithTag(3) as! UILabel
        let seven=cell!.viewWithTag(4) as! UILabel
        let fourteen=cell!.viewWithTag(5) as! UILabel
        
        titleLabel.text="\(bean.company)-\(bean.name)[\(bean.title)]"
        profit.text="\(bean.profit)"
        myProfit.text=""
        myProfitTitle.text=""
        seven.text="\(bean.sevenday)"
        fourteen.text="\(bean.fourteenday)"
        
        return cell!
        
    }
}

