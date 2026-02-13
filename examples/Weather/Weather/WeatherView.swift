import SwiftUI

struct WeatherView: View {

    let presenter: WeatherPresenter

    var body: some View {
        VStack {
            if presenter.state.isLoading {
                ProgressView()
            } else {
                Text(presenter.state.title)
            }
        }
        .onAppear {
            presenter.onAppear()
        }
    }
}
