import UIKit

class TabBarView: UITabBar {

    private var shapeLayer: CAShapeLayer?
    var centeredWidth: CGFloat = 0 // For center item detection to curve the shape

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        centeredWidth = self.bounds.width / CGFloat(items?.count ?? 1) / 2
        self.unselectedItemTintColor = .white
        self.tintColor = .black
        self.addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = getPath()
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.systemMint.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.2

        if let oldShape = self.shapeLayer {
            self.layer.replaceSublayer(oldShape, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }

    private func getPath() -> CGPath {
        let height: CGFloat = 47
        _ = self.bounds.width / CGFloat(items?.count ?? 1)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centeredWidth - height, y: 0))

        path.addCurve(to: CGPoint(x: centeredWidth, y: height),
                      controlPoint1: CGPoint(x: centeredWidth - 30, y: 0),
                      controlPoint2: CGPoint(x: centeredWidth - 30, y: height))

        path.addCurve(to: CGPoint(x: centeredWidth + height, y: 0),
                      controlPoint1: CGPoint(x: centeredWidth + 30, y: height),
                      controlPoint2: CGPoint(x: centeredWidth + 30, y: 0))

        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: 0))

        path.close()
        return path.cgPath
    }

    func updateCurveForTappedIndex() {
        guard let selectedIndex = self.items?.firstIndex(of: self.selectedItem!) else { return }
        let tabWidth = self.bounds.width / CGFloat(items?.count ?? 1)
        self.centeredWidth = tabWidth * CGFloat(selectedIndex) + (tabWidth / 2)
        addShape()
    }
}
