//
//  BXGSectionExamQuestionVC.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/21.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

public let BXGSectionExamQuestionCCellIdentifier = "BXGSectionExamQuestionCCellIdentifier"

public let BXGSectionExamQuestionHeadCellIdentifier = "BXGSectionExamQuestionHeadCell"
public let BXGSectionExamQuestionHeadImageCellIdentifier = "BXGSectionExamQuestionHeadImageCell"
public let BXGSectionExamOptionCellIdentifier = "BXGSectionExamOptionCell"

enum BXGSectionExamQuestionCCellDataSource {
    case head(type: BXGStudySectionExamQuestionType, headTitle: String?)
    case headImage(url: String)
    case option(type: BXGStudySectionExamQuestionType,index: Int, indexString: String?, option: String?, optionPicture: String?)
}

class BXGSectionExamQuestionCCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var index: Int?
    var viewModel: BXGSectionExamViewModel?
    

    
    
    func installModel(index: Int, examModel: BXGSectionExamModel, viewModel: BXGSectionExamViewModel) {
        self.index = index
        self.examModel = examModel
        self.viewModel = viewModel
        if let dict = viewModel.loadAnswer(subjectIndex: index) {
            
            
            for (dataIndex, data) in dataSource.enumerated() {
                switch data {
                    
                case .head(let type, let headTitle):break
                    
                case .headImage(let url):break
                    
                case .option(let type, let index, let indexString, let option, let optionPicture):
                    if dict[index] == true {
                        tableView.selectRow(at: IndexPath(row: dataIndex, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    }else {
                        tableView.deselectRow(at: IndexPath(row: dataIndex, section: 0), animated: false)
                    }
                }
            }
        }
    }
    lazy var dataSource: [BXGSectionExamQuestionCCellDataSource] = {
        return [BXGSectionExamQuestionCCellDataSource]()
    }()
    
    var examModel: BXGSectionExamModel? {
        didSet {
            
            if let examModel = examModel {
                makeDataSource(examModel: examModel)
            }
            
            tableView.reloadData()
        }
    }
    
    func makeDataSource(examModel: BXGSectionExamModel) {
        if let stringValue = examModel.questionType, let intValue = Int(stringValue), let type = BXGStudySectionExamQuestionType(rawValue: intValue) {
            
            dataSource.removeAll()
            
//            if type == .multiple {
//                tableView.allowsSelection = true
//                tableView.allowsMultipleSelection = f
//            }else {
//                tableView.allowsMultipleSelection = true
//                tableView.allowsSelection = true
//
//            }
            dataSource.append(.head(type: type, headTitle: examModel.appQuestionHead))
            
            if let imageList = examModel.appImageList {
                for image in imageList {
                    dataSource.append(.headImage(url: image))
                }
            }
            
            if type == .trueFalse {
                dataSource.append(.option(type: type, index: 0, indexString: "A", option: "对", optionPicture: nil))
                dataSource.append(.option(type: type, index: 1, indexString: "B", option: "错", optionPicture: nil))
            }else {
                var optionList = [String]()
                var optionPictureList = [String]()
                
                if let list = examModel.appOptions{
                    for o in list {
                        optionList.append(o)
                    }
                }
                if let list = examModel.appOptionsPicture  {
                    for o in list {
                        optionPictureList.append(o)
                    }
                }
                var index = 0
                while index < optionList.count || index < optionPictureList.count {
                    
                    var option: String?
                    var optionPicture: String?
                    
                    if index < optionList.count {
                        option = optionList[index]
                    }
                    
                    if index < optionPictureList.count {
                        optionPicture = optionPictureList[index]
                    }
                    dataSource.append(.option(type: type, index: index, indexString: "", option: option, optionPicture: optionPicture))
                    index = index + 1
                }
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(BXGSectionExamQuestionHeadCell.self, forCellReuseIdentifier: BXGSectionExamQuestionHeadCellIdentifier)
        view.register(BXGSectionExamQuestionHeadImageCell.self, forCellReuseIdentifier: BXGSectionExamQuestionHeadImageCellIdentifier)
        view.register(BXGSectionExamQuestionOptionCell.self, forCellReuseIdentifier: BXGSectionExamOptionCellIdentifier)
        view.delegate = self
        
        view.dataSource = self
        view.rowHeight = UITableViewAutomaticDimension
        view.estimatedRowHeight = 100
        view.separatorStyle = .none
        view.backgroundColor = UIColor.hexColor(hex: 0xF6F9FC)
        return view
    }()
    
    
    

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        installUI()
    }
    func installUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row < dataSource.count, let viewModel = viewModel, let subjectIndex = self.index  {

            switch dataSource[indexPath.row] {
                
            case .head(let type, let headTitle):break;
                
            case .headImage(let url):break;
                
            case .option(let type, let index, let indexString, let option, let optionPicture):
                
                if let cell = tableView.cellForRow(at: indexPath) as? BXGSectionExamQuestionOptionCell {
                    
                    if type == .multiple {
                        cell.cellSelected = !cell.cellSelected
                    }else {
                        for vcell in tableView.visibleCells {
                            
                            if let vvcell = vcell as? BXGSectionExamQuestionOptionCell, vvcell != cell {
                                vvcell.cellSelected = false
                            }
                        }
                        cell.cellSelected = true
                    }
                    
                    
                    
                    if cell.cellSelected {
                        viewModel.updateAnswerSubjectIndex(subjectIndex: subjectIndex, type: type, optionIndex: index, selected: true)
                    }else {
                        viewModel.updateAnswerSubjectIndex(subjectIndex: subjectIndex, type: type, optionIndex: index, selected: false)
                    }
                }
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if indexPath.row < dataSource.count, let viewModel = viewModel, let subjectIndex = self.index {
//            switch dataSource[indexPath.row] {
//
//            case .head(let type, let headTitle):break;
//
//            case .headImage(let url):break;
//
//            case .option(let type, let index, let indexString, let option, let optionPicture):
//                viewModel.updateAnswerSubjectIndex(subjectIndex: subjectIndex, type: type, optionIndex: index, selected: false)
//            }
//        }
//    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch dataSource[indexPath.row] {
        case .head(let type, let headTitle):
            let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamQuestionHeadCellIdentifier, for: indexPath)
            if let cell = cell as? BXGSectionExamQuestionHeadCell {
                cell.installData(type: type, title: headTitle ?? "")
            }
            return cell
        case .headImage(let url):
            let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamQuestionHeadImageCellIdentifier, for: indexPath)
            if let cell = cell as? BXGSectionExamQuestionHeadImageCell {
                cell.installData(urlString: url)
            }
            
            return cell
        case .option(let type, let index, let indexString, let option, let optionPicture):
            let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamOptionCellIdentifier, for: indexPath)
            if let cell = cell as? BXGSectionExamQuestionOptionCell {
                cell.installData(indexString: indexString, option: option, optionPicture: optionPicture)
                if let viewModel = viewModel, let subjectIndex = self.index {
                    
                    if let dict = viewModel.loadAnswer(subjectIndex: subjectIndex), let isSelected = dict[index], isSelected == true {
                        cell.cellSelected = true
                    }else {
                        cell.cellSelected = false
                    }
                }
            }
            
            return cell
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BXGSectionExamQuestionVC: UIViewController {
        var clickSubmitClosure: (()->())?
    let viewModel: BXGSectionExamViewModel
    
    init(viewModel fromViewModel: BXGSectionExamViewModel) {
        viewModel = fromViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func retry() {
        viewModel.requestSectionExam(moduleId: viewModel.moduleModel.moduleId ?? 0, sectionId: viewModel.sectionModel.sectionId ?? 0) { (succeed, msg) in
            self.collectionView.reloadData()
            self.collectionView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.bounces = false
        view.register(BXGSectionExamQuestionCCell.self, forCellWithReuseIdentifier: BXGSectionExamQuestionCCellIdentifier)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xE0E4E7)
        return view
    }()
    
    lazy var footerLeftNoneBtn: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        
        let arrowView = UIImageView(image: #imageLiteral(resourceName: "section_exam_arrow_left"))
        
        let lb = UILabel()
        lb.text = "无"
        lb.textColor = UIColor.hexColor(hex: 0x34495E)
        lb.font = UIFont.pingFangSCRegular(withSize: 16)
        
        view.addSubview(arrowView)
        view.addSubview(lb)
        arrowView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        lb.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(arrowView.snp.right)
        }
        
        return view
    }()
    lazy var footerLeftPreviousBtn: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        let arrowView = UIImageView(image: #imageLiteral(resourceName: "section_exam_arrow_left"))
        let lb = UILabel()
        lb.text = "上一题"
        lb.textColor = UIColor.hexColor(hex: 0x34495E)
        lb.font = UIFont.pingFangSCRegular(withSize: 16)
        
        view.addSubview(arrowView)
        view.addSubview(lb)
        arrowView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        lb.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(arrowView.snp.right)
        }
        view.addTarget(self, action: #selector(clickPreviousPage), for: UIControlEvents.touchUpInside)
        
        return view
    }()
    
    @objc func clickNextPage() {
        if let currentPage = currentPage {
            if (currentPage + 1) < collectionView.numberOfItems(inSection: 0) && (currentPage + 1) >= 0{
                collectionView.scrollToItem(at: IndexPath(item: currentPage + 1, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
            }
            
        }
    }
    
    @objc func clickPreviousPage() {
        if let currentPage = currentPage {
            if (currentPage - 1) < collectionView.numberOfItems(inSection: 0) && (currentPage - 1) >= 0 {
                collectionView.scrollToItem(at: IndexPath(item: currentPage - 1, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
            }
        }
    }
    
    @objc func clickSubmit() {
        if let clickSubmitClosure = clickSubmitClosure {
            clickSubmitClosure()
        }
    }
    
    
    lazy var footerCenterPageView: UILabel = {
        let view = UILabel()
        
        return view
    }()
    lazy var footerRightNextBtn: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        let arrowView = UIImageView(image: #imageLiteral(resourceName: "section_exam_arrow_right"))
        let lb = UILabel()
        lb.text = "下一题"
        lb.textColor = UIColor.hexColor(hex: 0x34495E)
        lb.font = UIFont.pingFangSCRegular(withSize: 16)
        
        view.addSubview(arrowView)
        view.addSubview(lb)
        arrowView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        lb.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(arrowView.snp.left)
        }
        view.addTarget(self, action: #selector(clickNextPage), for: UIControlEvents.touchUpInside)
        return view
    }()
    lazy var footerRightSubmitBtn: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        let arrowView = UIImageView(image: #imageLiteral(resourceName: "section_exam_arrow_right"))
        let lb = UILabel()
        lb.text = "提交"
        lb.textColor = UIColor.hexColor(hex: 0x34495E)
        lb.font = UIFont.pingFangSCRegular(withSize: 16)
        
        view.addSubview(arrowView)
        view.addSubview(lb)
        arrowView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        lb.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(arrowView.snp.left)
        }
        view.addTarget(self, action: #selector(clickSubmit), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    func setBottomView(currentPage: Int, totalCount: Int) {
        if currentPage == 0 && totalCount == 0{
            footerLeftNoneBtn.isHidden = true
            footerLeftPreviousBtn.isHidden = true
            footerRightSubmitBtn.isHidden = true
            footerRightNextBtn.isHidden = true
            return
        }
        
        if currentPage == 0 {
            footerLeftNoneBtn.isHidden = false
            footerLeftPreviousBtn.isHidden = true
        }else {
            footerLeftNoneBtn.isHidden = true
            footerLeftPreviousBtn.isHidden = false
        }
        
        if currentPage == (totalCount - 1) {
            footerRightSubmitBtn.isHidden = false
            footerRightNextBtn.isHidden = true
        }else {
            footerRightSubmitBtn.isHidden = true
            footerRightNextBtn.isHidden = false
        }
        
        let attString = NSMutableAttributedString(string: "")
        let leftString = NSAttributedString(string: "\(currentPage + 1)", attributes: [NSAttributedStringKey.font : UIFont.pingFangSCRegular(withSize: 16),NSAttributedStringKey.foregroundColor: UIColor.hexColor(hex: 0x333333)])
        
        let centerString = NSAttributedString(string: "/", attributes: [NSAttributedStringKey.font : UIFont.pingFangSCRegular(withSize: 10),NSAttributedStringKey.foregroundColor: UIColor.hexColor(hex: 0x333333, alpha: 0.87)])
        
        let rightString = NSAttributedString(string: "\(totalCount)", attributes: [NSAttributedStringKey.font : UIFont.pingFangSCRegular(withSize: 12),NSAttributedStringKey.foregroundColor: UIColor.hexColor(hex: 0x333333, alpha: 0.34)])
        
        attString.append(leftString)
        attString.append(centerString)
        attString.append(rightString)
        footerCenterPageView.attributedText = attString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
        
        view.addSubview(footerView)
        footerView.addSubview(footerLeftNoneBtn)
        footerView.addSubview(footerLeftPreviousBtn)
        footerView.addSubview(footerRightNextBtn)
        footerView.addSubview(footerRightSubmitBtn)
        footerView.addSubview(footerCenterPageView)
        
        footerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(49)
            make.top.equalTo(collectionView.snp.bottom)
        }
        
        footerLeftNoneBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(25)
            make.width.equalTo(150)
        }
        
        footerLeftPreviousBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(25)
            make.width.equalTo(150)
        }
        
        footerRightNextBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo(150)
        }
        footerRightSubmitBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo(150)
        }
        
        
        footerCenterPageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
//            make.width.equalTo(150)
        }
        
        
        setBottomView(currentPage: 0, totalCount: 0)
        

        loadData()
    }
    
    func loadData() {
        if let moduleId = viewModel.moduleModel.moduleId, let sectionId = viewModel.sectionModel.sectionId {
            viewModel.requestSectionExam(moduleId: moduleId, sectionId: sectionId) { (succeed, message) in
                self.currentPage = 0
                self.collectionView.reloadData()
            }
        }
        
    }
    
    var currentPage: Int? {
        didSet {
            if currentPage != oldValue {
                setBottomView(currentPage: currentPage ?? 0, totalCount: viewModel.examModelList?.count ?? 0)
            }
        }
    }
}

extension BXGSectionExamQuestionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            currentPage = Int(collectionView.contentOffset.x + collectionView.bounds.size.width / 2) / Int(collectionView.bounds.size.width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.examModelList?.count ?? 0
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BXGSectionExamQuestionCCellIdentifier, for: indexPath)
        
        if let cell = cell as? BXGSectionExamQuestionCCell, let examModelList = viewModel.examModelList {
            
            cell.installModel(index: indexPath.row, examModel:  examModelList[indexPath.row],viewModel: viewModel)

        }
        
        return cell
    }
}
