import SwiftUI

public extension View
{
 /// Attaches a custom keyboard to the view
 ///
 /// - Parameters:
 ///   - type: The instance of `VLKeyboard` to be used as the custom keyboard
 ///
 /// - Returns: A modified view with the custom keyboard attached
 func keyboard(_ type: VLKeyboard) -> some View
 {
  self.modifier(VLKeyboard.Modifier(type))
 }
 
 /// Attaches a custom keyboard to the view with additional configuration options
 ///
 /// - Parameters:
 ///   - delegate: The delegate for text field interactions.
 ///   - view: A closure that returns a SwiftUI view representing the custom keyboard
 ///
 /// - Returns: A modified view with the custom keyboard attached.
 @MainActor func keyboard(delegate: (any UITextFieldDelegate)? = nil,
                          @ViewBuilder view: @escaping ((any UITextDocumentProxy, VLKeyboard.FeedbackHandler?, (any UITextFieldDelegate)?) -> some View)) -> some View
 {
  self.keyboard(VLKeyboard.Factory(delegate, view))
 }
}

extension VLKeyboard
{
 /// Internal modifier for integrating the `VLKeyboard` with SwiftUI views.
 ///
 /// - Note: This modifier is used internally and should not be accessed directly.
 fileprivate struct Modifier: ViewModifier
 {
  @State var type: VLKeyboard
  
  /// Initializes the modifier with the specified instance of `VLKeyboard`
  ///
  /// - Parameters:
  ///   - type: The instance of `VLKeyboard`.
  internal init(_ type: VLKeyboard)
  {
   self._type = State(wrappedValue: type)
  }
  
  internal func body(content: Content) -> some View
  {
   content
    .getTextField
    {
     textfield in
     textfield.inputView = type.keyboardInputView
     textfield.delegate = type.delegate
    }
   //  .onAppear { keyboardType.onSubmit = onCustomSubmit }
   //  .introspect(.textEditor, on: .iOS(.v15...)) { uiTextView in uiTextView.inputView = keyboardType.keyboardInputView }
   //  .introspect(.textField, on: .iOS(.v15...)) { uiTextField in uiTextField.inputView = keyboardType.keyboardInputView }
  }
 }
}
