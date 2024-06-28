import SwiftUI

struct Header: View {
	@State private var isLoggedIn = false
	
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					Image("littleLemonBanner")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(maxHeight: 50)
					
					Spacer()
					
					if isLoggedIn {
						NavigationLink(destination: UserProfile()) {
							Image(systemName: "person.crop.circle.fill")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(maxHeight: 50)
								.clipShape(Circle())
								.padding(.trailing)
								.foregroundColor(.darkGreenLittleLemon)
						}
						.padding(.horizontal)
					}
				}
				.frame(maxHeight: 60)
			}
			.navigationBarTitle("")
			.navigationBarHidden(true)
		}
		.onAppear {
			isLoggedIn = true //UserDefaults.standard.bool(forKey: keyIsLoggedIn)
		}
	}
}

struct Header_Previews: PreviewProvider {
	static var previews: some View {
		Header()
	}
}
