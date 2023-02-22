//
//  TVC.swift
//  SampleTVJson
//
//  Created by Rifluxyss on 20/02/23.
//

import UIKit


class TVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var id_Lbl: UILabel!
    @IBOutlet weak var name_text: UITextField!
    @IBOutlet weak var phone_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        name_text.resignFirstResponder()
//        phone_text.resignFirstResponder()
//        email_text.resignFirstResponder()
//        return true
//    }
}
