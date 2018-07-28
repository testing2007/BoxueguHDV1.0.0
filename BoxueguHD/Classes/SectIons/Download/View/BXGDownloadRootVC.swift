//
//  BXGDownloadRootVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

// let CCUserID:String = "78665FEF083498AB";
// let CCAPIKey:String = "w94XthRUAH9ViHEtFecuUKpCS5JuHzXf";

class BXGDownloadRootVC: BXGBaseRootVC{
    lazy var collectionView : UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        let itemWidth:double_t = double_t( (BXGDevice.RelativeScreenWidth) / 2 )
        layout.minimumInteritemSpacing = 0;
        NSLog("itemWidth=%lf", itemWidth);
        //单元格的宽/高 按比例调整
        let itemHeight:double_t = double_t((itemWidth * (250.0+31)/954.0))
        layout.minimumLineSpacing = 25;
        layout.sectionInset = UIEdgeInsetsMake(25, 0, 0, 0)
        layout.itemSize = CGSize(width:itemWidth , height: itemHeight)
        
        let colView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colView.backgroundColor = UIColor.white
        return colView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.installUI()
//        viewModel = BXGDownloadRootViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData();
    }
    
    func loadData() {
        BXGDownloadManager.instance.resetDownloadingModel()
        BXGDownloadManager.instance.resetDownloadedModel()
        self.collectionView.reloadData()
    }
    
    func installUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BXGDownloadRootDownloadedCCell.self,
                                forCellWithReuseIdentifier: BXGDownloadRootDownloadedCCell.description())
        collectionView.register(BXGDownloadRootDownloadingCCell.self,
                                forCellWithReuseIdentifier: BXGDownloadRootDownloadingCCell.description())
        self.view.addSubview(collectionView);
        
        collectionView.snp.makeConstraints { (make) in
//            make.top.equalTo(BXGDevice.NaviBarOffset)
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func downloadedIndex(curIndex:Int) -> Int {
        let isExistDownloadingModel = BXGDownloadManager.instance.isExistDownloadingItem()
        var downloadedIndex:Int = 0
        if(isExistDownloadingModel) {
            downloadedIndex = curIndex-1
        } else {
            downloadedIndex = curIndex
        }
        if(downloadedIndex<0) {
            downloadedIndex = 0
        }
        return downloadedIndex
    }
}

// MARK:- UICollectionViewDelegate
extension BXGDownloadRootVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row==0) {
            //跳转到正在下载列表
            if(BXGDownloadManager.instance.isExistDownloadingItem()) {
                let downloadingVC:BXGDownloadingVC = BXGDownloadingVC()
                self.navigationController?.pushViewController(downloadingVC, animated: true)
            } else {
                if let arrDownloadeModel:[BXGDownloadedCourseModel] = BXGDownloadManager.instance.getDownloadedModel() {
                    let downloadedIndex = self.downloadedIndex(curIndex: indexPath.row)
                    if(downloadedIndex<arrDownloadeModel.count) {
                        let courseModel:BXGDownloadedCourseModel = arrDownloadeModel[downloadedIndex];
                        let downloadedVC:BXGDownloadedVC = BXGDownloadedVC(courseId: courseModel.courseId ?? 0,
                                                                           courseName: courseModel.courseName ?? "");
                        self.navigationController?.pushViewController(downloadedVC, animated: true)
                    }
                }
            }
        } else {
            //跳转已下载列表
            if let arrDownloadeModel:[BXGDownloadedCourseModel] = BXGDownloadManager.instance.getDownloadedModel() {
                let downloadedIndex = self.downloadedIndex(curIndex: indexPath.row)
                if(downloadedIndex<arrDownloadeModel.count) {
                    let courseModel:BXGDownloadedCourseModel = arrDownloadeModel[downloadedIndex];
                    let downloadedVC:BXGDownloadedVC = BXGDownloadedVC(courseId: courseModel.courseId ?? 0,
                                                                       courseName: courseModel.courseName ?? "");
                    self.navigationController?.pushViewController(downloadedVC, animated: true)
                }
            }
        }
    }
}

// MARK:- UICollectionViewDataSource
extension BXGDownloadRootVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var nums:Int = 0;
        if (BXGDownloadManager.instance.getDownloadingModel()) != nil {
            nums += 1;
        }
        if let downloaded:[BXGDownloadedCourseModel] = BXGDownloadManager.instance.getDownloadedModel() {
            nums += downloaded.count
        }
        return nums;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var retCell:UICollectionViewCell;
        if(indexPath.row == 0) {
            if let downloading:[BXGDownloadPersistAPIModel] = BXGDownloadManager.instance.getDownloadingModel() {
                let cell:BXGDownloadRootDownloadingCCell = collectionView.dequeueReusableCell(withReuseIdentifier: BXGDownloadRootDownloadingCCell.description(), for: indexPath) as! BXGDownloadRootDownloadingCCell
                cell.leaveDownloadNumsLabel.text = String(format: "剩余%d个视频", downloading.count) // "剩余1个视频"
                cell.updateContainerConstraint(nIndex:indexPath.row);
                retCell = cell;
            } else {
                let cell:BXGDownloadRootDownloadedCCell = collectionView.dequeueReusableCell(withReuseIdentifier: BXGDownloadRootDownloadedCCell.description(), for: indexPath) as! BXGDownloadRootDownloadedCCell
                if let downloaded:[BXGDownloadedCourseModel] = BXGDownloadManager.instance.getDownloadedModel() {
                    cell.courseNameLabel.text = downloaded[indexPath.row].courseName
                    cell.downloadedVideoNumsAndSizeLabel.text = String(format: "已下载%d | 1.2M", downloaded[indexPath.row].fileInfo?.count ?? 0);
                    cell.installCourseImage(urlString:downloaded[indexPath.row].courseImageURLPath);
                    cell.updateContainerConstraint(nIndex:indexPath.row);
                }
                retCell = cell;
            }
        } else {
            let cell:BXGDownloadRootDownloadedCCell = collectionView.dequeueReusableCell(withReuseIdentifier: BXGDownloadRootDownloadedCCell.description(), for: indexPath) as! BXGDownloadRootDownloadedCCell
            
            let downloadedIndex = self.downloadedIndex(curIndex: indexPath.row)
            
            if let downloaded:[BXGDownloadedCourseModel] = BXGDownloadManager.instance.getDownloadedModel() {
                cell.courseNameLabel.text = downloaded[downloadedIndex].courseName
                cell.downloadedVideoNumsAndSizeLabel.text = String(format: "已下载%d | 1.2M", downloaded[downloadedIndex].fileInfo?.count ?? 0);
                cell.installCourseImage(urlString:downloaded[downloadedIndex].courseImageURLPath);
                cell.updateContainerConstraint(nIndex:indexPath.row);
            }
            
            retCell = cell;
        }
        return retCell;
    }
}


