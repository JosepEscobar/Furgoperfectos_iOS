/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The annotation views that represent the different types of cycles.
*/
import MapKit

private let multiWheelCycleClusterID = "multiFurgoperfectos"

/// - Tag: UnicycleAnnotationView
class FurgoperfectoAnnotationView: MKMarkerAnnotationView {

    static let ReuseID = "furgoperfectoAnnotation"

    /// - Tag: ClusterIdentifier
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "furgoperfecto"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = UIColor.unicycleColor
        glyphImage = #imageLiteral(resourceName: "furgo_transparent _144")
        
        //TODO: Disclosure view
        canShowCallout = true
        let detailButton: UIButton = UIButton(type:UIButton.ButtonType.detailDisclosure) as UIButton
        detailButton.setImage(UIImage(named: "furgo_transparent _144"), for: .normal)
        rightCalloutAccessoryView = detailButton
    }
}


//// #MARK: DEMO FOR OTHER TYPES - NOT USED NOW
/// - Tag: BicycleAnnotationView
class BicycleAnnotationView: MKMarkerAnnotationView {

    static let ReuseID = "bicycleAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = multiWheelCycleClusterID
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Tag: DisplayConfiguration
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = UIColor.bicycleColor
        glyphImage = #imageLiteral(resourceName: "bicycle")
    }
}

//// #MARK: DEMO FOR OTHER TYPES - NOT USED NOW
class TricycleAnnotationView: MKMarkerAnnotationView {

    static let ReuseID = "tricycleAnnotation"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = multiWheelCycleClusterID
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = UIColor.tricycleColor
        glyphImage = #imageLiteral(resourceName: "tricycle")
    }
}
