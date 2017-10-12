//
//  CardsViewController.swift
//  Tinderoo
//
//  Created by Kavita Gaitonde on 10/11/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIViewControllerTransitioningDelegate {

    
    @IBOutlet weak var draggableImageView: DraggableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleTap(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "profileSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "profileSegue") {
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            //vc.image = /*self.draggableImageView.image*/ UIImage(named: "ryan")
            self.present(vc, animated: true, completion: nil)*/
            segue.destination.transitioningDelegate = self
        }
    }
 
    // MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransition()
    }

}
