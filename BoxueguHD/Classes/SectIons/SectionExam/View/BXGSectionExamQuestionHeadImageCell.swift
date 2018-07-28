//
//  BXGSectionExamQuestionHeadImageCell.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/21.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

class BXGSectionExamQuestionHeadImageCell: UITableViewCell {
    
    var imageURLString: String?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.addGestureRecognizer(tap)
//        self.isUserInteractionEnabled = false
        
    }
    @objc func tapView() {
        if let viewController = viewController, let imageURLString = imageURLString {
            let vc = BXGSectionExamImageViewerVC()
            vc.modalTransitionStyle = .crossDissolve
    
            vc.install(imageList: [imageURLString])
            viewController.present(vc, animated: true) {
                
            }
        }
    }
    
    func installData(urlString: String) {
        imageURLString = urlString
        if let url = URL(string: urlString) {
            cellImageView.kf.setImage(with: url)
        }
    }
}
