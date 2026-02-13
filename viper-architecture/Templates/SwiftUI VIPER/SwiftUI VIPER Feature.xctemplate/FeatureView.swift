import SwiftUI

struct ___VARIABLE_featureName___View: View {

    let presenter: ___VARIABLE_featureName___Presenter

    var body: some View {
        Text(presenter.state.title)
            .onAppear {
                presenter.onAppear()
            }
    }
}
