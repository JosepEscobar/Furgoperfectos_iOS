import CoreLocation

extension Array where Element == FurgoperfectoModel {
    mutating func sort(by location: CLLocation) {
        return sort(by: { $0.coordinates.distance(to: location) < $1.coordinates.distance(to: location) })
    }

    func sorted(by location: CLLocation) -> [FurgoperfectoModel] {
        return sorted(by: { $0.coordinates.distance(to: location) < $1.coordinates.distance(to: location) })
    }
}
