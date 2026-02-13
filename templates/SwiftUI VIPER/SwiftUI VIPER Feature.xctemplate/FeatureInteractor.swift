protocol ___VARIABLE_featureName___InteractorInput: Sendable {
    func onAppear() async
}

actor ___VARIABLE_featureName___Interactor: ___VARIABLE_featureName___InteractorInput {

    private let presenter: ___VARIABLE_featureName___Presenter

    init(presenter: ___VARIABLE_featureName___Presenter) {
        self.presenter = presenter
    }

    func onAppear() async {
        // Business logic goes here
    }
}
