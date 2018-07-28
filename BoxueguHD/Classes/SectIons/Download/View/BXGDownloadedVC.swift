//
//  BXGDownloadedVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

class BXGDownloadedVC: UIViewController {

    var indexVC:BXGDownloadedIndexVC?
    var detailVC:BXGDownloadedDetailVC?
    var indexModels:[BXGDownloadPersistAPIModel]?
    var bEdit:Bool = false
    
    var courseId:Int32
    var courseName:String
    
    init(courseId:Int32, courseName:String) {
        self.courseId = courseId
        self.courseName = courseName
        super.init(nibName: nil, bundle: nil)
        self.title = self.courseName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() -> Void {
        BXGDownloadManager.instance.resetDownloadedCourseIndexModels();
        indexModels = BXGDownloadManager.instance.getDownloadedCourseIndexModelsByCourseId(courseId: courseId);
        if let indexDatas = indexModels {
            self.indexVC?.loadData(indexDatas: indexDatas);
//            let data = self.indexVC?.indexOfData();
//            self.detailVC?.loadData(moduleData: data);
        } else {
            //空白页
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        self.view.backgroundColor = UIColor.blue;
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightBarButton)
    
        let indexVC:BXGDownloadedIndexVC = BXGDownloadedIndexVC()
        indexVC.delegate = self;
        let detailVC:BXGDownloadedDetailVC = BXGDownloadedDetailVC();
        detailVC.delegate = self;
        //            detailVC.view.backgroundColor = UIColor.purple;
        self.addChildViewController(indexVC);
        self.view.addSubview(indexVC.view);
        self.addChildViewController(detailVC);
        self.view.addSubview(detailVC.view);
        
        indexVC.view.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.width.equalTo(270);
        }
        
        detailVC.view.snp.makeConstraints { (make) in
            make.left.equalTo(indexVC.view.snp.right).offset(0);
            make.right.equalTo(0);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
        }
        
        self.indexVC = indexVC;
        self.detailVC = detailVC;
    }
    
    
    lazy var rightBarButton : UIButton = {
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setTitle("编辑", for: UIControlState.normal)
        btn.setTitleColor(UIColor.hexColor(hex: 0x34495E), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.pingFangSCMedium(withSize: 15)
        btn.addTarget(self, action: #selector(BXGDownloadedVC.onClickRightEditBtn), for: UIControlEvents.touchUpInside)
        return btn;
    }()
    
    @objc func onClickRightEditBtn() {
        self.bEdit = !self.bEdit
        self.detailVC?.bEdit = self.bEdit
        NSLog("onClickRightEditBtn")
    }
    
    @objc func onBack() {
        print("onBack");
        self.navigationController?.popViewController(animated: true)
        //        self.navigationController?.popViewController(animated: true)
        //        self.navigationController?.navigationBar.isHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension BXGDownloadedVC : BXGDownloadIndexVCDelegate {
    func changeIndexToDetail(courseId: Int32, phaseId: Int32, moduleId: Int32, moduleName: String) {
        self.detailVC?.loadData(courseId: courseId, phaseId: phaseId, moduleId: moduleId, moduleName: moduleName, bEdit:bEdit)
    }
    
//    func chan(pagekey: String) {
//        print("indexPageKey is called")
//        //        //新
//        //        let detailVC:BXGDownloadedDetailVC = BXGDownloadedDetailVC();
//        //        if(self.detailVC?.view.backgroundColor == UIColor.green) {
//        //            detailVC.view.backgroundColor = UIColor.purple;
//        //        } else {
//        //            detailVC.view.backgroundColor = UIColor.green;
//        //        }
//        //        //旧
//        //        let detailNav = self.detailVC?.navigationController;
//        //        detailNav?.setViewControllers([detailVC], animated:false);
//        //
//        //        //保存新的
//        //        self.detailVC = detailVC;
//    }
}

extension BXGDownloadedVC : BXGDownloadedDetailVCDelegate {
    func curDetailNoData()-> Void {
        self.loadData();
    }
}

