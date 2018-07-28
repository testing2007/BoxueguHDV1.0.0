//
//  BXGSectionExamImageViewerVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/23.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGStudySectionExamViewerCCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isMultipleTouchEnabled = true
        view.maximumZoomScale = 3
        view.minimumZoomScale = 1
        view.delegate = self
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: function
    
    func setURL(urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "course_image_defaut"), options: nil, progressBlock: nil, completionHandler: nil)
        }else {
            imageView.image = #imageLiteral(resourceName: "course_image_defaut")
        }
    }
    
    func installUI() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalToSuperview()
        }
        scrollView.addSubview(imageView)
        
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.width.height.equalToSuperview()
        }
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapView() {
        self.viewController?.dismiss(animated: true, completion: {
            
        });
    }
}


extension BXGStudySectionExamViewerCCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


extension BXGSectionExamImageViewerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BXGStudySectionExamViewerCCell.description(), for: indexPath)
        if let cell = cell as? BXGStudySectionExamViewerCCell, let imageURLStringList = imageURLStringList, indexPath.item < imageURLStringList.count  {
            cell.setURL(urlString: imageURLStringList[indexPath.row])
        }
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLStringList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

class BXGSectionExamImageViewerVC: UIViewController {
    
    var imageURLStringList: [String]?
    var startIndex: Int?
    
    func install(imageList: [String]?, index: Int = 0) {
        imageURLStringList = imageList
        startIndex = index
        collectionView.reloadData()
        if let imageList = imageList, index < imageList.count && index >= 0{
            if collectionView.numberOfItems(inSection: 0) > index {
                collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(BXGStudySectionExamViewerCCell.self, forCellWithReuseIdentifier: BXGStudySectionExamViewerCCell.description())
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}


