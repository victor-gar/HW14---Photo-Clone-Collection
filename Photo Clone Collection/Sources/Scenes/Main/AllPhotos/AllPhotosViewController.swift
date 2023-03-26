//
//  LibraryViewController.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 30.01.2023.
//

import UIKit



class AllPhotosViewController: UIViewController {
    
    // MARK: - UI
    static let screenSize = UIScreen.main.bounds
    
    var results = [Result]()
    
    let urlString = "https://api.unsplash.com/search/photos?page=2&per_page=90&query=office&client_id=IMrOGG17RGMXTqsn9QPEmgWAU70ygGNptIz3_t0xayI"
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AllPhotosCell.self, forCellWithReuseIdentifier: AllPhotosCell.cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    fileprivate var mySegmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Years","Mounths","Days","All Photos"])
        segmentControl.selectedSegmentIndex = 3
        segmentControl.frame = CGRect(x: 10, y: 150, width: 300, height: 30)
        segmentControl.tintColor = UIColor.yellow
        segmentControl.backgroundColor = UIColor.white
        segmentControl.selectedSegmentTintColor = UIColor.lightGray
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return segmentControl
    }()
    // MARK: - Lifecycle
    
    func fetchPhotos(){
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView.reloadData()
                    print(jsonResult.results.count)
                }
            }
            catch {
                print("errors")
                
            }
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        title = "Library"
    }
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(mySegmentedControl)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        switch (mySegmentedControl.selectedSegmentIndex) {
        case 0:
            print("1")
            collectionView.reloadData()
        case 1:
            print("2")
            collectionView.reloadData()
        case 2:
            print("3")
            collectionView.reloadData()
        case 3:
            print("4")
            collectionView.reloadData()
            default: break
        }
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.bottom.right.equalTo(view)
        }
        
        mySegmentedControl.snp.makeConstraints { make in
            make.bottom.equalTo(-150)
            make.centerX.equalTo(view)
        }
    }
    
    func getCurrentDateStringForRest() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    // MARK: - Actions
}


extension AllPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLStrings = results[indexPath.item].urls.thumb
        // let labelText = results[indexPath.item].created_at
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: AllPhotosCell.cellID, for: indexPath) as! AllPhotosCell
                
        if mySegmentedControl.selectedSegmentIndex == 0 {
            collectionView.minimumContentSizeCategory = .small
            item.image.layer.cornerRadius = 12
            item.configure(with: imageURLStrings)
            item.label.text = "2023"
        } else if mySegmentedControl.selectedSegmentIndex == 1 {
            item.configure(with: imageURLStrings)
        } else if mySegmentedControl.selectedSegmentIndex == 2 {
            item.configure(with: imageURLStrings)
            
        } else if mySegmentedControl.selectedSegmentIndex == 3 {
            item.configure(with: imageURLStrings)
        }
        return item
    }
}

extension AllPhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mySegmentedControl.selectedSegmentIndex == 0 {
            return  UIEdgeInsets(top: 10, left: 10, bottom: 15, right: 10)
        } else if mySegmentedControl.selectedSegmentIndex == 1  {
        } else if   mySegmentedControl.selectedSegmentIndex == 2{
        } else if   mySegmentedControl.selectedSegmentIndex == 3 {
            return   UIEdgeInsets(top: 1, left: 1, bottom: 15, right: 1)
        }
        return   UIEdgeInsets(top: 1, left: 1, bottom: 15, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthAll: CGFloat = collectionView.frame.width / 5 - 1
        let widthDays: CGFloat = collectionView.frame.width / 2 - 1
        let widthMounths: CGFloat = collectionView.frame.width
        let widthYears: CGFloat = collectionView.frame.width - 20
        
        if mySegmentedControl.selectedSegmentIndex == 0 {
            return CGSize(width: widthYears, height: widthYears)
        } else if mySegmentedControl.selectedSegmentIndex == 1  {
            return CGSize(width: widthMounths, height: widthMounths)
        } else if   mySegmentedControl.selectedSegmentIndex == 2{
            return CGSize(width: widthDays - 5, height: widthDays)
        } else if   mySegmentedControl.selectedSegmentIndex == 3 {
            return CGSize(width: widthAll, height: widthAll)
        }
        return  CGSize(width: widthAll, height: widthAll)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if mySegmentedControl.selectedSegmentIndex == 0 {
            return  10
        } else if mySegmentedControl.selectedSegmentIndex == 1  {
            return  10
        } else if   mySegmentedControl.selectedSegmentIndex == 2{
            return  10
        } else if   mySegmentedControl.selectedSegmentIndex == 3 {
            return   0
        }
        return   0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if mySegmentedControl.selectedSegmentIndex == 0 {
            return  10
        } else if mySegmentedControl.selectedSegmentIndex == 1  {
            return  10
        } else if   mySegmentedControl.selectedSegmentIndex == 2{
            return  10
        } else if   mySegmentedControl.selectedSegmentIndex == 3 {
            return   0
        }
        return   0
    }
}

extension Date {
    func dayMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
}
