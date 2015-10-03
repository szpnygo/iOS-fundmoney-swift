import UIKit

class FundAction {
    
    /** 基金数据 */
    var dataArray=[MoneyCls]()
    /** 单基金10日数据 */
    var listDataArray=[MoneyCls]()
    
    init(){
        
    }
    
    func loadApiData()->Bool{
        //make api url
        let apiUrl:NSURL!=NSURL(string: "https://api.smemo.info/fund.php");
        
        
        let netError:NSErrorPointer=NSErrorPointer()
        var err:NSError?
        //get data
        var apiData:NSData!
        do {
            apiData = try NSData(contentsOfURL: apiUrl, options: NSDataReadingOptions.DataReadingUncached)
        } catch let error as NSError {
            err = error
            apiData = nil
        };
        
        
        if err != nil{
            return false
        }
        
        if apiData == nil{
            return false
        }

        
        
        var apiJson: AnyObject?
        do {
            apiJson = try NSJSONSerialization.JSONObjectWithData(apiData, options: NSJSONReadingOptions.MutableContainers)
        } catch let error as NSError {
            netError.memory = error
            apiJson = nil
        }
        
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                
                
                let profit=data.objectForKey("fund_profit") as! String
                let fourteenday=data.objectForKey("fund_p_fourteen") as! String
                let sevenday=data.objectForKey("fund_p_seven") as! String
                let twentyeight=data.objectForKey("fund_p_twenty") as! String
                let foundid=data.objectForKey("fundid") as! String
                let gettime=data.objectForKey("fund_time") as! String
                let company=data.objectForKey("company") as! String
                let title=data.objectForKey("fund_title") as! String
                let id=data.objectForKey("id") as! String
                let name=data.objectForKey("name") as! String
                let bean = MoneyCls()
                bean.title=title
                bean.profit=profit
                bean.fourteenday=fourteenday
                bean.twentyeight=twentyeight
                bean.foundid=foundid
                bean.gettime=gettime
                bean.company=company
                bean.sevenday=sevenday
                bean.name=name
                bean.id=id
                bean.fund_p_month=data.objectForKey("fund_p_month") as! String
                bean.fund_p_year=data.objectForKey("fund_p_year") as! String
                bean.fund_type=data.objectForKey("fund_type") as! String
                bean.fund_maketime=data.objectForKey("fund_maketime") as! String
                bean.fund_director=data.objectForKey("fund_director") as! String
                bean.fund_money=data.objectForKey("fund_money") as! String
                bean.fund_time=data.objectForKey("fund_time") as! String
                bean.fund_manager=data.objectForKey("fund_manager") as! String
                dataArray.append(bean)
            }
        }
        return true
    }
    
    
    func getFundDataArray()->[MoneyCls]{
        return dataArray
    }
    
    func getTempDataArray()->[MoneyCls]{
        
        //获取本地资源文件路径
        let path:String=NSBundle.mainBundle().pathForResource("fund", ofType: "json")!
        //转为NSURL
        let nsUrl = NSURL(fileURLWithPath: path)
        
        //获取NSDATA
        let apiData=NSData(contentsOfURL: nsUrl)

        
        let apiJson: AnyObject?=try? NSJSONSerialization.JSONObjectWithData(apiData!, options: NSJSONReadingOptions.MutableContainers)
        
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                
                
                let profit=data.objectForKey("fund_profit") as! String
                let fourteenday=data.objectForKey("fund_p_fourteen") as! String
                let sevenday=data.objectForKey("fund_p_seven") as! String
                let twentyeight=data.objectForKey("fund_p_twenty") as! String
                let foundid=data.objectForKey("fundid") as! String
                let gettime=data.objectForKey("fund_time") as! String
                let company=data.objectForKey("company") as! String
                let title=data.objectForKey("fund_title") as! String
                let id=data.objectForKey("id") as! String
                let name=data.objectForKey("name") as! String
                let bean = MoneyCls()
                bean.title=title
                bean.profit=profit
                bean.fourteenday=fourteenday
                bean.twentyeight=twentyeight
                bean.foundid=foundid
                bean.gettime=gettime
                bean.company=company
                bean.sevenday=sevenday
                bean.name=name
                bean.id=id
                bean.fund_p_month=data.objectForKey("fund_p_month") as! String
                bean.fund_p_year=data.objectForKey("fund_p_year") as! String
                bean.fund_type=data.objectForKey("fund_type") as! String
                bean.fund_maketime=data.objectForKey("fund_maketime") as! String
                bean.fund_director=data.objectForKey("fund_director") as! String
                bean.fund_money=data.objectForKey("fund_money") as! String
                bean.fund_time=data.objectForKey("fund_time") as! String
                bean.fund_manager=data.objectForKey("fund_manager") as! String
                dataArray.append(bean)
            }
        }
        
        return dataArray
    }
    

    
    func loadFundList(index:String)->Bool{
        
        //make api url
        let apiUrl:NSURL!=NSURL(string: "http://api.smemo.info/fund.php/Index/getList?id=\(index)");
        
        var err:NSError?
        
        //get data
        var apiData:NSData!
        do {
            apiData = try NSData(contentsOfURL: apiUrl, options: NSDataReadingOptions.DataReadingUncached)
        } catch let error as NSError {
            err = error
            apiData = nil
        };
        
        if err != nil{
            print(err?.description)
            return false
        }
        if apiData == nil{
            return false
        }

        
        let apiJson: AnyObject?=try? NSJSONSerialization.JSONObjectWithData(apiData, options: NSJSONReadingOptions.MutableContainers)
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                let profit=data.objectForKey("fund_profit") as! String
                let fourteenday=data.objectForKey("fund_p_fourteen") as! String
                let sevenday=data.objectForKey("fund_p_seven") as! String
                let twentyeight=data.objectForKey("fund_p_twenty") as! String
                let foundid=data.objectForKey("fundid") as! String
                let gettime=data.objectForKey("fund_time") as! String
                let company=data.objectForKey("company") as! String
                let title=data.objectForKey("fund_title") as! String
                let id=data.objectForKey("id") as! String
                let name=data.objectForKey("name") as! String
                let bean = MoneyCls()
                bean.title=title
                bean.profit=profit
                bean.fourteenday=fourteenday
                bean.twentyeight=twentyeight
                bean.foundid=foundid
                bean.gettime=gettime
                bean.company=company
                bean.sevenday=sevenday
                bean.name=name
                bean.id=id
                listDataArray.append(bean)
            }
        }
        return true
    }
    
    func getFundListDataArray(index:String)->[MoneyCls]{
        
        //获取本地资源文件路径
        let path:String=NSBundle.mainBundle().pathForResource("list\(index)", ofType: "json")!
        //转为NSURL
        let nsUrl = NSURL(fileURLWithPath: path)
        
        //获取NSDATA
        let apiData=NSData(contentsOfURL: nsUrl)
        
        let apiJson: AnyObject?=try? NSJSONSerialization.JSONObjectWithData(apiData!, options: NSJSONReadingOptions.MutableContainers)
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                let profit=data.objectForKey("fund_profit") as! String
                let fourteenday=data.objectForKey("fund_p_fourteen") as! String
                let sevenday=data.objectForKey("fund_p_seven") as! String
                let twentyeight=data.objectForKey("fund_p_twenty") as! String
                let foundid=data.objectForKey("fundid") as! String
                let gettime=data.objectForKey("fund_time") as! String
                let company=data.objectForKey("company") as! String
                let title=data.objectForKey("fund_title") as! String
                let id=data.objectForKey("id") as! String
                let name=data.objectForKey("name") as! String
                let bean = MoneyCls()
                bean.title=title
                bean.profit=profit
                bean.fourteenday=fourteenday
                bean.twentyeight=twentyeight
                bean.foundid=foundid
                bean.gettime=gettime
                bean.company=company
                bean.sevenday=sevenday
                bean.name=name
                bean.id=id
                listDataArray.append(bean)
            }
        }
        return listDataArray
    }
    
    func getFundListDataArray()->[MoneyCls]{
        return listDataArray
    }
    
    func testFundData(){
        loadApiData()
        print("action test")
        let testArray=getFundDataArray()
        for item in testArray{
            item.toStirng()
        }
    }
    
    func testFundListData(){
        loadFundList("000343")
        print("action test")
        let testArray=getFundListDataArray()
        for item in testArray{
            print(item.toStirng())
        }
    }
    
}
