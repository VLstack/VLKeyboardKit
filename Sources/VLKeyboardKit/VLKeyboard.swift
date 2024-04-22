import UIKit

/// `VLKeyboard` is a SwiftUI custom keyboard input view controller that extends `UIInputViewController`
///
/// Provides functionality for managing a custom keyboard input view to use with TextField
public class VLKeyboard: UIInputViewController
{
 /// Closure type for handling feedback events
 public typealias FeedbackHandler = () -> ()
 
 /// Delegate for text field interactions
 public var delegate: (any UITextFieldDelegate)? = nil

 /// Custom keyboard input view
 public private(set) lazy var keyboardInputView = VLKeyboard.InputView(keyboardView)
 
 /// Underlying keyboard view
 internal var keyboardView: UIView! = nil

 /// Feedback closure for input events
 internal var feedback: FeedbackHandler? = UIDevice.current.playInputClick
 
 /// Overrides the default view property with the custom keyboard input view
 override public var view: UIView!
 {
  get { keyboardInputView }
  set {}
 }
}
