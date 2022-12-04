//
//  QuoteViewController.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import UIKit

class QuoteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var name = ""
    var quoteArray = [QuoteModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let author = Utils.formatString(name: name)
        
        getQuote(author: author)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UINib(nibName: "QuoteViewCell", bundle: nil), forCellWithReuseIdentifier: "QuoteCell")
    }
    
    func getQuote(author:String){
        NetworkManager.shared.getCharacterQuote(author: author) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let quote):
                self.quoteArray = quote
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension QuoteViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quoteArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuoteCell", for: indexPath) as! QuoteViewCell
        cell.quoteLabel.text = quoteArray[indexPath.item].quote
        cell.backgroundColor = randomColor()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 95)
    }
    
    func randomColor()->UIColor {
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
