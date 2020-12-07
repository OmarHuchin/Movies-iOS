//
//  MoviesCollectionViewController.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MoviCell"
private let footerReuseIdentifier = "FooterCollectionReusableView"
class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var movies: [Movie] = [Movie]()
    var presenter: MoviePresenter?
    weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Películas"
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.showNowMovies()
    }
    override func loadView() {
        super.loadView()
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
        NSLayoutConstraint.activate([
            self.activityIndicator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 24),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 24),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    func displayLoading() {
        self.activityIndicator.isHidden = false
        self.collectionView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 8, right: 0)
        self.activityIndicator.startAnimating()
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(indexPath: indexPath)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = self.movies[indexPath.item]
        cell.populate(movie: movie)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter?.getSizeItem(collectionView: collectionView) ?? CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return presenter?.getMinimumLineSpacingForSectionAt(collectionView: collectionView) ?? CGFloat.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return presenter?.getMinimumInteritemSpacingForSectionAt(collectionView: collectionView) ?? CGFloat.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return presenter?.getEdgeInsets(collectionView: collectionView) ?? UIEdgeInsets.zero
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter?.didScroll(scrollView: scrollView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter{
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerReuseIdentifier, for: indexPath)
            return footerView
        }
         return UICollectionReusableView()
    }
}
extension MoviesCollectionViewController: MoviePresenterToViewProtol{
    func hideLoading() {
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.isHidden = true
    }
    
    func display(movies: [Movie]) {
        self.hideLoading()
        self.collectionView.contentInset = UIEdgeInsets.zero
        self.movies = movies
        self.collectionView.reloadData()
    }
    func display(error: String) {
        print(error)
    }
}
