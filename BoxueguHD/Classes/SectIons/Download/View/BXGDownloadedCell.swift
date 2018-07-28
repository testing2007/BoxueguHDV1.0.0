//
//  BXGDownloadedCell.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

class BXGDownloadedCell: UITableViewCell {

    var courseNameLabel : UILabel?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.installUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder:aDecoder)
    }
    
    func installUI() {
        self.courseNameLabel = UILabel.init();
        self.courseNameLabel!.backgroundColor = UIColor.gray;
        self.contentView.addSubview(self.courseNameLabel!);
        self.courseNameLabel?.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.center.equalTo(self);
        }
    }

}
