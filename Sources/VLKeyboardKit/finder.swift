import SwiftUI

extension View
{
 /// Retrieves the underlying UITextField from a SwiftUI view and allows customization
 ///
 /// - Parameters:
 ///   - customize: A closure that provides access to the retrieved `UITextField` for customization
 ///
 /// - Returns: A modified view with the customization applied
 public func getTextField(_ customize: @escaping (UITextField) -> ()) -> some View
 {
  self.background(VLKeyboard.FindTextField(customize))
 }
}

extension VLKeyboard
{
 /// A UIViewRepresentable structure for finding and customizing a `UITextField` in a SwiftUI view hierarchy
 ///
 /// - Note: This structure is used internally and should not be accessed directly
 fileprivate struct FindTextField: UIViewRepresentable
 {
  let customize: (UITextField) -> Void
 
  /// Initializes the `FindTextField` structure with the specified customization closure
  ///
  /// - Parameters:
  ///   - customize: A closure that provides access to the retrieved `UITextField` for customization
  public init(_ customize: @escaping (UITextField) -> Void)
  {
   self.customize = customize
  }
  
  /// Creates a new `UIView` instance
  ///
  /// - Parameters:
  ///   - context: The context in which the view is being created
  ///
  /// - Returns: A new `UIView` instance.
  public func makeUIView(context: UIViewRepresentableContext<FindTextField>) -> UIView
  {
   UIView(frame: .zero)
  }
  
  /// Updates the `UIView` with the customization closure
  ///
  /// - Parameters:
  ///   - uiView: The `UIView` being updated
  ///   - context: The context in which the view is being updated
  public func updateUIView(_ uiView: UIView,
                           context: UIViewRepresentableContext<FindTextField>)
  {
   DispatchQueue.main.asyncAfter(deadline: .now())
   {
    guard let textfield: UITextField = self.getTarget(uiView)
    else { return }
    self.customize(textfield)
   }
  }
  
  /// Finds the target `UITextField` in the SwiftUI view hierarchy
  ///
  /// - Parameters:
  ///   - view: The root view from which to start searching
  ///
  /// - Returns: The target `UITextField`, if found; otherwise, `nil`
  private func getTarget(_ view: UIView) -> UITextField?
  {
   guard let viewHost: UIView = getViewHost(view)
   else { return nil }
   
   return firstSibling(viewHost)
  }
  
  /// Finds the `UIView` hosting the SwiftUI view hierarchy
  ///
  /// - Parameters:
  ///   - viewHost: The root view to search for the hosting `UIView`
  ///
  /// - Returns: The hosting `UIView`, if found; otherwise, `nil`
  private func getViewHost(_ viewHost: UIView) -> UIView?
  {
   var superview = viewHost.superview
   while let s = superview
   {
    if NSStringFromClass(type(of: s)).contains("ViewHost")
    {
     return s
    }
    
    superview = s.superview
   }
   
   return nil
  }
  
  ///  Finds the first sibling `UITextField` in the SwiftUI view hierarchy
  ///
  /// - Parameters:
  ///   - viewHost: The root view from which to start searching
  ///
  /// - Returns: The first sibling `UITextField`, if found; otherwise, `nil`
  private func firstSibling(_ viewHost: UIView) -> UITextField?
  {
   guard let superview = viewHost.superview,
         let index = superview.subviews.firstIndex(of: viewHost)
   else { return nil }
   
   for subview in superview.subviews[index..<superview.subviews.endIndex]
   {
    if let typed = findChild(subview)
    {
     return typed
    }
   }
   
   return nil
  }
  
  /// Recursively searches for a `UITextField` within a view hierarchy
  ///
  /// - Parameters:
  ///   - root: The root view from which to start searching
  ///   
  /// - Returns: The first found `UITextField`, if any; otherwise, `nil`
  private func findChild(_ root: UIView) -> UITextField?
  {
   for subview in root.subviews
   {
    if let typed: UITextField = subview as? UITextField
    {
     return typed
    }
    
    if let typed: UITextField = findChild(subview)
    {
     return typed
    }
   }
   
   return nil
  }
 }
}
