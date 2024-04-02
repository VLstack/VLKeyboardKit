import Foundation
import UIKit
import SwiftUI

public class VLKeyboard: UIInputViewController, ObservableObject
{
 public typealias SystemFeedbackHandler = () -> ()
 
 public private(set) lazy var keyboardInputView = VLKeyboardInputView(keyboardUIView: keyboardView)
 
 internal var keyboardView: UIView! = nil
 internal var playSystemFeedback: SystemFeedbackHandler? = UIDevice.current.playInputClick
 
 override public var view: UIView!
 {
  get { keyboardInputView }
  set {}
 }
}
