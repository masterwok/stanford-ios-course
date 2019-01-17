
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
- To redraw view invoke either: setNeedsDisplay() or setNeedsDisplay(\_ rect: CGRect)
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
- Can use preferredFont method to get expected font in draw(\_ rect: CGRect)
- UIFontMetrics can be used to scale font when drawing text
- Images are added to assets.xcassets
- Can create UIImage using UIImage(data: someData) ... aka "bag o' bits" style
- By default, when the bounds of a UIView change, there is \*no redraw\*
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
- iOS provides some controllers whose view is other controllers (MVCs)
  1. UITabbarController
  2. UISplitViewController, puts two MVCs side-by-side
    - Smaller MVC is called, "master"
    - Larger MVC is called, "detail"
  3. UINavigationController, the most flexible/powerful controller (stack of MVCs)
    - Top are is drawn by the UINavigationController
    - Contents of the top area are determined by the MVC currently presented
    - Each MVC communicates contents using UIViewController#navigationItem
    - Push/pop MVCs from navigation stack (popped MVCs are destroyed)
    - UINavigationController#rootViewController is a very important property that sets the initial MVC
- UIViewController#viewControllers contain child MVCs
  - Navigation controller index 0 is root
  - Tab controller index 0 is left tab controller
- Every UIViewController knows the Split View, Tab Bar, or Navigation Controller it's current in
  - There are UIViewController properties for determining parent(s)
    1. tabBarController: UITabBarController?
    2. splitViewController: UISplitViewController?
    3. navigationController: UINavigationController?
- Adding/removing MVCs from a UINavigation controller is generally done with segues but can be done programatically
  - UIViewController#pushViewController(..)
  - UIViewController#popViewController(..)
- MVCs are wired up just like views by dragging them out into interface builder
- UISplitViewController can only do its thing on iPad/iPhone+
  - Because of this, we generally wrap the split view contrller in a navigation controller
- Segues, allow for navigation between view controllers
  - They ALWAYS CREATE A NEW MVC
  - Types:
    - Show segue, will push in a navigation controller, else modal
    - Show detail, will show in a detail of a split view or will push in a navigation controller
    - Modal segue, will take over the entire screen while the MVC is up
    - Popover segue, will make the MVC appear in a little popover window
- Create segues between MVCs using control-click drag
- Segues should always be named
- Can perform segues manually using #performSegue(..)
- #preparse(for segue: UIStoryboardSegue, sender: Any?) -> Used to prepare the next controller being navigated to
  - Probably the most important method in navigation
