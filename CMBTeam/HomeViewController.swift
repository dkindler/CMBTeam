//
//  HomeViewController.swift
//  CMBTeam
//
//  Created by Dan Kindler on 1/3/17.
//  Copyright © 2017 Dan Kindler. All rights reserved.
//

import UIKit
import LayoutKit

class HomeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        self.reloadableViewLayoutAdapter = CustomReloadableViewLayoutAdapter(reloadableView: cv)
        self.reloadableViewLayoutAdapter.delegate = self
        cv.dataSource = self.reloadableViewLayoutAdapter
        cv.delegate = self.reloadableViewLayoutAdapter
        cv.backgroundColor = .white
        cv.frame = self.view.bounds
        return cv
    }()
    
    private var reloadableViewLayoutAdapter: CustomReloadableViewLayoutAdapter!

    var teamMembers = [Person]() {
        didSet {
            layout()
        }
    }

    //MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        teamMembers = TeamManager.shared.teamMembers
        setupNavigationBar()
        
        layout()
    }
    
    func setupNavigationBar() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 84, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cmb_logo")
        self.navigationItem.titleView = imageView
        
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //MARK: LayoutKit Layouting
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        layout()
    }
    
    private func layout(width: CGFloat, synchronous: Bool) {
        let layouts = teamMembers.map { TeamMemberLayout(person: $0) }
        self.reloadableViewLayoutAdapter.reload(width: width, synchronous: synchronous, layoutProvider: { () -> [Section<[Layout]>] in
            return [Section(items: layouts)]
        })
    }
    
    private func layout() {
        layout(width: (self.collectionView.bounds.width / 2) - 10, synchronous: true)
    }
}

//MARK: Custom Reloadable View Layout Delegate

extension HomeViewController: CustomReloadableViewLayoutAdapterDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        let profileVC = ProfileViewController()
        profileVC.person = teamMembers[indexPath.item]
        self.show(profileVC, sender: nil)
    }
}

//MARK: CCustomReloadableViewLayoutAdapter and Delegate

protocol CustomReloadableViewLayoutAdapterDelegate: class {
    func didSelectItemAt(indexPath: IndexPath)
}

class CustomReloadableViewLayoutAdapter: ReloadableViewLayoutAdapter {
    weak var delegate: CustomReloadableViewLayoutAdapterDelegate?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}
