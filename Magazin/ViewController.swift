//
//  ViewController.swift
//  Magazin
//
//  Created by Sergey Shinkarenko on 30.04.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var itemsLabel: UILabel!
    let green: Shop = Shop()
    var i: Int = 0
    var secondVC: SecondViewController?
    var strPackage: String = ""
    @IBOutlet weak var package: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Second") as? SecondViewController
        
        secondVC?.shop = green

        green.onShopClosed = {
            let alert = UIAlertController(title: "Магазин закрыт", message: nil, preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            let addItemsAction = UIAlertAction(title: "Добавить", style: .default) { action in
                self.performSegue(withIdentifier: "add", sender: nil)
            }
            alert.addAction(OK)
            alert.addAction(addItemsAction)
            self.present(alert, animated: true, completion: nil)
        }
        logo.image = UIImage(named: "green_logo")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel()
    }

    @IBAction func sellButtonPressed(_ sender: Any) {
        green.sell()
        updateLabel()
        if green.ArrayItems.isEmpty{
            package.text = ""
        }
    }
    
    func updateLabel() {
        itemsLabel.text = "\(green.items)"
    }
    
    @IBAction func move(_ sender: Any) {
        green.moveItemsToShelf()
        updateLabel()
    }

    @IBAction func openStorageVC(_ sender: Any) {
        guard let vc = secondVC else {
            return
        }
        navigationController?.show(vc, sender: nil)
    }
    @IBAction func packageItems(_ sender: Any) {
        green.addPackageItems()
        for index in 0..<green.ArrayItems.count {
            strPackage = strPackage + "\(green.ArrayItems[index])"
        }
        
        package.text = strPackage
       
    }
}