- UIStoryboardSegue#destination is the UIViewController being navigated to (must be cast) -> use as? type cast
- Preperation of segue occurs BEFORE outlets are bound (this is a very common bug)
- UIViewController#shouldPerformSegue can be used to block segues
- Timer, use to execute code periodically
  - Can be used to go off once at some point in the future, or to repeatedly go off
  - If repeatedly, the system will not guarantee exactly when it goes off
  - Generally not used for animation
  - Invoked using Timer.scheduledTimer(..)
  - Timer reference should be defined as weak (this allows timer to be set to nil as soon as it's stopped)
  - Stop timer using Timer#.invalidate()
    - Run loop will give up its strong pointer to this timer (if weak reference to Timer, then timer is set to nil)
  - Tolerance, used to help system performance (allows late firing)
    - i.e. fooTimer.tolerance = 10 // Allow timer to execute +/- 10 seconds
    - Firing time is relative to the start of the timer (not the last time it fired), i.e. no "drift" due to tolerance
  - Timers will not execute when the app is in the background (more on this in app-lifecycle section)
- Kinds of animation:
  - Animating UIView properties, changing things like frame to transparency
  - Animating controller transitions (beyond scope of course)
  - Core animation, underlying powerful animation framework (beyond scope of course)
  - OpenGL and Metal, 3D
  - SpriteKit, "2.5D" like mario animations (images moving around over each other, etc.)
  - Dynamic Animation, animation using "physics"

## Lecture 8: Animation
- You can animate UIView properties (frame/center, bounds, transform, alpha, and background color)
- Done with class UIViewPropertyAnimator using closures
- UIViewPropertyAnimator.#runningPropertyAnimator(..) is the easiest way to use UIViewPropertyAnimator
- You can chain animations as well
- ANIMATION happens instantaneously, PRESENTATION happens over time
- UIViewAnimationOptions
  - beginFromCurrentState, pick up from other, in-progress animations of these properties
    - Used quite a bit when animations overlap
  - allowUserInteraction, allow gestures to get processed while animation is in progress
  - layoutSubviews, animate the relayout of subviews with a parent's animation
  - repeat, repeat indefinitely
  - autoreverse, playing animation forwards, then backwards
  - overrideInheritedDuration, if not set, use duration of any in-progress animation
  - overrideInheritedCurve, if not set, use curve (e.g. ease-in/out) of in-progress animation
  - allowAnimatedContent, if not set, just interpolate between currents and end "bits"
  - curveEaseInEaseOut, slower at the beginning, normal throughout, then slow at end
  - curveEaseIn, slower at the beginning, but then constant through the rest
  - curveLinear, same speed throughout
- UIView.transition(..), used to animate entire view
  - Flipping, cross-dissolving, etc.
- Dynamic Animation, set up physics relating animatable object and let them run until they resolve to stasis.
    1. Create UIDynamicAnimator: var animator = UIDynamicAnimator(referenceView: UIView), must be root UIView to all views to be animated
    2. Create and add UIDyanmicBehavior instances: let gravity = UIGravityBehavior(); animator.addBehavior(gravity)
    3. Add items to behaviors: let item1: UIDyanmicItem = ?; gravity.addItem(item1);
- If you change center or transform while the animator is running, then invoke UIDynamicAnimator#.updateItmeUsingCurrentState(item: UIDyanmmicItem)
- Behaviors:
  1. UIGravityBehavior, simple gravity
  2. UIAttachmentBehavior, bar between two fixed items (can oscillate like a spring)
  3. UICollisionBehavior, views bouncing off of each other
    - Only check for collisions per frame so items can escape or move through boundaries
  4. UISnapBehavior, snaps to a position but feels natural
  5. UIPushBehavior, pushes a view (either once or continuously)
  6. UIDynamicItemBehavior, meta-behavior like rotation, friction, and elasticity
  7. UIDynamicBehavior, superclass of all behaviors (used to collect all other behaviors)
    - Add children using UIDynamicBehavior#addChildBehavior(UIDyanmicBehavior)
    - UIDynamicBehavior#.action property is invoked everytime a behavior is executed on a view
- Stasis, view coming to stop
- UIDyanimcAnimator delegate tells you when animation pauses

Closure capturing:

The following class has a circular reference:

```swift
class Zerg {
  private var foo = {
    self.bar()
  }

  private func bar() {
  }
}
```

The circular reference is created because the foo closure references self and the Zerg class references the foo closure.

To break the circular reference, use weak references (weak keyword):

```swift
class Zerg {
  // weakSelf can be named self
  // private var foo = { [weak self] in
  private var foo = { [weak weakSelf = self] in
    weakSelf?.bar()
  }

  private func bar() {
  }
}
```

- Unowned reference keyword can be used when we know a reference is in the heap (allows us to avoid optional reference)

Flip animation example:

```swift
UIView.transition(
    with: cardView
    , duration: 0.6
    , options: [.transitionFlipFromLeft]
    , animations: {
	cardView.isFaceUp = !cardView.isFaceUp
    }
)
```

## Lecture 0: View Controller Lifecycle and Scroll Views
- UIViewControllers have a lifecycle just like Activity instance on Android
- A lifecycle is a sequence of invoked methods
- Important because we might want to do certain things at different points in the lifecycle.
- Lifecycle:
  1. Preparation
  2. Appear and disappear
  3. Geometry changes
  4. Low memory situations
- Always invoke super method in lifecycle methods
- viewDidLoad(), is used for primary initialization
  - Do not put geometry-related setup here (bounds are not yet set)
  - Only invoked once
- viewWillAppear(), view controller is about to appear on screen (load data into view)
  - Invoked everytime the view appears on screen
- viewDidAppera(), invoked after the view moves on-screen
  - Could be used to start an animation, timers, or variations
  - Also a good place to perform an expensive task, i.e. network requests
- viewDidDisappear(), used to clean up state (rarely used)
- Geometry, should be done in viewWillLayoutSubvies() and viewDidLayoutSubviews()
  - Usually don't need to do anything here because of Autolayout
  - Don't set geometry in viewDidLoad()!
- didReceiveMemoryWarning(), invoked when device is running low on memeory
  - It's rare that this is invoked but it does happen
  - This is iOS asking, "please release anything you're not using from the heap"
  - iOS will kill your application if your app leaks a bunch of memory (don't be a bad programmer)
- awakeFromNib(), invoked on all objects that originate in a storyboard
  - Can initialize stuff very early
  - It happens way before outlets are set and before you're prepared as part of a segue
  - Should be used as a last resort
  - Primarily used for situations where code has to be executed VERY EARLY in the lifecycle

Lifecycle Summary:

1. Instantiated (from storyboard usually)
2. awakeFromNib (only if instantiated from a storyboard)
3. Segue preperation happens
4. Outlets are set
5. viewDidLoad(), etc.
6. viewWillAppear() and viewDidDisappear() invoked everytime controller view goes on or off screen
  -The "geometry changed" methods might be called at any time after viewDidLoad
  - viewWillAppear()
  - viewWillDisappear()
7. Anytime memory gets low iOS might invoke didReceiveMemeoryWarning

- UIScrollView is added to a view just like any other view
  - Biggest difference is specifying the contentSize property
  - Can be dragged out
  - Can select view and click embed in scroll view
  - Create in code
- ContentSize, tells the scroll view the size of the scroll area
- contentOffset, the upper left-hand corner of what's being shown 
- Zooming can be done using UIView#.transform property
  - Will affect the content size of the scroll view
  - UIScrollView modifies the transform of the view automatically when zooming
  - Won't work without min/max zoom scale being set
    - scrollView.minimumZoomScale = 0.5 // 0.5 means half its normal size
    - scrollView.maximumZoomScale = 2.0 // 2.0 means twice its normal size
  - Won't work without delegate method to specify view to zoom
    - `func viewForZooming(in scrollView: UIScrollView) -> UIVIew`
  - Can zoom programatically

## Lecture 10: Multithreading and Autolayout
- Multithreading, how to handle long-running/blocking activity (i.e. network requests)
  - Mostly about "queues" in iOS
  - Functions (usually closures) are simply lined up in a queues
  - These functions are then pulled off the queue and executed on an associated thread(s)
  - Queues can be "serial" (one closure at a time) or "concurrent" (multiple threads servicing it)
- Main Queue, a serial queue that ALL UI work is done on
  - All UI activity MUST occur on this queue or a crash will occur
  - Conversely, all non-UI activity should NOT be on the main queue
  - This is done to create a highly responsive application
  - We also do this because we want things that happen in the UI to be predictable (serial)
  - Functions are pulled off and worked on in the main queue only when it is "quiet"
- Global Queue, used for non-UI work that are usually global and concurrent
- Get the main queue using: `DispatchQueue.main`
- Global queues (varying levels of "Quality of Service"):
  1. DispatchQoS.userInteractive, high priority, only do something short and quick
    - Example: user is drag and dropping
  2. DispatchQoS.userInitiated, high priority, but it might take a bit more time
    - Something that takes some amount of time but it was asked for by user (button touch, etc.)
  3. DispatchQoS.background, not directly initiated by user, so can run as slow as needed
    - Things the user hasn't asked for right away, but things they expect
  4. DispatchQos.utility, long-running background processes, low priority
    - Things that an app wants to do but is a low priority

Put a block of code on the queue (almost always use the first option):

1. queue.async { .. }, put a closure on the queue and keep running on the current queue
2. queue.sync { .. }, put a closure on the current queue and wait until the closure finishes on the other queue

You may need to (rarely) create a non-blocking queue.

1. Serial queue: `let serialQueue = DispatchQueue(label: "serialQueue")`
  - Use only when you have multiple, serially dependent functions
2. Concurrent queue: `let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)`
  - Almost never create a custom concurrent queue (should just use global queue)

Can also do more with Grand Central Dispatch (GCD)
 - Locking
 - Protecting critical sections
 - Readers and writers
 - Synchronous dispatch
 - And much more..

There is another API to multithreading (usually we use the DispatchQueue API)
 - APIs: OperationQueue and Operation
 - Operation API is used for more compilicated dependency dependent multithreading

- There are APIs on iOS where work is done on the background thread
  - If API result needs to update UI dispatch it back to the main queue

URLSession is the preferred way of making HTTP requests in iOS:

```swift
let session = URLSession(configuration: .default)

if let url = URL(string: "http://stanford.edu/...") {
  let task = session.dataTask(with: url) { (data: Data?, response, error) in
    // This closure is executed off of the main thread (must dispatch UI work back to main)
  }
  
  task.resume()
}

```

- DispatchWorkItem can be used to cancel pending asynchronous work
- Autolayout is sometimes not enough
  - Sometimes the geometry changes so dramatically that simple autolayout can't cope
- A UIViewController#.size property says what sort of room it has to layout in
  - It's not an exact number or dimension, it's eitehr "compact" or "regular" width or height
- iPhone:
  - All iPhones in portrait are compact in width and regular in height
  - All non-Plus size iPhones in landscape mode are compact in both directions
- iPhone Plus:
  - iPhone plus is also compact in width and regular in height in portrait
  - When in landsacpe it has regular width and compact height
- iPad:
  - Always regular in both directions
  - Depending on the environment and MVC it's in, it may be compact (e.g. UISplitViewController)

What can we do based on our size class?
- You can vary many properties in the UIView
- Most importantly, you can bind your CONSTRAINTS to your size class
  - Interface Builder has full support for this feature

When deleting size class constraints **DO NOT DELETE THEM FROM DOCUMENT OUTLINE**

Delete them by clicking the view and clicking the ruler (you'll know you've deleted them correctly when the constraint changes to a lighter shade).

You can check the size class programmatically by doing the following (useful for presenting data in different ways):


```swift

// Set string based on vertical class
let string = traitCollection.verticalSizeClass == .compact 
  ? "foo" 
  : "bar";


func traitCollectionDidChange(..) // Lifecycle method required when using size properties manually
```

## Lecture 11: Drag and Drop, UITableView and UICollectionView
- While dragging, user can use other finger to interact with other application

A view adds an interaction for drag and drop similarily to how gesture recongnizers are registered:

```swift
let dragInteraction = UIDragInteraction(delegate: someDelegate)
view.addInteraction(dragInteraction)
```

After registration, the delegate will be invoked if a drag occurs on the view.

When the user make are dragging gesture, the delegate invokes:

```swift
func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem]
```

The view returns the items it is willing to have dragged from the view. If nil is returned, then nothing is dragged.

- Drag and drop is completely asynchronous

Do the following to decalre UIDragItem instances:

```swift
let dragItem = UIDragItem(itemProvider: NSItemProvider(object: provider))
```

Built in providers:
- NSAttributedString
- NSString
- UIImage
- NSURL
- UIColor
- MKMapItem
- CNContact

You can declare your own drag and drop providers, but that is beyond the scope of this course.

Note that some of the providers are prefixed with NS, this means you have to use `as?` to cast them.

You can add items to a drag by doing the following:

```swift
func dragInteraction(_ interaction: UIDragInteraction, itemsForAddingTo sesssion: UIDragSession) -> [UIDragItem]
```

### Drag Destination:

When a drag moves over a view with a **UIDragInteraction**, the following is invoked:

```swift
func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDragSession) -> Bool
```

At which point the delegate can refuse the drop before it even gets started.

To determine if this is a valid destination for the items being dragged, you may do the following:

```swift
let stringAvailable = session.canLoadObjects(ofClass: NSAttributedString.self)
let imageAvailable = session.canLoadObjects(ofClass: UIImage.self)
```

Then return whether or not you want to act as a destination for the items (canHandle).

If accepted, the destination will have the following invocation:

```swift
func dropInteraction(
  _ interaction: UIDropInteraction
  , sessionDidUpdate session: UIDragSession
) -> UIDropProposal
```

To which you respond with: `UIDropProposal(operation: .copy)` (or .move, .cancel)

.cancel, drop will be refused
.copy, drop will be accepted
.move, drop would be accepted and would move the item (only for drags within an app)

If all goes well, the following will be invoked:

```swift
func dropeInteraction(
  _ interaction: UIDropInteraction
  , performDrop session: UIDropSession
```

This method will be implemented by invoking `loadObjects(ofClass:)` on the session. This method will 
go and fetch the data **asynchronously** from whomever the drag source is.

```swift
session.loadObjects(ofClass: NSAttributedString.self) { theStrings in
  // Do somehting with the dropped NSAttributedStrings (executed on main thread)
}
```

You can call multiple `loadObjects(ofClass:)` for different types. Normally nothing else is done within dropInteraction(performDrop:).


### UITable and UICollection View
- Both are subclasses of UIScrollView
- Display unbounded amounts of information
- UITableView presents information in a long (possibly sectioned) list
- UICollectionView presents information in a custom 2D format (usually "flowing" like in text flows)
  - Default is "flow" layout
- They are very similar in their API

#### UITableView

Four built in ways ways of displaying simple information:
1. Subtitle Style (title and description)
2. Left Detail Style, everything is left aligned
3. Right Detail Style, detailed information is on the right
4. Basic Style, no description displayed
5. Custom Style, allows for custom view and is very powerful (common)

UITableView allows rows to be grouped into seections (default is plain style)

#### UICollectionView

- A UICollectionView is configurable to show information in any 2D arrangement.
- By default entries are shown in "text flow" style (left-to-right and top-to-bottom). 
- There is only "custom" layout of information.

#### Usage of UITableView and UICollectionView

Interface builder not only provides UITableView and UICollectionView but also UITableViewController and UICollectionViewController.

If your interface is entirely consists of either a UITableView or UICollectionView use the controllers.

**Where does the data come from?**
The most important thing to remember is how they get the data they're presenting.

Each type has a property called "datasource"  which is a protocol with methods that supply the data (exactly like delegates).

Each type also has a delegate  which handles presentation logic.

UITableView:
```swift
var dataSource: UITableViewDataSource
var delegate: UITableViewDelegate
```

UICollectionView:
```swift
var dataSource: UICollectionViewDataSource
var delegate: UICollectionViewDelegate
```

These properties are implicitly st for you if you use the prepackaged MVCs.

If you drag out a UITableView or UICollectionView (not the controllers), then you must set these vars yourself.

The protocol for retrieving data has three main methods:

```swift
// UITableView
func numberOfSection(in tableView: UITableView) -> Int
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

// UICollectionView
func numberOfSection(in collectionView: UICollectionView) -> Int
func collectionView(_ tableView: UICollectionView, numberOfRowsInSection section: Int) -> Int
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionView
```

**Index Path**, specifies which row (UITableView) or cell (UICollectionView) we're talking about.

To get the section the row or cell is in use: `indexPath.section`

To get the row (while working with UITableView) use: `indexPath.row`
To get the cell (while working with UICollectionView) use: `indexPath.item`

A UITableView will reuse cells for efficancy.
- When a cell moves off screen, it goes into a reuse pool
- When loading a cell we invoke `dequeueReusableCell(withIdentifier:)` to get a cell from this pool
- If the pool is empty, then a cell is created by copying a prototype cell configured in the storyboard

Implementing UITableView#.cellForRowAt:
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let prototype = decision 
    ? "FoodCell" 
    : "CustomFoodCell" 

  let cell = tableView.dequeueReusableCell(withIdentifier: prototype, for: indexPath)

  // Configure the cell
  cell.textLabel?.text = food(at: indexPath)
  cell.detailTextLabel?.text = emoji(at: indexPath)
}
```

Custom UITableViewCell:
-We need outlets to the custom components within the cell.
-Outlets must be defined on the view (not the controller)

For example:
```swift
class CustomTableViewCell : UITableViewCell {
  @IBOutlet var name: UILabel
  @IBOutlet var emoji: UILabel
  @IBOutlet var details: UILabel
}
```

In order to access these outlets, we must cast the cell in the `cellForRowAt` implementation.

UITableView can set its content to static cells. This will allow you to define **each** cell within interface builder.
1. Set "Content" to "Static Cells" value
2. Inspect the "Table View" section in the document outline and then add rows using the inspector

-You can set the "Detail Disclosure Accessory" to add two segues to the same table row.

Data can be reloaded by invoking `func reloadData()` can also refresh by row.

A row can be set using static height with the `UITableView#.rowHeight: CGFloat` or it can be determined using autolayout with `UITableViewAutomaticDimension`

If you do automatic, help the table view by setting the `estimatedRowHeight`

You can also implement `func tableView(UITableView, {estimated}heightForRowAt indexPath: IndexPath) -> CGFloat` to optimize height calculations.


### Table View Headers

Setting a header for each section can be done by implementing: `func tableView(_ tableView: titleForHeaderInSection section: Int) -> String?`

You can also set a custom view header.

### Collection View Headers

1. Inspec the collection view and enable the section header
2. Must create a subclass of UICollectionReusableView
3. Must implement `collectionView#.viewForSupplementatryElementOfKind`
4. Use `deqeueReusableSupplementaryView`












































