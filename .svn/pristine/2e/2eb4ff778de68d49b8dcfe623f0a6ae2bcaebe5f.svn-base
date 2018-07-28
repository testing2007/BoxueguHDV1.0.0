//
//  BXGCourseDetailVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/13.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit


class BXGPhaseCCell: UICollectionViewCell {
    
//    couldTryLearn (integer, optional): 该模块是否可以试学：0-不能，1-能 ,
//    hasApply (integer, optional): 学员是否已经报名该课程：0-没有报名，1-已报名 ,
//    id (integer): 模块或阶段作业id ,
//    moduleProgress (string): 模块进度（百分比，不带‘%’号） ,
//    moduleStatus (integer): 学员模块状态：-1未开始、0进行中、1已完成 ,
//    moduleVideoProgress (string): 模块视频进度（百分比，不带‘%’号） ,
//    name (string): 模块或阶段作业名称 ,
//    phaseHomeworkStatus (integer): 学员阶段作业状态：-2未开始、-1未通过、0待批阅、1已通过 ,
//    status (integer): 学员模块或阶段作业右上角显示状态：-1未开始、0进行中、1已完成 ,
//    type (integer): 该封装类型：0模块；1阶段作业
    
    public var isLock: Bool = false
    

    func installData(moduleModel fromModel: BXGCourseModuleModel?,isLock fromIsLock: Bool) {
        
        moduleModel = fromModel
        isLock = fromIsLock
        
        if let moduleModel = moduleModel {
            // 过滤阶段作业 type 0 为模块 1 为作业
            
            headerTitleLb.text = ""
            if(moduleModel.type == 0) {
                headerTitleLb.text = "课程学习"
            }else if moduleModel.type == 1 {
                headerTitleLb.text = "阶段作业"
            }
            
            if(fromIsLock) {
                headerTitleLb.textColor = UIColor.hexColor(hex: 0x9AABB8)
                detailTitleLb.textColor = UIColor.hexColor(hex: 0x9AABB8)
            }else {
                headerTitleLb.textColor = UIColor.hexColor(hex: 0x34495E)
                detailTitleLb.textColor = UIColor.hexColor(hex: 0x34495E)
            }
            
            // done EAEFFD
            // doing FFE6E4
            // none EFF3F5
            headerView.backgroundColor = UIColor.hexColor(hex: 0xEFF3F5)
            headerTitleStateLb.text = ""
            headerTitleStateLb.isHidden = true
            
            
            self.headerTitleStateLb.text = ""
            
            if(moduleModel.status == 0) {
                self.headerView.backgroundColor = UIColor.hexColor(hex: 0xFFE6E4)
                headerTitleStateLb.text = "进行中"
                headerTitleStateLb.isHidden = false
                headerTitleStateLb.textColor = UIColor.hexColor(hex: 0xFC5A4F)
                headerTitleStateLb.layer.borderColor = UIColor.hexColor(hex: 0xFC5A4F).cgColor
                
                
            }else if moduleModel.status == 1 {
                self.headerView.backgroundColor = UIColor.hexColor(hex: 0xEAEFFD)
                headerTitleStateLb.text = "已学完"
                headerTitleStateLb.isHidden = false
                
                headerTitleStateLb.textColor = UIColor.hexColor(hex: 0x466DE2)
                headerTitleStateLb.layer.borderColor = UIColor.hexColor(hex: 0x466DE2).cgColor
            }
            
            if(isLock) {
                headerView.backgroundColor = UIColor.hexColor(hex: 0xEFF3F5)
                headerTitleStateLb.textColor = UIColor.hexColor(hex: 0xCCD2D4)
                headerTitleStateLb.layer.borderColor = UIColor.hexColor(hex: 0xCCD2D4).cgColor
            }
            
            

            
            detailTitleLb.text = moduleModel.name
            
            //                lb.text = "本章进度：100%"
            //                lb.font = UIFont.pingFangSCRegular(withSize: 12)
            //                lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
            //                return lb
            //            }()
            //
            //            lazy var detailVideoProgressLb: UILabel = {
            //                let lb = UILabel()
            //                lb.text = "视频进度：100%"
            
            
            
            if(moduleModel.type == 0) {
                detailVideoProgressLb.isHidden = false
                detailChapterProgressLb.isHidden = false
                let moduleVideoProgress = moduleModel.moduleVideoProgress ?? "0.00"
                let moduleProgress = moduleModel.moduleProgress ?? "0.00"
                detailVideoProgressLb.text = "视频进度：\(moduleVideoProgress)%"
                detailChapterProgressLb.text = "模块进度：\(moduleProgress)%"
            }else if moduleModel.type == 1 {
                detailVideoProgressLb.isHidden = true
                detailChapterProgressLb.text = "目前暂不支持阶段作业"
            }
            
            
            
        }else {
            self.headerView.backgroundColor = UIColor.hexColor(hex: 0xEFF3F5)
            headerTitleLb.text = ""
            headerTitleStateLb.isHidden = true
            
            detailTitleLb.text = ""
            detailVideoProgressLb.text = "视频进度：\("0.00")%"
            detailChapterProgressLb.text = "模块进度：\("0.00")%"
        }
    }
    
