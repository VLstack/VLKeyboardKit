import UIKit

/**
 `VLKeyboard` is a SwiftUI custom keyboard input view controller that extends `UIInputViewController`.
 It provides functionality for managing a custom keyboard input view to use with TextField.
*/
public class VLKeyboard: UIInputViewController
{
 /// A closure type for handling feedback events.
 public typealias FeedbackHandler = () -> ()
 
 /// The delegate for text field interactions.
 public var delegate: UITextFieldDelegate? = nil

 /// The custom keyboard input view.
 public private(set) lazy var keyboardInputView = VLKeyboard.InputView(keyboardView)
 
 /// The underlying keyboard view.
 internal var keyboardView: UIView! = nil

 /// The feedback closure for input events.
 internal var feedback: FeedbackHandler? = UIDevice.current.playInputClick
 
 /// Overrides the default view property with the custom keyboard input view.
 override public var view: UIView!
 {
  get { keyboardInputView }
  set {}
 }
}
