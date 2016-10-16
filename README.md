## PHDiff

Is a very efficient **diff algorithm** implementend in Swift with linear complexity in both time and space.

Based on Paul Heckel's paper: [A technique for isolating differences between files](http://dl.acm.org/citation.cfm?id=359467&dl=ACM&coll=DL&CFID=679858074&CFTOKEN=32818190).

Given two different arrays, A and B, what steps A has to make to become B? 

PHDiff can answer that by calculating the needed Inserts, Deletes, Moves and Updates!

**PHDiff can also provide batch updates for UITableView and UICollectionView changes**, it can be used right on the main queue because it's lightning fast.


## Requirements

- Xcode 8.0+
- Swift 3.0+


## Installation

### CocoaPods

To integrate PHDiff into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

target '<Your Target Name>' do
    pod 'PHDiff', :git => 'https://github.com/andre-alves/PHDiff.git', :tag => '1.0.1'
end
```

### Carthage

To integrate PHDiff into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "andre-alves/PHDiff" == 1.0.1
```

Run `carthage update` to build the framework and drag the built `PHDiff.framework` into your Xcode project.

### Manually

Simple copy the .swift files from the folder **Sources** to your project.


## Usage

Depending of the installation method, you may need to import PHDiff in the files that you use it:

```swift
import PHDiff
```
PHDiff provides two methods: **orderedSteps(fromArray:toArray:)** and **steps(fromArray:toArray:)** and they both return an array of DiffSteps:

```swift
public enum DiffStep<T> {
    case insert(value: T, index: Int)
    case delete(value: T, index: Int)
    case move(value: T, fromIndex: Int, toIndex: Int)
    case update(value: T, index: Int)
}
```

**orderedSteps(fromArray:toArray:)** calculates Inserts, Deletes and Updates in a ordered way that can be applied to the old array to transform it into the new array.

```swift
let a = ["a", "b", "c", "d"]
let b = ["e", "a","d"]
let steps = PHDiff.orderedSteps(fromArray: a, toArray: b)
print(steps)
//[Delete c at index: 2, Delete b at index: 1, Insert e at index: 0]
print(a.apply(steps: steps)) // apply each operation to the array
//["e", "a", "d"]
```

**steps(fromArray:toArray:)** calculates Inserts, Deleted, Moves and Updates to be used only with batch operations (i.e: UITableView and UICollectionView batch updates).

```swift
    private func updateTableView(newColors: [DemoColor]) {
        let steps = PHDiff.steps(fromArray: self.colors, toArray: newColors)

        if steps.count > 0 {
            tableView.beginUpdates()
            self.colors = newColors // update your model here

            var insertions: [IndexPath] = []
            var deletions: [IndexPath] = []
            var reloads: [IndexPath] = []

            steps.forEach { step in
                switch step {
                case let .Insert(_, index):
                    insertions.append(IndexPath(row: index, section: 0))
                case let .Delete(_, index):
                    deletions.append(IndexPath(row: index, section: 0))
                case let .Move(_, fromIndex, toIndex):
                    deletions.append(IndexPath(row: fromIndex, section: 0))
                    insertions.append(IndexPath(row: toIndex, section: 0))
                case let .Update(_, index):
                    reloads.append(IndexPath(row: index, section: 0))
                }
            }

            tableView.insertRows(at: insertions, with: .automatic)
            tableView.deleteRows(at: deletions, with: .automatic)
            tableView.reloadRows(at: reloads, with: .automatic)
            
            tableView.endUpdates()
        }
    }
```

**Important:**

- Both methods are linear in complexity and space.
- Do **not** apply the result from steps(fromArray:toArray:) to the 'fromArray'. The result is not ordered in a way that it expects the indexes offset changes caused by each other step. If you need this type of result, use **orderedSteps** instead.


In order to diff your models, they need to conform to the Diffable protocol:

#### Diffable Protocol

Diffable extends the Equatable protocol by providing one **diffIdentifier**. It can be a String, Int or anything that conforms to the Hashable protocol. You can think of it as a unique key to represent your object.

```swift
struct DemoColor: Diffable {
    let name: String
    let r: Float
    let g: Float
    let b: Float
    
    var diffIdentifier: String {
        return name
    }
}

func ==(lhs: DemoColor, rhs: DemoColor) -> Bool {
    return lhs.name == rhs.name && lhs.r == rhs.r && lhs.b == rhs.b && lhs.g == rhs.g
}
```

*Note: if your model conforms to Hashable, it does not need to implement diffIdentifier.*


## Acknowledgments

[Dwifft](https://github.com/jflinter/Dwifft) - Diff based on the LCS problem. Inspired me to use the same enum name 'DiffStep'.

[IGListKit](https://github.com/Instagram/IGListKit) - Uses diff which is also based on Paul Heckel paper. I copied the  concept of the protocol Diffable and a small optimization to avoid unnecessary moves.


## License

PHDiff is released under the MIT license. See LICENSE for details.
