import Observation

@MainActor
@Observable
final class ___VARIABLE_featureName___Presenter {

    var state = ___VARIABLE_featureName___ViewState()

    private let interactor: ___VARIABLE_featureName___InteractorInput
    private let router: ___VARIABLE_featureName___Router

    init(
        interactor: ___VARIABLE_featureName___InteractorInput,
        router: ___VARIABLE_featureName___Router
    ) {
        self.interactor = interactor
        self.router = router
    }

    func onAppear() {
        Task {
            await interactor.onAppear()
        }
    }
}
