//
//  HFMentorViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/23/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit

class HFMentorViewController: UIViewController {

    
    // MARK: UIOutlets
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    // MARK: Class Varibles 
    var textViewColor = UIColor.lightGrayColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextField.layer.borderWidth = 0.5
        descriptionTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        descriptionTextField.layer.cornerRadius = 7.5
        descriptionTextField.text = "What do you need?"
        descriptionTextField.textColor = textViewColor
        descriptionTextField.selectedTextRange = descriptionTextField.textRangeFromPosition(descriptionTextField.beginningOfDocument, toPosition: descriptionTextField.beginningOfDocument)

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.descriptionTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.locationTextField.resignFirstResponder()
    }
    
    /* Functions to allow for a placeholder in the text view. */
    func textViewDidChange(textView: UITextView) { //Handle the text changes here
        
        if textView.text.isEmpty {
            textView.text = "What do you need?"
            textView.textColor = textViewColor
        } else if textView.text == "What do you need?" {
            textView.textColor = textViewColor
        } else if textView.text.containsString("What do you need?") {
            textView.text = textView.text.componentsSeparatedByString("What do you need?")[1]
            textView.textColor = UIColor.blackColor()
        }
        
    }

    

}
