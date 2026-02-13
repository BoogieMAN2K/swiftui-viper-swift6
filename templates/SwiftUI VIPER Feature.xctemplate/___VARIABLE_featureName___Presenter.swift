import Observation

@MainActor
@Observable
final class ___VARIABLE_featureName___Presenter {

    var state = ___VARIABLE_featureName___ViewState()

    private var interactor: ___VARIABLE_featureName___InteractorInput!
    private let router: ___VARIABLE_featureName___Router

    init(router: ___VARIABLE_featureName___Router) {
        self.router = router
    }

    func attach(interactor: ___VARIABLE_featureName___InteractorInput) {
        self.interactor = interactor
    }

    func onAppear() {
        Task {
            await interactor.onAppear()
        }
    }
}
