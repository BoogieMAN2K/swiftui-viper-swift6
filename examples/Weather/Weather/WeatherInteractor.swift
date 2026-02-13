protocol WeatherInteractorInput: Sendable {
    func onAppear() async
}

actor WeatherInteractor: WeatherInteractorInput {

    private let presenter: WeatherPresenter

    init(presenter: WeatherPresenter) {
        self.presenter = presenter
    }

    func onAppear() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        await presenter.didLoadTemperature(22)
    }
}
