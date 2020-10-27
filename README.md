# Generics usage

How and why do you need to use Generics in your swift project? You can find answers in a  [presentation](https://docs.google.com/presentation/d/1-VW6_-a9RzLLtF6WH7098QJodP-5sfD8V2FP7XwLKMc/edit?usp=sharing) or [video](https://web.microsoftstream.com/video/bf7c187a-c217-440e-813f-0d24caf034f5). Also, you can find more information about Generics in the book "Swift in Depth" in this repository (p.170).

# Examples
# Generics for Storyboards 

**Extension**
```Swift
protocol Storyboardable {
    static var flow: Flow { get }
}

extension UIViewController {
    func initFromStoryboard<T>(of type: T.Type) -> T where T: UIViewController & Storyboardable {
       
        let stringID = String(describing: type)
        let storyboard = UIStoryboard.storyboard(with: T.flow)
        guard let vc = storyboard.instantiateViewController(withIdentifier: stringID) as? T else {
            fatalError("Could not instantiate initial storyboard with name: ")
        }
        return vc
    }
}
```

**Usage**
```Swift
let vc = self.initFromStoryboard(of: PhotosListViewController.self)
navigationController?.pushViewController(vc, animated: true)
```

# Generics for TableViews 

**Extension**
```Swift
extension UITableView {
    
    func register<T: UITableViewCell>(of type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type.self))
    }
    
    func register<T: UITableViewCell>(of type: T.Type) where T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: type.self))
    }
    
    func tableViewCell<T: UITableViewCell>(of type: T.Type, path: IndexPath) -> T {
          guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: type.self), for: path) as? T else {
              fatalError(String(describing: type.self) + " not found")
          }
          return cell
    }
}
```

**Usage**
```Swift
private func setupTableView() {
    tableView.register(of: PictureTableViewCell.self)
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.tableViewCell(of: PictureTableViewCell.self, path: indexPath)
    cell.configureWith(info: photos[indexPath.row])
    return cell
}
```


Developed By
------------

* Roman Maiboroda, Vlad Kosyi, CHI Software

License
--------

Copyright 2020 CHI Software.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
