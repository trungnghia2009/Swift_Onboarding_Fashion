//
//  ViewController.swift
//  onboarding-fashion-app
//
//  Created by trungnghia on 4/27/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Vars and Consts
    private let items: [OnboardingItem] = OnboardingItem.placeholderItems
    private var imageViews = [UIImageView]()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageControl()
        setupImageViews()
    }
    
    //MARK: - IBActions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let nextRow = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: nextRow, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        showItem(at: nextRow)
    }
    
    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    private func showItem(at index: Int) {
        pageControl.currentPage = index
        let shouldHide = index == items.count - 1
        nextButton.isHidden = shouldHide
        
    }
    
    //MARK: - Setup funcs
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setupImageViews() {
        items.forEach { (item) in
            print(item.image.debugDescription)
            let imageView = UIImageView(image: item.image)
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.0
            // Whenever do your coding the views programmatically, you have to set this property to False
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            containerView.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
            imageViews.append(imageView)
        }
        imageViews.first?.alpha = 1.0
        containerView.bringSubviewToFront(collectionView)
    }
    
    
    //MARK: - ScrollView settings
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(getCurrentIndex())
        showItem(at: getCurrentIndex())
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(index)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        //print("fadeInAlpha: \(fadeInAlpha)")
        //print("fadeOutAlpha: \(fadeOutAlpha)")

        let canShow = (index < items.count - 1)
        guard canShow else { return }
        imageViews[index].alpha = fadeOutAlpha
        imageViews[index + 1].alpha = fadeInAlpha
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView.frame.size.width
    }
}


//MARK: - UIColection view data source and delegate
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! QuoteCollectionViewCell
        let shouldShow = (items.count - 1 == indexPath.item)
        let item = items[indexPath.item]
        
        cell.configure(with: item)
        cell.showExploreButton(shouldShow)
        
        return cell
    }
    
    // Adjust size for Collection Cell View
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    // Adjust minimun space between views
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

