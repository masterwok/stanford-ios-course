
# Developing iOS 11 Apps with Swift:

## Tips and Tricks:
 - Hold down option key, mouse over, and click class members to view documentation
   - You can copy and paste view components within the interface builder (don't forget to unbind copied actions if required)
 - Right-click to view view component binding
 - Can control-click from "view controller" in interface builder header to attach view components

## Recommendations:
 - When looking at documentation initially, always read "Overview" section of common classes

## Lecture 1: Introduction
 - You must initialize properties
 - Swift can infer types like C# and Kotlin
 - An "outlet" is an instance variable that points to a view component
 - Exclamation point allows for uninitialized properties
 - Swift has "property observers" like "didSet" which is executed everytime a property is set
 - View	components can be attached to the same action
 - An "outlet collection" is a collection of view components
 - Command-click gives you access to a menu which can be used to members
 - Swift has let for defining constants
 - Swift has null propagation and optionals (post-fix: ?)
 - Use bang (!) after optional to get value
 - Swift allows  for "if let" statement to conditionally unwrap optionals

## Lecture 2: Model View Controller (MVC)
 - Model, data (services, repositories, caches, etc.)
 - View, presentation (interface builder)
 - Controller, logic (UIViewController and derived classes)
 - Controllers reference views through outlets
 - Views call controller methods via bound actions
 - Delegates respond to a set of callbacks
 - Controllers use protocols to tell views that it's their delegate
 - Data source provides data from controller to view
 - Notifications (KVO) is the observer pattern and used by models to notify controllers of data changes
 - Two major differences between structs and classes in Swift:
    1. Structs, value types (values are copied) with no inheritance and value types
    2. Classes, reference types (values are referenced)
 - Instance initialization syntax: let foo = [Foo]()
 - init(..) method is the constructor in Swift
 - Free initializer for struct types must provide ALL properties
 - Free initializer for classes is only available when all properties are initialized
 - In swift self keyword is equivalent to this keyword in C#
 - Swift has for/in syntax
 - Swift supports ranges aka "countable range" (0...6, 0..\<n)
 - structs can be copied just by assigning them to another variable or by appending them to a collection
 - Swift lazy keyword allows for lazy initialization of properties (con: can't use property observers)
 - Dictionaries have a special initialization syntax: var dict = [Int:String]()

## Lecture 3: Swift 
 - Layout constraints are required due to variation in device sizes and device rotation
 - Control click view components and drag to create layout constraints to another view component
 - You can click constraints (blue lines) in iterface builder to inspect a constraint
 - Constraint distance can be modified with interface builder inspector by changing "constant" property
 - Ambiguous constraints will be show as warnings within the interface builder
 - Can fix frame constraint using document outline -> click yellow right arrow -> click triangle -> update frame/constraints/reset etc.
 - Can create constraint as, "Greater than or equal" to prevent constrained view components from streching
 - Floating point CountableRange can be done by using: for i in stride(from: 0.5, through: 15.25, by: 0.3)
 - Tuple, nothing more than a grouping of values
 - A Tuple can have more than two values
 - Can name tuple values: let (word, number, value) = x
 - Can define Tuple using: let x: (w:String, i: Int, v: Double) = ("hello", 5, 0.85)
 - Tuples are a valuable way to return multiple values from a function
 - Computed Properties, syntax similar to get/set of C#
   - You can have computed read-only properties by removing set function
 - Computed properties that are read only don't have to have get keyword defined
 - Swift access control aka visibility modifiers:
   - internal, default modifier ("usable by any object in my app or framework")
   - private, only callable from within this object
   - private (set), property is readable outside this object, but not settable
   - fileprivate, accessible by any code in this source file
   - public (framework only), this can be used by objects outside of the framework
   - open (framework only), public and objects outside the framework can subclass this
 - Outlets should almost always be private
 - The keyword, assert can be used to assert some condition is true: assert(n > 0, "This is some assertion error")
 - Extensions can be use to extend existing class/struct/enum values (similar to C#)
 - Enums can have associated data in Swift: switch Food { case hamburger(numberOfPatties: Int) }
 - Enums can have nameless associated data (associated data is similar to Tuple types)
 - Enum associated data can only be set at declaration of value
 - Enums can infer types: var otherItem: FastFoodMenuItem = .cookie
 - Switch statements must enumerate all enum values or use default to shortcircuit
 - Switch doesn't fall through by default (there is a fallthrough keyword to do this)
 - Switch must declare let of associated properties to get values (doesn't have to match defined name)
 - Switch cases can case multiple at the same time by seperating cases with comma
 - Enums can have functions and computed properties (no stored properties)
 - Enums can switch on self within computed property or function
 - You can modify self within enum by prefixing functions with "mutating" keyword
 - Structs also have to prefix functions with "mutating" keyword when self is mutated
 - Optional chaining exists within Swift (just like null-propagation in C#)
 - Essential data structures in Swift: class, struct, enum, protocol
 - Head is cleaned in Swift using reference counting (automatically handled by Swift)
 - Automatic Reference Counting can be influenced by strong, weak, and unowned
   - strong (default), normal reference counting
   - weak, means "if no one else is interested in this, then neither am I, set me to nil in that case" ("don't keep it in heap because of me!")
    - Only works with optional types
    - Commonly used in outlets and delegation
   - Unowned means "don't reference cout this; crash if I'm wrong"
    - This is very rarely used
    - Usually only to break memory cycles between objects (circular reference between objects referencing each other keeping themselves in heap)
 - Protocols are contracts (aka interfaces) that are fundamental to Swift


## Lecture 4: Protocols and Closures
 - Swift is smart enough to regonize mutability of properties (var)
 - Protocol, a *type* which is a declaration of *functionality only* (aka contract/interface)
 - Three parts of a protocol:
   - Declaration (which properties and methods are in the protocol)
   - Claim to implement protocol
   - The implementation in class claiming to implement protocol
 - @objc can be used for backwards compatibility for optional protocols from Objetive-C
 - All protocol declarations must be implemented in Swift
 - Declared using, "protocol" keyword
 - Protocols have inheritance just like C#
 - Protocol methods or vars that are expected to mutate state must be prefix, "mutating" keyword UNLESS protocol prefixed with class keyword
   - This is due to structs having the ability to implement protocols
 - You can even declare an innit() method
   - If implementing protocol in class must prefix init method with, "required" keyword to prevent subclasses from hiding init()
 - You can implement an extension on some type to implement a protocol as well
 - Can restrict methods to multiple protcols: func slipAndSlide(x: Slippery & Moveable)
 - Delegation is a very important (yet simple) use of protocols
   - It's a way to implement "blind communication" between views and controllers
 - How this works:
   - View declares a delegation protocol (i.e. what the view wants the controller to do for it)
   - The API of the view has a *weak delegate* property whose type is that delegation protocol
   - The view uses the delegate property to get/do things it can't own or control on its own
 - Protocols can define "type" methods using "Self" keyword in method signature
 - Equatable uses Self keyword to compare types (it's actually what == calls)
 - Extensions can be used to create a default implementations of protocols
 - Functional prograaming, the "evolution" of object-oriented programming
   - Focuses more on the behavior of data structures rather than storage
 - You can use a range over collection indices: let foo = bar[baz..\<bax]
 - String must be indexed carefully as they can contain unicode characters
 - Can use Array(string) to split strings by character
 - You can leave start and end indices off of ranges if type can be inferred
 - NSAttributedString, a string with attributes attached to each character (font, numbers, etc.)
 - Instantiated NSAttributedString uses strange syntax due to it being an old Objective-C library
   - For example: let attributes: [NSAttributedStringKey: Any] = { .strokeColor: UIColor.orange, .strokeWidth: 5.0 }
   - Attributed string instantiation: let attributedText = NSAttributedString(string: "Foo", attributes: attributes)
   - Then can set the label with: someLabel.attributedText = attributedText
 - Peculiarities of NSAttributedString
   - It's not a string it's a class
   - Since it's not a value type, you can't create a mutable NSAttributedString just by using var
   - To get mutability you have to use a subclass of it called NSMutableAttributedString
   - Built on top of NSString that uses slightly different encodings (can break indexes)
 - Function types:
   - You declare a variable (or parameter to a method or whatever) to be of type, "function"
   - Example declaration: var operation: (Double) -> Double
   - You can assign function types to variables just like any other value
   - Invocation is done just like calling any other method
 - Closures, used to create function "on-the-fly" rather than having to define them (aka inline functions)
   - Can use $0..n for parameter names: var operation: (Double) -> Double = { -$0 }
   - Array has a method called, "map" which takes a function as an argument and applies a mapping
   - For example: let foo = [1,2,3]; foo.map({ -$0 }); foo.map { String($0) }
   - If last argument to any function is a closure, then the function can be moved outside of parentheses
 - Closures can be used to do property initialization: var foo: Type = { return <init logic> }()
   - Combined with lazy keyword makes it more powerful
 - Closures are references types (gets put in the heap)
 - Closures capture referenced types and those are added to the heap too
   - Closure captures can create a circular reference if the captured instance contains a reference to the closure
     - Circular reference can be broken using unowned modifier

## Lecture 5: Drawing in iOS
 - Methods can throw errors in Swift
 - Methods that throw are postfixed with, "throws" keyword
 - Thrown errors can be caught using do/catch blocks
   - i.e. do { try foo.save() } catch let error { <handle error> }
 - iOS errors are commonly NSError instances
 - You can use try! foo.save() to force crash application
 - If you don't care about the error, you can ignore it with try? syntax
   - Changes the return type of throws method to an optional
 - Any & AnyObject are special types
   - Used commonly for compatibility with old Objective-C APIs
   - Not used so much anymore
   - Swift is a strongly typed language, can't invoke a method on an Any
     - Must convert to concrete type first
   - Don't use Any unless for backwards compatibility
   - Use "as?" operator to convert to an optional of the specified type
     - i.e. let foo = unknown as? SomeType
 - Can use as to cast to protocol
 - NSObject, base class for all Objective-C classes
   - Some advanced features will require you to subclass from NSObject
 - NSNumber, class that represents any kind of number
   - iOS Objective-C APIs automatically bridged to Swift types and vice-versa
 - Date, type to use when working with dates
   - Must be very careful when representing dates internationally
 - Data, type used to save/restore/transmit raw data throughout iOS SDK
 - A view (i.e. UIView subclass) represents a rectangular area
   - Defines a coordinate space
   - Handles drawing
   - Handles touch
   - Hierarchical
   - Views at top of stack cover all other views
   - Can clip its subviews
 - UIWindow at the very top of the view hierarchy (even includes status bar)
   - Usually only one UIWindow in an entire iOS application .. it's all about views, not windows
 - View hierarchy is generally built using Xcode but can be built in code as well
 - When removing view programatically, invoke removeFromSuperview() on view 
 - UIViewController root view is referenced by view property
   - This view will resize on rotation
 - Generally try to avoid initializer of views
   - Must override both init(frame: CGRect) and init(coder: NSCoder) when implementation to init is required
     - CGRect -> initializer for code
     - Coder -> initializer for storyboard
   - Must add required attribute to init coder method
 - awakeFromNib(), alternative to initializers in UIView
   - Will only work with views that come from the interface builder
   - Not an initializer
 - CGFloat, always use this instead of Double or Flat for anything to do with a UIView's coordinate system
   - Can convert to and from a Double or Float using initializers
 - CGPoint, a struct with two CGFloat instances (x and y)
 - CGSize, a struct with two CGFloat instances in it (width and height)
 - CGRect, a struct with a CGPoint and a CGSize
 - Origin is always in the upper-left corner
 - Units are points, not pixels due to different screen densities
 - To get the number of pixels per point see contentScaleFactor property of UIView
 - Bounds: CGRect, this is the rectangle containing the drawing space of the UIView
 - Frame has nothing to do with drawing (it is the coordinate system of the superview)
 - Frame != Bounds 100% of the time
 - To create a custom view drag out a UIView and then change its class to a custom subclass of UIView
 - You can create a view using: let newView = UIView(frame: customFrame) or: let newView = UIView()
 - To redraw view invoke either: setNeedsDisplay() or setNeedsDisplay(_ rect: CGRect)
 - NEVER invoke draw method directly let the system do it
 - Can use Core Graphics to draw or draw a path using UIBezierPath
 - Core Graphics Concepts:
   - Requires context, use UIGraphicsGetCurrentContext() to get context
   - Create paths (out of lines, ars, etc.)
   - Set drawing attributes (colors, fonts, textures, linewidths, linecaps, etc.)
   - Stroke or fill the above-created paths with the given attribute
 - UIBezierPath, does the same thing but is an OOP implementation
 - You can specify transparenty with withAlphaComponent on UIColor
   - You MUST set opaque property on view to false in order for transparency to work
 - The drawing for UIView is built on top of CALayer (Core Animation Layer)
   - cornerRadius, borderWidth, and borderColor are all properties of CALayer
 - A view can be hidden using the isHidden property of UIView
 - Drawing Text within draw(rect: CGRect) can be done using NSAttributedString
 - NSRange has an init which can handle the String vs. NSString indexing weirdness
 - Can use preferredFont method to get expected font in draw(_ rect: CGRect)
 - UIFontMetrics can be used to scale font when drawing text
 - Images are added to assets.xcassets
 - Can create UIImage using UIImage(data: someData) ... aka "bag o' bits" style
 - By default, when the bounds of a UIView change, there is *no redraw*
 - UIView property contentMode can be used to adjust drawing when bounds change
 - func layoutSubviews() can be used to adjust subviews on bounds change
   - Not required if using Auto Layout constraints

## Lecture 6: Multitouch and Multiple MVCs
 - Subclass CoCoa Touch when creating new cutom view
 - Custom UIView doesn't have to implement draw (as its children can draw)
 - To add custom view to storyboard, draw UIView out from components and then set the subclass to custom class
 - On rotation it's useful to change view "Scale To Fill" to "Redraw" so drawing scales correctly
 - Don't forget to clear "Opaque" flag in UIView properties when doing anything with transparency
 - Can use traitCollectionDidChange method to request redraw when text size is changed in settings
 - Changing a constraints priority can fix constraints when two or more collide
 - Control dragging from a view to itself allows it to fix its width, height, or aspect ratio
 - IBDesignable can be added to derived UIView as attribute to show in designer
 - IBInspectable can be added to derived UIView property to edit property in interface builer
 - Gestures are provided by iOS (we don't have to look at touches manually)
   - Gestures does by UIGestureRecognizer
   - Add a gesture recognizer to a UIView and provide a handle method for each gesture
 - Gesture usually addd to UIViewController
 - Gesture function is defined in view if it only modifies view state, else it's defined within the controller
 - Gesture recognizers are normally set within didSet of IBOutlet
 - Gestures have failed and cancelled states
 - Pan, pinch, rotation, swipe, tap, and along press

## Lecture 7: Multiple MVCs, Timer, and Animation
 - Topics:
  - Multiple MVCs
    - Tab Bar, Navigation, and Split View Conrollers
    - Demo: Theme Chooser in Concentration
  - Timer
  - Animation
 
















