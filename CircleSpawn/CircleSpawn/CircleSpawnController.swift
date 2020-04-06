import UIKit

class SpawnedViewSpawnController: UIViewController, UIGestureRecognizerDelegate {
    
    
    private let size: CGFloat = 100
    
    var offset: CGPoint = CGPoint(x: 0.0, y: 0.0)

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleDoubleTap(_ tap: UITapGestureRecognizer) {
        let spawnedView = CircleView(color: UIColor.randomBrightColor(), center: tap.location(in: view))
        view.addSubview(spawnedView)
        
        spawnedView.alpha = 0
        spawnedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, animations: {
            spawnedView.alpha = 1
            spawnedView.transform = .identity
        })
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap(_:)))
        tripleTap.numberOfTapsRequired = 3
        spawnedView.addGestureRecognizer(tripleTap)
        tap.require(toFail: tripleTap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        spawnedView.addGestureRecognizer(longPress)
    }
    
    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            tap.view?.alpha = 0
            tap.view?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { completed in
            tap.view?.removeFromSuperview()
        })
    }
    
    @objc func handleLongPress(_ longPress: UILongPressGestureRecognizer) {
        
            switch longPress.state {
            case .began:
                UIView.animate(withDuration: 0.2, animations: {
                    longPress.view?.alpha = 0.5
                    longPress.view?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                })
                
                offset.x = (longPress.view?.center.x)! - longPress.location(in: view).x
                offset.y = (longPress.view?.center.y)! - longPress.location(in: view).y
            case .changed:
                longPress.view?.center.x = offset.x + longPress.location(in: view).x
                longPress.view?.center.y = offset.y + longPress.location(in: view).y
            case .ended, .cancelled:
                UIView.animate(withDuration: 0.2, animations: {
                    longPress.view?.alpha = 1
                    longPress.view?.transform = .identity
                    longPress.view?.center.x = self.offset.x + longPress.location(in: self.view).x
                    longPress.view?.center.y = self.offset.y + longPress.location(in: self.view).y
                })
            default:
                return
            }
        }
}


extension CGFloat {
  static func random() -> CGFloat {
    return random(min: 0.0, max: 1.0)
  }

  static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(max > min)
    return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
  }
}

extension UIColor {
  static func randomBrightColor() -> UIColor {
    return UIColor(hue: .random(),
             saturation: .random(min: 0.5, max: 1.0),
             brightness: .random(min: 0.7, max: 1.0),
             alpha: 1.0)
  }
}
