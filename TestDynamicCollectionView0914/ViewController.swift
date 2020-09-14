//
//  ViewController.swift
//  TestDynamicCollectionView0914
//
//  Created by Yuan Zhou on 2020/09/14.
//  Copyright © 2020 ZhouyuanWork, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 25
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell?

        switch indexPath {
        case [0, 20]:
            cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? MyTableViewCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = "cell"
        }

        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

class MyTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    private let kCollectionNumberOfItemsInOneRow = 2
    private let kCollectionPaddingSectionLeft: CGFloat = 12.0
    private let kCollectionPaddingSectionRight: CGFloat = 12.0
    private let kCollectionItemSpacing: CGFloat = 8.0

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = kCollectionItemSpacing
        flow.sectionInset = UIEdgeInsets(top: 24.0, left: kCollectionPaddingSectionLeft,
                                         bottom: 24.0, right: kCollectionPaddingSectionRight)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.label.text = "123456789012345678901234567890123456789012345678901234567890"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = kCollectionItemSpacing * CGFloat(kCollectionNumberOfItemsInOneRow - 1)
            + kCollectionPaddingSectionLeft
            + kCollectionPaddingSectionRight
        return CGSize(width: (collectionView.frame.width - padding) / 2.0, height: 32.0)
    }
}

class MyCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()

        if bounds.size.width != intrinsicContentSize.width {
            // update layout to fit the device's actual screen size
            self.invalidateIntrinsicContentSize()
            self.collectionViewLayout.invalidateLayout()
        }
    }

    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
}
