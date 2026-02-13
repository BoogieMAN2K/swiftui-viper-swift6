import Observation

@MainActor
@Observable
final class WeatherRouter {
    var route: WeatherRoute?
}

enum WeatherRoute: Sendable {
    case details
}
