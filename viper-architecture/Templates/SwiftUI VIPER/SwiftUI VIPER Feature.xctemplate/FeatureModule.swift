import SwiftUI

struct ___VARIABLE_featureName___Module {

    @MainActor
    static func build() -> some View {
        let router = ___VARIABLE_featureName___Router()

        let presenter = ___VARIABLE_featureName___Presenter(
            interactor: DummyInteractor(),
            router: router
        )

        let interactor = ___VARIABLE_featureName___Interactor(
            presenter: presenter
        )

        // Two-phase wiring to avoid init cycles
        presenter.setInteractor(interactor)

        return ___VARIABLE_featureName___View(
            presenter: presenter
        )
        .environment(router)
    }
}
