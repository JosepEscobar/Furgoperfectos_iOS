//
//  ClusterAnnotationView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 20/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import MapKit

class ClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Tag: CustomCluster
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        if let cluster = annotation as? MKClusterAnnotation {
            let totalBikes = cluster.memberAnnotations.count
            
            if count(furgoperfectoType: .furgoperfectoDefault) > 0 {
                image = drawUnicycleCount(count: totalBikes)
            } else {
                let tricycleCount = count(furgoperfectoType: .tricycle)
                image = drawRatioBicycleToTricycle(tricycleCount, to: totalBikes)
            }
            
            if count(furgoperfectoType: .furgoperfectoDefault) > 0 {
                displayPriority = .defaultLow
            } else {
                displayPriority = .defaultHigh
            }
        }
    }
    
    private func drawRatioBicycleToTricycle(_ tricycleCount: Int, to totalBikes: Int) -> UIImage {
        return drawRatio(tricycleCount, to: totalBikes, fractionColor: UIColor.tricycleColor, wholeColor: UIColor.bicycleColor)
    }
    
    private func drawUnicycleCount(count: Int) -> UIImage {
        return drawRatio(0, to: count, fractionColor: nil, wholeColor: UIColor.unicycleColor)
    }
    
    private func drawRatio(_ fraction: Int, to whole: Int, fractionColor: UIColor?, wholeColor: UIColor?) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        return renderer.image { _ in
            // Fill full circle with wholeColor
            wholeColor?.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
            
            // Fill pie with fractionColor
            fractionColor?.setFill()
            let piePath = UIBezierPath()
            piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                           startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(fraction)) / CGFloat(whole),
                           clockwise: true)
            piePath.addLine(to: CGPoint(x: 20, y: 20))
            piePath.close()
            piePath.fill()
            
            // Fill inner circle with white color
            UIColor.translucentButtonColor?.setFill()
            UIBezierPath(ovalIn: CGRect(x: 4, y: 4, width: 32, height: 32)).fill()
            
            // Finally draw count text vertically and horizontally centered
            let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                               NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
            let text = "\(whole)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
    
    private func count(furgoperfectoType type: FurgoperfectoAnnotation.FurgoperfectoType) -> Int {
        guard let cluster = annotation as? MKClusterAnnotation else {
            return 0
        }
        
        return cluster.memberAnnotations.filter { member -> Bool in
            guard let furgoperfecto = member as? FurgoperfectoAnnotation else {
                fatalError("Found unexpected annotation type")
            }
            return furgoperfecto.type == type
            }.count
    }
}

