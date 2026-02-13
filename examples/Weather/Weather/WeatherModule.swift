import SwiftUI

struct WeatherModule {

    @MainActor
    static func build() -> some View {
        let router = WeatherRouter()

        let presenter = WeatherPresenter(
            router: router
        )

        let interactor = WeatherInteractor(
            presenter: presenter
        )

        presenter.attach(interactor: interactor)

        return WeatherView(
            presenter: presenter
        )
        .environment(router)
    }
}
