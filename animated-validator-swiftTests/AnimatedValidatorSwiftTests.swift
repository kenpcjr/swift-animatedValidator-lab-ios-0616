//
//  AnimatedValidatorSwiftTests.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/29/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Nimble
import Quick
import KIF
@testable import animated_validator_swift

class ValidatorViewController: QuickSpec {
     //SpecBegin(ValidatorViewController)
    override func spec() {
        
        let tester = KIFUITestActor()
        func test(sender: AnyObject) {
        }
        
        let submitButton =  tester.waitForViewWithAccessibilityLabel(Constants.SUBMITBUTTON) as! UIButton
        
        describe("submit button:") {
        
            it("Should only enable button when all fields are valid") {
                
                
                tester.waitForTappableViewWithAccessibilityLabel(Constants.EMAILTEXTFIELD)
                tester.tapViewWithAccessibilityLabel(Constants.EMAILTEXTFIELD)
                tester.enterText("susan@flatironschool.com", intoViewWithAccessibilityLabel: Constants.EMAILTEXTFIELD)
                
                expect(submitButton.enabled).to(beFalse())
                
                tester.tapViewWithAccessibilityLabel(Constants.EMAILCONFIRMTEXTFIELD)
                tester.enterText("susan@flatironschool.com", intoViewWithAccessibilityLabel: Constants.EMAILCONFIRMTEXTFIELD)
                
                expect(submitButton.enabled).to(beFalse())
                
                tester.tapViewWithAccessibilityLabel(Constants.PHONETEXTFIELD)
                tester.enterText("6466440584", intoViewWithAccessibilityLabel: Constants.PHONETEXTFIELD)
                
                expect(submitButton.enabled).to(beFalse())
                
                tester.tapViewWithAccessibilityLabel(Constants.PASSWORDTEXTFIELD)
                tester.enterText("myPassword1", intoViewWithAccessibilityLabel: Constants.PASSWORDTEXTFIELD)
                
                expect(submitButton.enabled).to(beFalse())
                
                tester.tapViewWithAccessibilityLabel(Constants.PASSWORDCONFIRMTEXTFIELD)
                tester.enterText("myPassword1\n", intoViewWithAccessibilityLabel: Constants.PASSWORDCONFIRMTEXTFIELD)
                
                tester.tapViewWithAccessibilityLabel(Constants.EMAILTEXTFIELD)
                
                expect(submitButton.enabled).to(beTrue())
            }
        }
    }
}

