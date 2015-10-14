//
//  DetailController.swift
//  fundapp
//
//  Created by suzhenpeng on 15/1/18.
//  Copyright (c) 2015年 suzhenpeng. All rights reserved.
//

import UIKit
import Foundation

class DetailController : UIViewController{
    
    var lineChart0:PNLineChart!
    var lineChart1:PNLineChart!
    
    var bean:MoneyCls!
    
    @IBOutlet weak var chartView: UIView!
    var listDataArray=[MoneyCls]()
    var titleList=[String]()
    var dataList=[CGFloat]()
    var profitList=[CGFloat]()
    
    @IBOutlet weak var uiTitle: UILabel!
    
    @IBOutlet weak var fund_profit: UILabel!
    @IBOutlet weak var fund_p_seven: UILabel!
    @IBOutlet weak var fund_p_fourteen: UILabel!
    @IBOutlet weak var fund_p_twenty: UILabel!
    @IBOutlet weak var fund_p_month: UILabel!
    @IBOutlet weak var fund_p_year: UILabel!
    @IBOutlet weak var fund_type: UILabel!
    @IBOutlet weak var fund_maketime: UILabel!
    @IBOutlet weak var fund_manager: UILabel!
    @IBOutlet weak var fund_director: UILabel!
    @IBOutlet weak var fund_money: UILabel!
    @IBOutlet weak var fund_time: UILabel!
    
    @IBOutlet weak var viewChange: UISegmentedControl!
    
    @IBAction func changeChart(sender: AnyObject) {
        switch viewChange.selectedSegmentIndex{
        case 0:
            if (lineChart0 == nil){
                if(lineChart1 != nil){
                    lineChart1.removeFromSuperview()
                }
                initChartView0()
            }else{
                lineChart1.removeFromSuperview()
                chartView.addSubview(lineChart0)
                lineChart0.strokeChart()
            }
            chartTitle.text="年化收益走势"
        case 1:
            if (lineChart1 == nil){
                if(lineChart0 != nil){
                    lineChart0.removeFromSuperview()
                }
                initChartView1()
            }else{
                lineChart0.removeFromSuperview()
                chartView.addSubview(lineChart1)
                lineChart1.strokeChart()
            }
            chartTitle.text="万元收益走势"
        default:
            print("error select")
        }
        
    }
    @IBOutlet weak var chartTitle: UILabel!
    
    
    var waitingDialog:UIAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addGestureBack()
        
        
        waitingDialog=UIAlertView()
        waitingDialog.title="Waiting...."
        waitingDialog.show()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let fundAction=FundAction()
            
            var request:Bool
            
            if fundAction.loadFundList(self.bean.foundid){
                self.listDataArray=fundAction.getFundListDataArray()
                request=true
            }else{
                request=false
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.waitingDialog.dismissWithClickedButtonIndex(0, animated: true)
                if request{
                    self.initData()
                }else{
//                    self.alertNetworkError()
                    self.listDataArray=fundAction.getFundListDataArray(self.bean.foundid)
                    self.initData()
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
    
    
    func initData(){
        var titleListTmp=[String]()
        var dataListTmp=[CGFloat]()
        var profitTmp=[CGFloat]()
        
        //装载数据
        for item in listDataArray{
            let time=item.gettime
            let subIndex=time.startIndex.advancedBy(5)
            titleListTmp.append(item.gettime.substringFromIndex(subIndex))
            dataListTmp.append(CGFloat((item.sevenday as NSString).floatValue))
            profitTmp.append(CGFloat((item.profit as NSString).floatValue))
            
        }
        
        var showNum=9 as Int
        if(UIScreen.mainScreen().bounds.width<350){
            showNum=7
        }
        
        for var index=showNum; index>=0; --index{
            titleList.append(titleListTmp[index])
            dataList.append(dataListTmp[index])
            profitList.append(profitTmp[index])
        }
        
        initViewData()
    
    }
    
    
    func initViewData(){
        uiTitle.text="\(bean.company)-\(bean.name)"
        fund_profit.text=bean.profit
        fund_p_seven.text=bean.sevenday
        fund_p_fourteen.text=bean.fourteenday
        fund_p_twenty.text=bean.twentyeight
        fund_p_month.text=bean.fund_p_month
        fund_p_year.text=bean.fund_p_year
        fund_type.text=bean.fund_type
        fund_manager.text=bean.fund_manager
        fund_director.text=bean.fund_director
        fund_time.text=bean.fund_time
        fund_money.text=bean.fund_money
        fund_director.text=bean.fund_director
        fund_manager.text=bean.fund_manager
        
        let mktime=bean.fund_maketime
        let subIndex=mktime.startIndex.advancedBy(7);
        let subIndex2=mktime.startIndex.advancedBy(2)
        let range=Range<String.Index>(start: subIndex2, end: subIndex)
        fund_maketime.text=bean.fund_maketime.substringWithRange(range)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool){
        initChartView0()
    }
    
    func initChartView0(){
        lineChart0 = PNLineChart(frame: CGRectMake(0, 0, chartView.bounds.width, chartView.bounds.height))
        lineChart0.yLabelFormat = "%1.3f"
        lineChart0.showLabel = true
        lineChart0.backgroundColor = UIColor.clearColor()
        lineChart0.xLabels = titleList
        lineChart0.showCoordinateAxis = true
        
        
        var data01Array: [CGFloat] = dataList
        let data01:PNLineChartData = PNLineChartData()
        data01.color = PNGreenColor
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data01Array[index]
            let item = PNLineChartDataItem()
            item.y = yValue
            return item
        })
        
        lineChart0.chartData = [data01]
        lineChart0.strokeChart()
        
        chartView.addSubview(lineChart0)
    }
    
    func initChartView1(){
        lineChart1 = PNLineChart(frame: CGRectMake(0, 0, chartView.bounds.width, chartView.bounds.height))
        lineChart1.yLabelFormat = "%1.3f"
        lineChart1.showLabel = true
        lineChart1.backgroundColor = UIColor.clearColor()
        lineChart1.xLabels = titleList
        lineChart1.showCoordinateAxis = true
        
        
        var data01Array: [CGFloat] = profitList
        let data01:PNLineChartData = PNLineChartData()
        data01.color = PNGreenColor
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data01Array[index]
            let item = PNLineChartDataItem()
            item.y = yValue
            return item
        })
        
        lineChart1.chartData = [data01]
        lineChart1.strokeChart()
        
        chartView.addSubview(lineChart1)
    }
    
    //添加滑动返回
    func addGestureBack(){
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.view.addGestureRecognizer(panGesture)
    }
    
    /**
    拖动事件
    右滑动返回上个页面
    */
    func handlePanGesture(sender: UIPanGestureRecognizer){
        //得到拖的过程中的xy坐标
        let translation : CGPoint = sender.translationInView(self.view)
        if translation.x > 96 {
            self.modalTransitionStyle=UIModalTransitionStyle.CrossDissolve
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
}
