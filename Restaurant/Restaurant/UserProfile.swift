import SwiftUI

struct UserProfile: View {
	@Environment(\.presentationMode) var presentation
	
	let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
	let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
	let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
	
	var body: some View {
		VStack {
			Text("Personal information")
				.font(.largeTitle)
				.padding()
			
			Image("profile-image-placeholder")
				.resizable()
				.frame(width: 100, height: 100)
				.clipShape(Circle())
				.padding()
			
			Text("First Name: \(firstName)")
				.font(.title2)
				.padding(.top)
			
			Text("Last Name: \(lastName)")
				.font(.title2)
				.padding(.top)
			
			Text("Email: \(email)")
				.font(.title2)
				.padding(.top)
			
			Button("Logout") {
				UserDefaults.standard.set(false, forKey: kIsLoggedIn)
				self.presentation.wrappedValue.dismiss()
			}
			.padding(.top)
			
			Spacer()
		}
		.padding()
	}
}

struct UserProfile_Previews: PreviewProvider {
	static var previews: some View {
		UserProfile()
	}
}

