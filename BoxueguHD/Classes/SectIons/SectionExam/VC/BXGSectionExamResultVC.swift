//
//  BXGSectionExamResultVC.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/21.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

enum BXGSectionExamResultTableViewDataSourceType {
    case questionCell(questionType: BXGStudySectionExamQuestionType, questionHead: String?)
    case imageCell(urlString: String?)
    case optionCell(initial: String?, option: String?, optionPicture: String?, isSelected: Bool, isRight: Bool)
    case rightAnswerCell(rightAnswer: [String]?)
    case analyseCell(analyse: String?)
    case separatorCell
}

class BXGSectionExamResultImageCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    lazy var cellImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        
        contentView.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(200)
            make.top.bottom.equalToSuperview().offset(0)
        }
        let tap = UITapGestureRecognizer()
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = false
    }
    
    func installData(urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            cellImageView.kf.setImage(with: url)
        }
    }
}



class BXGSectionExamResultVC: UIViewController {

    var clickReTryClosure: (()->())?
    var clickContinueClosure: (()->())?
    
    
    
    
    lazy var tableViewDataSource: [BXGSectionExamResultTableViewDataSourceType] = {
        return [BXGSectionExamResultTableViewDataSourceType]()
    }()
    
    func loadData() {
        self.tableViewDataSource.removeAll()
        viewModel?.postSectionExamAnswer(finished: { (finished, msg) in
            if let examResultModel = self.viewModel?.examResultModel {
                self.setHeaderInfo(examCount: examResultModel.totalQuestionCount ?? 0,
                                   rightCount: Int(examResultModel.rightQuestionCount ?? 0),
                                   accuracy: Float(examResultModel.accuracy ?? 0),
                                   advice:examResultModel.advise)
                
                if let examModels = examResultModel.sectionTestDetailVos {
                    
                    for (index, examModel) in examModels.enumerated() {
                        
                        if let questionType = examModel.appQuestionType {
                            self.tableViewDataSource.append(BXGSectionExamResultTableViewDataSourceType.questionCell(questionType: questionType, questionHead: examModel.appQuestionHead))
                            
                            if let imgList = examModel.appImageList {
                                for img in imgList {
                                    self.tableViewDataSource.append(BXGSectionExamResultTableViewDataSourceType.imageCell(urlString: img))
                                }
                            }
                            
                            if let optionModels = examModel.appOptionModels {
                                for (index,optionModel) in optionModels.enumerated() {
                                    var isRight = false
                                    var isSelected = false
                                    
                                    
                                    
                                    if  let answers = examModel.appAnswers {
                                        
                                        for answer in answers {
                                            if answer == "\(index)" {
                                                isSelected = true
                                                break
                                            }
                                        }
                                        
                                        if isSelected {
                                            if let standardAnswers = examModel.appStandardAnswers {
                                                for rightAnswer in standardAnswers {
                                                    if (rightAnswer == "\(index)") {
                                                        isRight = true
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                    self.tableViewDataSource.append(BXGSectionExamResultTableViewDataSourceType.optionCell(initial: alphabet[index], option: optionModel.optionTitle, optionPicture: optionModel.optionPicture, isSelected: isSelected, isRight: isRight))
                                }
                            }
                            
                            
                            self.tableViewDataSource.append(BXGSectionExamResultTableViewDataSourceType.rightAnswerCell(rightAnswer: examModel.appStandardAnswers))
                            self.tableViewDataSource.append(BXGSectionExamResultTableViewDataSourceType.analyseCell(analyse: examModel.appSolution))
                            
                            if let analyseImgList = examModel.appSolutionImageList {
                                for img in analyseImgList {
                                    self.tableViewDataSource.append(BXGSectionExamResultTableViewDataSourceType.imageCell(urlString: img))
                                }
                            }
                            
                            if index != examModels.count - 1 {
                                self.tableViewDataSource.append(BXGSectionExamResultTableViewDataSourceType.separatorCell)
                            }
                        }
                    }
                }
            }
            self.view.layoutIfNeeded()
            self.tableView.tableHeaderView = self.headerView
            self.tableView.contentOffset = CGPoint(x: 0, y: 0 )
            self.tableView.reloadData()
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    var viewModel: BXGSectionExamViewModel?
    init(viewModel from: BXGSectionExamViewModel) {
        viewModel = from
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var headerView: BXGSectionExamResultHeaderView = {
        let view = BXGSectionExamResultHeaderView()
        return view
    }()
    
    lazy var headerExamResultInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xE0E4E7)
        return view
    }()
    
    lazy var headerExamResultInfoLb: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.themeColor
        view.font = UIFont.pingFangSCRegular(withSize: 16)
        return view
    }()
    
    lazy var headerAdviceTagView: UIView = {
        let view = UIView()
       
        let dotView = UIView()
        dotView.backgroundColor = UIColor.themeColor
        
        let tagLb = UILabel()
        tagLb.font = UIFont.pingFangSCRegular(withSize: 16)
        tagLb.textColor = UIColor.hexColor(hex: 0x34495E)
        tagLb.text = "学习建议"
        view.addSubview(tagLb)
        view.addSubview(dotView)
    
        dotView.snp.makeConstraints { (make) in
            make.centerY.equalTo(tagLb)
            make.left.equalTo(25)
            make.width.height.equalTo(5)
        }
        dotView.layer.cornerRadius = 2.5
        
        tagLb.snp.makeConstraints { (make) in
            make.left.equalTo(dotView.snp.right).offset(5)
            make.top.equalTo(20)
        }
        return view
    }()
    
    lazy var headerAdviceTagLb: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.hexColor(hex: 0x34495E)
        view.font = UIFont.pingFangSCRegular(withSize: 16)
        return view
    }()
    
    lazy var headerAnswerTagView: UIView = {
        let view = UIView()
        
        let dotView = UIView()
        dotView.backgroundColor = UIColor.themeColor
        
        let tagLb = UILabel()
        tagLb.font = UIFont.pingFangSCRegular(withSize: 16)
        tagLb.textColor = UIColor.hexColor(hex: 0x34495E)
        tagLb.text = "题目答案"
        view.addSubview(tagLb)
        view.addSubview(dotView)
        
        dotView.snp.makeConstraints { (make) in
            make.centerY.equalTo(tagLb)
            make.left.equalTo(25)
            make.width.height.equalTo(5)
        }
        dotView.layer.cornerRadius = 2.5
        
        tagLb.snp.makeConstraints { (make) in
            make.left.equalTo(dotView.snp.right).offset(5)
            make.top.equalTo(30)
        }
        return view
    }()

    func setHeaderInfo(examCount: Int, rightCount: Int, accuracy: Float, advice: String?) {
        headerExamResultInfoLb.text = "共\(examCount)道题，答对了\(rightCount)道题，正确率：\(accuracy)%"
        headerAdviceTagLb.text = advice
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(BXGSectionExamResultQuestionCell.self, forCellReuseIdentifier: BXGSectionExamResultQuestionCell.description())
        view.register(BXGSectionExamResultImageCell.self, forCellReuseIdentifier: BXGSectionExamResultImageCell.description())
        view.register(BXGSectionExamResultOptionCell.self, forCellReuseIdentifier: BXGSectionExamResultOptionCell.description())
        view.register(BXGSectionExamResultRightAnswerCell.self, forCellReuseIdentifier: BXGSectionExamResultRightAnswerCell.description())
        view.register(BXGSectionExamResultAnalyseCell.self, forCellReuseIdentifier: BXGSectionExamResultAnalyseCell.description())
        view.register(BXGSectionExamResultSeparatorCell.self, forCellReuseIdentifier: BXGSectionExamResultSeparatorCell.description())
        view.separatorStyle = .none
        return view
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xE0E4E7)
        return view
    }()
    lazy var footerRetryBtn: UIButton = {
        let view = UIButton()
        view.setTitle("重新测试", for: UIControlState.normal)
        view.addTarget(self, action: #selector(clickRetryBtn), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    @objc func clickRetryBtn() {
        if let clickRetryClosure = clickReTryClosure {
            clickRetryClosure()
        }
    }
    
    @objc func clickContinueBtn() {
        if let clickContinueClosure = clickContinueClosure {
            clickContinueClosure()
        }
    }
    
    lazy var footerContinueBtn: UIButton = {
        let view = UIButton()
        view.setTitle("继续学习", for: UIControlState.normal)
        view.addTarget(self, action: #selector(clickContinueBtn), for: UIControlEvents.touchUpInside)
        return view
    }()
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        viewModel?.postSectionExamAnswer(finished: { (finished, msg) in
//            print()
//        })
//    }
    
    func installUI() {
        view.addSubview(tableView)
        view.addSubview(footerView)
        footerView.addSubview(footerRetryBtn)
        footerView.addSubview(footerContinueBtn)
        
        footerView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(49)
        }
        
        footerContinueBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
        }
        
        footerRetryBtn.snp.makeConstraints { (make) in
            make.right.equalTo(footerContinueBtn.snp.left).offset(-25)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        
        tableView.tableHeaderView = headerView
        headerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { (make) in
            make.width.equalTo(view.bounds.size.width)
        }
        headerView.addSubview(headerExamResultInfoView)
        headerExamResultInfoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
            
        }
        headerExamResultInfoView.addSubview(headerExamResultInfoLb)
        headerExamResultInfoLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
        }
        headerView.addSubview(headerAdviceTagView)
        headerAdviceTagView.snp.makeConstraints { (make) in
            make.top.equalTo(headerExamResultInfoView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headerView.addSubview(headerAdviceTagLb)
        headerAdviceTagLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.width.equalToSuperview()
            make.top.equalTo(headerAdviceTagView.snp.bottom)
            
        }
        headerView.addSubview(headerAnswerTagView)
        headerAnswerTagView.snp.makeConstraints { (make) in
            make.top.equalTo(headerAdviceTagLb.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(54)
            make.bottom.equalToSuperview()
        }
        
//        lazy var headerExamResultInfoView: UIView = {
//            let view = UIView()
//            view.backgroundColor = UIColor.hexColor(hex: 0xE0E4E7)
//            return view
//        }()
//
//        lazy var headerExamResultInfoLb: UILabel = {
//            let view = UILabel()
//            view.textColor = UIColor.themeColor
//            view.font = UIFont.pingFangSCRegular(withSize: 16)
//            return view
//        }()
        
        
        
        view.layoutIfNeeded()
        tableView.tableHeaderView = headerView
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installUI()
//        view.backgroundColor = UIColor.random()
    }
}

extension BXGSectionExamResultVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < tableViewDataSource.count {
            switch tableViewDataSource[indexPath.row] {
                
            case .questionCell(let questionType,let questionHead):
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamResultQuestionCell.description(), for: indexPath)
                if let cell = cell as? BXGSectionExamResultQuestionCell {
                    cell.installData(type: questionType, title: questionHead)
                }
                return cell
                
            case .imageCell(let urlString):
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamResultImageCell.description(), for: indexPath)
                if let cell = cell as? BXGSectionExamResultImageCell {
                    cell.installData(urlString: urlString)
                }
                return cell
                
            case let .optionCell(initial, option, optionPicture, isSelected, isRight):
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamResultOptionCell.description(), for: indexPath)
                if let cell = cell as? BXGSectionExamResultOptionCell {
                    cell.installData(indexString: initial, option: option, optionPicture: optionPicture, isSelected: isSelected, isRight: isRight)
                }
                return cell
                
            case .rightAnswerCell(let rightAnswer):
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamResultRightAnswerCell.description(), for: indexPath)
                if let cell = cell as? BXGSectionExamResultRightAnswerCell {
                    cell.installModel(string: rightAnswer)
                }
                return cell
                
            case .analyseCell(let analyse):
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamResultAnalyseCell.description(), for: indexPath)
                if let cell = cell as? BXGSectionExamResultAnalyseCell {
                    cell.installModel(analyse: analyse)
                }
                return cell
                
            case .separatorCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamResultSeparatorCell.description(), for: indexPath)
                return cell
            }
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BXGSectionExamResultQuestionCell.description(), for: indexPath)
            return cell
        }
    }
    
}






