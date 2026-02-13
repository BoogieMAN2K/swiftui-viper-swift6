import Observation

@MainActor
@Observable
final class WeatherPresenter {

    var state = WeatherViewState()

    private let router: WeatherRouter
    private var interactor: WeatherInteractorInput?

    init(
        router: WeatherRouter
    ) {
        self.router = router
    }

    func attach(interactor: WeatherInteractorInput) {
        self.interactor = interactor
    }

    func onAppear() {
        guard let interactor else { return }
        state.isLoading = true

        Task {
            await interactor.onAppear()
        }
    }

    func didLoadTemperature(_ temperature: Int) {
        state.isLoading = false
        state.title = "\(temperature)°"
    }
}
