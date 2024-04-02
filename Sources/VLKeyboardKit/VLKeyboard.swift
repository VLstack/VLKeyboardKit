import UIKit
import Observation

@Observable
public class VLKeyboard: UIInputViewController
{
 public typealias FeedbackHandler = () -> ()
 
 public var delegate: UITextFieldDelegate? = nil

 @ObservationIgnored
 public private(set) lazy var keyboardInputView = VLKeyboard.InputView(keyboardView)
 
 @ObservationIgnored
 internal var keyboardView: UIView! = nil

 @ObservationIgnored
 internal var feedback: FeedbackHandler? = UIDevice.current.playInputClick
 
 @ObservationIgnored
 override public var view: UIView!
 {
  get { keyboardInputView }
  set {}
 }
}
