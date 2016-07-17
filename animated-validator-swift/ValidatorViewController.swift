//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    var submitButtonTopAnchor = NSLayoutConstraint()
    var passwordTopConfirmAnchor = NSLayoutConstraint()
    
    
    
    
    @IBAction func emailIsEditing(sender: AnyObject) {
        checkForAllValid()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        emailConfirmationTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.enabled = false
        
        self.view.removeConstraints(self.view.constraints)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 40).active = true
        emailTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        emailTextField.widthAnchor.constraintEqualToConstant(200).active = true
        
        emailConfirmationTextField.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor, constant: 30).active = true
        emailConfirmationTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        emailConfirmationTextField.widthAnchor.constraintEqualToConstant(200).active = true
        
        phoneTextField.topAnchor.constraintEqualToAnchor(emailConfirmationTextField.bottomAnchor, constant: 30).active = true
        phoneTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        phoneTextField.widthAnchor.constraintEqualToConstant(200).active = true
        
        passwordTextField.topAnchor.constraintEqualToAnchor(phoneTextField.bottomAnchor, constant: 30).active = true
        passwordTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToConstant(200).active = true
        
        passwordTopConfirmAnchor = passwordConfirmTextField.topAnchor.constraintEqualToAnchor(passwordTextField.bottomAnchor, constant: 30)
        passwordTopConfirmAnchor.active = true
        passwordConfirmTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        passwordConfirmTextField.widthAnchor.constraintEqualToConstant(200).active = true
        
        
        submitButtonTopAnchor = submitButton.topAnchor.constraintEqualToAnchor(passwordConfirmTextField.bottomAnchor, constant: 300)
        submitButtonTopAnchor.active = true
        submitButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        submitButton.widthAnchor.constraintEqualToConstant(200).active = true
        
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if !textField.hasText() || !reportValidityError(textField) {
            
            warningAnimation(textField)
            
        }
    }
    
    func animateSubmitButton() {
        
        UIView.animateWithDuration(0.5) {
            self.submitButtonTopAnchor.active = false
            
            self.submitButtonTopAnchor.constant = 100
            
            print(self.passwordConfirmTextField.bottomAnchor)
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    func warningAnimation(textField: UITextField){
        flashRed(textField)
        scaleUpAndDown(textField)
    }
    
    func flashRed(textField: UITextField){
        UIView.animateWithDuration(0.2, delay: 0.0, options: [.Repeat,.Autoreverse], animations: {
            
            UIView.setAnimationRepeatCount(2.0)
            
            textField.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.3)
            
            self.view.layoutIfNeeded()
            
            }, completion: { (true) in
                
                textField.backgroundColor = UIColor.whiteColor()})
        
        self.view.layoutIfNeeded()
    }
    
    
    func scaleUpAndDown(textField: UITextField){
        
        UIView.animateWithDuration(0.30, delay: 0.0, options: [.Repeat, .Autoreverse], animations: {
            
            UIView.setAnimationRepeatCount(2.0)
            
            textField.transform = CGAffineTransformMakeScale(0.90, 1.0)
            
            self.view.layoutIfNeeded()
            
        }) { (true) in
            
            textField.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.view.layoutIfNeeded()
            
            
        }
    }
    
    func reportValidityError(textField: UITextField) -> Bool{
        
        guard let emailText = emailTextField.text where emailTextField.text  != nil else { print("No text value ")
            return false}
        
        guard let emailConfirm = emailConfirmationTextField.text where emailConfirmationTextField.text != nil else {print ("No Confirm Value")
            return false}
        
        guard let phoneText = phoneTextField.text where phoneTextField.text != nil else {print ("No Phone Value")
            return false}
        
        guard let passwordText = passwordTextField.text where passwordTextField.text != nil else { print("No Password value")
            return false
        }
        
        guard let passwordConfirm = passwordConfirmTextField.text where passwordConfirmTextField.text != nil else { print("no password confirm")
            return false
        }
        
        let isEmailTextFieldValid = emailText.containsString("@") && emailText.containsString(".")
        
        let isConfirmationValid = emailConfirm == emailText
        
        let characterSet:NSCharacterSet = NSCharacterSet(charactersInString: "0123456789")
        
        
        let containsOnlyNumbers = phoneText.rangeOfCharacterFromSet(characterSet.invertedSet) == nil
        
        let isPhoneValid = phoneText.characters.count >= 7 && containsOnlyNumbers
        
        let isPasswordValid = passwordText.characters.count >= 6
        
        let isPasswordConfirm = passwordConfirm == passwordText
        
        
        if let textAccessibilityLabel = textField.accessibilityLabel{
            
            print(textAccessibilityLabel)
            
            switch textAccessibilityLabel {
                
            case "emailTextField":
                
                return isEmailTextFieldValid
                
            case "emailConfirmTextField":
                
                return isConfirmationValid
                
            case "phoneTextField":
                
                return isPhoneValid
                
                
            case "passwordTextField":
                
                return isPasswordValid
                
            case "passwordConfirmTextField":
                
                return isPasswordConfirm
                
            default:
                
                return false
                
            }
        }
        
        return false
    }
    
    func checkForAllValid(){
        
        guard let emailText = emailTextField.text where emailTextField.text  != nil else { print("No text value ")
            return}
        
        guard let emailConfirm = emailConfirmationTextField.text where emailConfirmationTextField.text != nil else {print ("No Confirm Value")
            return}
        
        guard let phoneText = phoneTextField.text where phoneTextField.text != nil else {print ("No Phone Value")
            return}
        
        guard let passwordText = passwordTextField.text where passwordTextField.text != nil else { print("No Password value")
            return}
        
        guard let passwordConfirm = passwordConfirmTextField.text where passwordConfirmTextField.text != nil else { print("no password confirm")
            return}
        
        let isEmailTextFieldValid = emailText.containsString("@") && emailText.containsString(".")
        
        let isConfirmationValid = emailConfirm == emailText
        
        let characterSet:NSCharacterSet = NSCharacterSet(charactersInString: "0123456789")
        
        
        let containsOnlyNumbers = phoneText.rangeOfCharacterFromSet(characterSet.invertedSet) == nil
        
        let isPhoneValid = phoneText.characters.count >= 7 && containsOnlyNumbers
        
        let isPasswordValid = passwordText.characters.count >= 6
        
        let isPasswordConfirm = passwordConfirm == passwordText
        
        if isEmailTextFieldValid && isConfirmationValid && isPhoneValid && isPasswordValid && isPasswordConfirm {
            submitButton.enabled = true
            animateSubmitButton()
        } else {
            submitButton.enabled = false
        }
        
        
    }
    
}