    public var moduleModel: BXGCourseModuleModel?
    
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 34))
        view.backgroundColor = UIColor.hexColor(hex: 0xEAEFFD)
        return view
    }()
    
    lazy var insideView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.hexColor(hex: 0xDCE3E8).cgColor
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
//        view.layer.borderWidth = 0.7
//        view.layer.borderColor = UIColor.hexColor(hex: 0xDCE3E8).cgColor
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor.white
        
        
        view.layer.shadowColor = UIColor.hexColor(hex: 0xDCE3E8).cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize(width: 2, height: 6)
//        box-shadow: 0 4px 13px 0
        return view
    }()
    
    lazy var headerTitleLb: UILabel = {
        let lb = UILabel()
//        font-family: PingFangSC-Regular;
//        font-size: 26px;
//        color: #34495E;
        
        lb.text = "课程学习"
        lb.font = UIFont.pingFangSCRegular(withSize: 13)
        lb.textColor = UIColor.hexColor(hex: 0x34495e)
        return lb
    }()
    
    lazy var headerTitleStateLb: UILabel = {
        let lb = UILabel()
        lb.text = "已学完"
        
//        font-family: PingFangSC-Regular;
//        font-size: 24px;
//        color: #466DE2;
//        letter-spacing: 0;
//        line-height: 24px;
        
        lb.font = UIFont.pingFangSCRegular(withSize: 12)
        lb.textColor = UIColor.hexColor(hex: 0x466DE2)
        lb.layer.borderColor = lb.textColor.cgColor
        lb.layer.borderWidth = 0.7
        lb.layer.cornerRadius = 2
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var detailView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var detailTitleLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        
//        font-family: PingFangSC-Regular;
//        font-size: 26px;
//        color: #34495E;
//        letter-spacing: 0;
//        line-height: 24px;
        
        lb.text = "1-1 HTML／HTML5"
        lb.font = UIFont.pingFangSCRegular(withSize: 13)
        lb.textColor = UIColor.hexColor(hex: 0x34495E)
        return lb
    }()
    
    lazy var detailChapterProgressLb: UILabel = {
        
//        font-family: PingFangSC-Regular;
//        font-size: 24px;
//        color: #9AABB8;
//        letter-spacing: 0;
//        line-height: 24px;
        
        let lb = UILabel()
        lb.text = "本章进度：100%"
        lb.font = UIFont.pingFangSCRegular(withSize: 12)
        lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
        return lb
    }()
    
    lazy var detailVideoProgressLb: UILabel = {
        let lb = UILabel()
        lb.text = "视频进度：100%"
        lb.font = UIFont.pingFangSCRegular(withSize: 12)
        lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        


        installUI()
        installLayout()
    }
    
    func installUI() {
        
        contentView.addSubview(shadowView)
        contentView.addSubview(insideView)
        
        insideView.addSubview(headerView)
        headerView.addSubview(headerTitleLb)
        headerView.addSubview(headerTitleStateLb)
        
        insideView.addSubview(detailView)
        detailView.addSubview(detailTitleLb)
        detailView.addSubview(detailChapterProgressLb)
        detailView.addSubview(detailVideoProgressLb)
        
    }
    
    func installLayout() {
        headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(34)
        }
        
        headerTitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        headerTitleStateLb.sizeToFit()
        headerTitleStateLb.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(headerTitleStateLb.bounds.size.width + 8)
            make.centerY.equalToSuperview()
        }
        
        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        detailTitleLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(10)
        }
        
        detailChapterProgressLb.snp.makeConstraints { (make) in
            make.top.equalTo(detailTitleLb.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(10)
        }
        
        detailVideoProgressLb.snp.makeConstraints { (make) in
            make.top.equalTo(detailChapterProgressLb.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(10)
        }
        
        shadowView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        insideView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProgressView: UIView {
    
    var progressModel: BXGCourseProgressModel? {
        didSet {
            if let progressModel = progressModel {
                
                courseTitleLb.text = progressModel.courseName ?? " "
                let dayHasStudy = progressModel.dayHasStudy ?? "0"
                dayHasStudyLb.text = "学习天数：\(dayHasStudy)天"
                
                let dayLeftForService = progressModel.dayLeftForService ?? "0"
                dayLeftForServiceLb.text = "剩余服务时间：\(dayLeftForService)天"
                
                let courseLearningProgress = progressModel.courseLearningProgress ?? "0.00"
                courseLearningProgressLb.text = "课程学习进度：\(courseLearningProgress)%"
                
                installProgressBar(phaseDiagramList: progressModel.phaseDiagramList)
                
            }
        }
    }
    
    func installProgressBar(phaseDiagramList: [BXGCoursePhaseProgressModel]?) {
        if let phaseDiagramList = phaseDiagramList {
            // 加载
            
            
            // 已存在就卸载
            if let pBar = progressBar {
                pBar.removeFromSuperview()
                progressBar = nil
            }
            
            
            
            progressBar = ProgressBar(phaseProgressList: phaseDiagramList)
            
            if let pBar = progressBar {
                addSubview(pBar)
                pBar.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(courseTitleLb.snp.bottom).offset(20)
                    make.height.equalTo(93)
                }
                
                dayHasStudyLb.snp.makeConstraints { (make) in
                    make.left.equalTo(courseTitleLb)
                    make.top.equalTo(courseTitleLb.snp.bottom).offset(2)
                }
            }
            

        }else {
            // 卸载
            if let pBar = progressBar {
                pBar.removeFromSuperview()
                progressBar = nil
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installUI()
        installData()
    }
    

    
    var progressBar: ProgressBar?
    
    lazy var courseTitleLb: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.pingFangSCRegular(withSize: 17)
        lb.textColor = UIColor.hexColor(hex: 0x34495E)
        lb.text = "前端与移动开发在线就业班"
        return lb
    }()
    
    lazy var dayHasStudyLb: UILabel = {
        let lb = UILabel()
        lb.text = "学习天数：156天"
        lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
        lb.font = UIFont.pingFangSCRegular(withSize: 13)
        return lb
    }()
    
    lazy var dayLeftForServiceLb: UILabel = {
        let lb = UILabel()
        lb.text = "剩余服务时间：209天"
        lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
        lb.font = UIFont.pingFangSCRegular(withSize: 13)
        return lb
    }()
    
    lazy var courseLearningProgressLb: UILabel = {
        let lb = UILabel()
        lb.text = "课程学习进度：0.00%"
        lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
        lb.font = UIFont.pingFangSCRegular(withSize: 13)
        return lb
    }()
    
    func installData() {

    }
    
    func installUI() {
        addSubview(courseTitleLb)
        
        
        addSubview(dayHasStudyLb)
        addSubview(dayLeftForServiceLb)
        addSubview(courseLearningProgressLb)
        
        let spView1 = UIView()
        let spView2 = UIView()
        let spView3 = UIView()
        
        addSubview(spView1)
        addSubview(spView2)
        addSubview(spView3)
        
        courseTitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(21)
            make.right.equalToSuperview().offset(-25)
        }
        
        spView1.backgroundColor = UIColor.hexColor(hex: 0xcccccc)
        spView1.snp.makeConstraints { (make) in
            make.left.equalTo(dayHasStudyLb.snp.right).offset(10)
            make.centerY.equalTo(dayHasStudyLb)
            make.width.equalTo(1)
            make.height.equalTo(10)
        }
        
        dayLeftForServiceLb.snp.makeConstraints { (make) in
            make.left.equalTo(spView1).offset(10)
            make.top.equalTo(courseTitleLb.snp.bottom).offset(2)
        }
        spView2.backgroundColor = UIColor.hexColor(hex: 0xcccccc)
        spView2.snp.makeConstraints { (make) in
            make.left.equalTo(dayLeftForServiceLb.snp.right).offset(10)
            make.centerY.equalTo(dayLeftForServiceLb)
            make.width.equalTo(1)
            make.height.equalTo(10)
        }
        
        courseLearningProgressLb.snp.makeConstraints { (make) in
            make.left.equalTo(spView2).offset(10)
            make.top.equalTo(courseTitleLb.snp.bottom).offset(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProgressBar: UIScrollView {
    
    
    
    
    class lineView: UIView {
        
    }
    
    class CycleVIew: UIView {
        
    }
    
//    var contentView: ContentView?
    
    init(phaseProgressList: [BXGCoursePhaseProgressModel]) {
        super.init(frame: CGRect.zero)
        
        let contentView = ContentView(phaseProgressList: phaseProgressList)
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView.bounds.size.width)
            make.height.equalTo(contentView.bounds.size.height)
            make.left.right.top.bottom.equalToSuperview()
        }
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class ContentView: UIView {
        
        
        let phaseProgressList: [BXGCoursePhaseProgressModel]
        
        init(phaseProgressList from: [BXGCoursePhaseProgressModel]) {
            phaseProgressList = from
            super.init(frame: CGRect.zero)
            
            let array = phaseProgressList
            //            let array = [2,2,2,1,0,0,0,0,2,2,2,1,0,0,0,0]
            //            let array2 = ["开始","阶段1","阶段1","阶段1","阶段1","阶段1","阶段1","阶段1","开始","阶段1","阶段1","阶段1","阶段1","阶段1","阶段1","阶段1"]
            let lineWidth = CGFloat(150)
            let lineHeight = CGFloat(1)
            let leftOffset = CGFloat(50)
            let rightOffset = CGFloat(50)
            let tagBottomOffset = CGFloat(26)
            
            
            for (index, value) in array.enumerated() {
                
                let x = CGFloat(CGFloat(index) * lineWidth) + leftOffset
                let y = CGFloat(30.0)
                
                
                if(index != array.count - 1) {
                    let view = UIView(frame: CGRect(x: x, y: y, width: lineWidth, height: lineHeight))
                    view.backgroundColor = UIColor.hexColor(hex: 0xE5EDF2)
                    addSubview(view)
                }
                
                var imageName = "coursedetail_progess_none"
                var hex = 0xD7E2EA
                var textHex = 0x9AABB8
                
                if let phaseStatus = value.stuPhaseStatus {
                    
                    if phaseStatus == 1 {
                        imageName = "coursedetail_progess_ing"
                        hex = 0xFB564A
                        textHex = 0xFB564A
                        
                    }else if phaseStatus == 2 {
                        imageName = "coursedetail_progess_done"
                        hex = 0x466DE2
                        textHex = 0x466DE2
                    }
                    
                }
                
                
                let imgV = UIImageView(image: UIImage(named: imageName))
                imgV.center = CGPoint(x: x, y: y)
                addSubview(imgV)
                
                let label = UILabel()
                label.textColor = UIColor.hexColor(hex: textHex)
                label.font = UIFont.pingFangSCRegular(withSize: 13)
                
                label.text = value.phaseName
                if(label.text != "开始") {
                    label.layer.borderColor = UIColor.hexColor(hex: hex).cgColor
                    label.layer.borderWidth = 0.7
                }
                
                label.sizeToFit()
                label.bounds = CGRect(x: 0, y: 0, width: label.bounds.size.width + 12, height: label.bounds.size.height)
                label.textAlignment = .center
                label.center = CGPoint(x: x, y: y + tagBottomOffset)
                addSubview(label)
                
                self.bounds = CGRect(x: 0, y: 0, width: imgV.center.x + rightOffset, height: 93)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}



class BXGCourseDetailVC: UIViewController {
    
//    var courseId: Int
//    init(courseId from: Int) {
//        courseId = from
//        super.init(nibName: nil, bundle: nil)
//
//    }
    var courseModel: BXGStudyCourseModel
    
    init(courseModel from: BXGStudyCourseModel) {
        courseModel = from
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var viewModel: BXGCourseViewModel = {
        return BXGCourseViewModel()
    }()
    
    lazy var progressView: ProgressView = {
        let view = ProgressView()
//        view.backgroundColor = UIColor.randomColor()
        return view
    }()
    
    lazy var phaseView: UICollectionView = {
        let layout = UICollectionViewLeftAlignedLayout()
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 25
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25)
        view.backgroundColor = UIColor.white
        view.register(BXGPhaseCCell.self, forCellWithReuseIdentifier: "BXGPhaseCCell")
        view.register(GroupSection.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "GroupSection")
        view.contentInset = UIEdgeInsetsMake(179, 0, 25, 0)
        
        
        return view
    }()
    
    func toCoursePlayer(courseModel: BXGStudyCourseModel, phaseModel: BXGCoursePhaseModel, moduleModel: BXGCourseModuleModel) {
        
        guard let isUnlock = phaseModel.phaseLockStatus, isUnlock == 1 else {
            // 未解锁
            BXGHUDTool.showHUD(string: "请到web端通过阶段作业后观看视频")
            return
        }
        
        guard let type = moduleModel.type, type == 0 else {
            // 是阶段作业
            BXGHUDTool.showHUD(string: "请到web端通过阶段作业后观看视频")
            return
        }
        let outline = BXGCoursePlayerVC(courseModel: courseModel, phaseModel: phaseModel, moduleModel: moduleModel)
        navigationController?.pushViewController(outline, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        installUI()
        if let courseId = courseModel.id {
            self.viewModel.requestQuerySDAndAggregation(courseId: courseId) { [unowned self] (success, mess) in
                self.progressView.progressModel = self.viewModel.courseProgressModel
            }
            self.viewModel.requestStudyRoute(courseId: courseId) { (succeed, message) in
                self.phaseView.reloadData()
            }
        }
    }
    
    func installUI() {
        view.addSubview(phaseView)
        phaseView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            //            make.top.equalTo(bottomSPView.snp.bottom)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        
        phaseView.addSubview(progressView)
        
        phaseView.delegate = self
        phaseView.dataSource = self
    
        
        let topSPView = UIView()
        topSPView.backgroundColor = UIColor.hexColor(hex: 0xeff3f5)
        let bottomSPView = UIView()
        bottomSPView.backgroundColor = UIColor.hexColor(hex: 0xeff3f5)
        phaseView.addSubview(topSPView)
        phaseView.addSubview(bottomSPView)
        topSPView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(phaseView.snp.top).offset(-179)
            make.height.equalTo(10)
        }

        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(topSPView.snp.bottom)
            make.height.equalTo(159)
        }
        
        bottomSPView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom)
            make.height.equalTo(10)
        }
        


    }
    
    func clickSectionHeader(indexPath: IndexPath) {
        
        if(viewModel.set.contains(indexPath.section)) {
            
            viewModel.set.remove(indexPath.section)
        }else {
            
            viewModel.set.insert(indexPath.section)
        }
        phaseView.reloadSections(IndexSet(integer: indexPath.section))
    }
    
}

class GroupSection: UICollectionReusableView {
    
    var closure: (() -> Void)?
    
    lazy var headerTitleFlodStateImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "coursedetail_arrow_left_enable"))
        return imgV
    }()
    
    func setState(title:String?, isEnable: Bool, isOpen: Bool) {
        
        if let title = title {
            titleLb.text = title
        }else {
            titleLb.text = " "
        }
        
        if(isEnable) {
            titleLb.textColor = UIColor.hexColor(hex: 0x34495E)
            sectionLockImgV.isHidden = true

            titleLb.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(25)
            }
            
            if(isOpen) {
                headerTitleFlodStateImgV.image = UIImage(named: "coursedetail_arrow_down_enable")
                self.headerTitleFlodStateImgV.transform = CGAffineTransform.identity
            }else {
                headerTitleFlodStateImgV.image = UIImage(named: "coursedetail_arrow_down_enable")
                self.headerTitleFlodStateImgV.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
            }
        }else {
            titleLb.textColor = UIColor.hexColor(hex: 0x9AABB8)
            sectionLockImgV.isHidden = false
            
            titleLb.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(45)
            }
            
            if(isOpen) {
                
                headerTitleFlodStateImgV.image = UIImage(named: "coursedetail_arrow_down_disable")
                UIView.animate(withDuration: 10) {
                    self.headerTitleFlodStateImgV.transform = CGAffineTransform.identity
                }
                
                
            }else {
                headerTitleFlodStateImgV.image = UIImage(named: "coursedetail_arrow_down_disable")
                self.headerTitleFlodStateImgV.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
            }
        }
    }
    
    lazy var sectionLockImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "coursedetail_sectionlock")!)
        return imgV
    }()
    
    lazy var titleLb: UILabel = {
        
//        font-family: PingFangSC-Regular;
//        font-size: 30px;
//        color: #34495E;
        
        let lb = UILabel()
        lb.font = UIFont.pingFangSCRegular(withSize: 15)
        lb.textColor = UIColor.hexColor(hex: 0x34495e)
        lb.text = "阶段1:前端开发基础"
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLb)
        addSubview(headerTitleFlodStateImgV)
        addSubview(sectionLockImgV)
        
        sectionLockImgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLb)
            make.left.equalToSuperview().offset(25)
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(25)
        }
        
        headerTitleFlodStateImgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLb)
            make.right.equalToSuperview().offset(-25)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTap))
        self.addGestureRecognizer(tap)
    }

    
    func installUI() {
        
    }
    
    @objc func clickTap() {
        if let c = closure {
            c()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//    - (void)toStudyCoursePlayer:(BXGStudyCourseModel *)studyCourseModel phaseModel:(BXGStudyCourseDetailPhaseModel *)phaseModel moduleModel:(BXGStudyCourseDetailModuleModel *)moduleModel {
//
//
//    NSMutableDictionary *para = [NSMutableDictionary new];
//    para[@"课程ID"] = studyCourseModel.idx;
//    para[@"课程名称"] = studyCourseModel.courseName;
//    [[BXGZhugeStatistic shareInstance] statisticEventString:kBXGZGStatStudyCourseDetailEventTypeClickStudy andParameter:para];
//    [[BXGZhugeStatistic shareInstance] statisticEventString:kBXGZGStatStudyCoursePlayerEventTypeEnterPage andParameter:para];
//
//    // 判断是否是锁定状态
//
//    if(phaseModel.phaseLockStatus.boolValue == false) {
//    [[BXGHUDTool share] showHUDWithString:@"请到web端通过阶段作业后观看视频"];
//    return;
//    }
//
//    NSAssert(studyCourseModel && phaseModel && moduleModel, @"缺少参数");
//    BXGStudyCoursePlayerContentVC *contentVC = [[BXGStudyCoursePlayerContentVC alloc]initWithCourseModel:studyCourseModel PhaseModel:phaseModel ModuleModel:moduleModel];
//    BXGVODPlayerVC *playerVC = [[BXGVODPlayerVC alloc]initWithContentViewController:contentVC];
//
//    [self.navigationController pushViewController:playerVC animated:true];
//
//    }
    
    
    
}


extension BXGCourseDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let phaseModels = self.viewModel.phaseModels,
            let moduleList = phaseModels[indexPath.section].moduleAndPhaseHomeWorkList {
            toCoursePlayer(courseModel: courseModel, phaseModel: phaseModels[indexPath.section], moduleModel: moduleList[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GroupSection", for: indexPath)
        
        var isOpen = false
        var isEnable = false
        var title = " "
        
        if let view = view as? GroupSection {
            
            isOpen = !viewModel.set.contains(indexPath.section)
            
            if let phaseModels = viewModel.phaseModels  {
                let phaseModel = phaseModels[indexPath.section]
                
                
                if let t = phaseModel.phaseName {
                    title = t
                }
                
                if let phaseLockStatus = phaseModel.phaseLockStatus {
                    isEnable = phaseLockStatus == 1; // 0锁定
                }

            }
            
            view.setState(title: title, isEnable: isEnable, isOpen: isOpen)
        
        }
        
        
        
        if let v = view as? GroupSection {
            v.closure = { [unowned self] in
                self.clickSectionHeader(indexPath: indexPath)
            }
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
        return CGSize(width: collectionView.bounds.size.width, height: 53)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.phaseModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(viewModel.set.contains(section)) {
            return 0
            
        }else {
            if let models = self.viewModel.phaseModels, let count = models[section].moduleAndPhaseHomeWorkList?.count {
                return count
            }else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BXGPhaseCCell", for: indexPath)
        
        if let cell = cell as? BXGPhaseCCell, let phaseModels = self.viewModel.phaseModels, let moduleModels = phaseModels[indexPath.section].moduleAndPhaseHomeWorkList{
            let moduleModel = moduleModels[indexPath.row]
            
            var isLock = false
            if let phaseLockStatus = phaseModels[indexPath.section].phaseLockStatus {
                isLock = phaseLockStatus == 0; // 0锁定 1解锁
            }
            
            cell.installData(moduleModel: moduleModel, isLock: isLock)
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 225, height: 123)
    }
    
}
