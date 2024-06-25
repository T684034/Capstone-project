import SwiftUI

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
	@State private var firstName = ""
	@State private var lastName = ""
	@State private var email = ""
	@State private var isLoggedIn = false // New state variable
	
	var body: some View {
		NavigationStack {
			VStack {
				TextField("First Name", text: $firstName)
					.padding()
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				TextField("Last Name", text: $lastName)
					.padding()
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				TextField("Email", text: $email)
					.padding()
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				Button("Register") {
					if !firstName.isEmpty && !lastName.isEmpty && isValidEmail(email) {
						UserDefaults.standard.set(firstName, forKey: kFirstName)
						UserDefaults.standard.set(lastName, forKey: kLastName)
						UserDefaults.standard.set(email, forKey: kEmail)
						UserDefaults.standard.set(true, forKey: kIsLoggedIn)
						isLoggedIn = true
					} else {
						// Handle the case where one or more fields are empty or email is invalid
					}
				}
				.padding()
				
				Spacer()
			}
			.padding()
			.navigationDestination(isPresented: $isLoggedIn) {
				Home()
			}
			.onAppear {
				if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
					isLoggedIn = true
				}
			}
		}
	}
	
	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: email)
	}
}

struct Onboarding_Previews: PreviewProvider {
	static var previews: some View {
		Onboarding()
	}
}
