import SwiftUI

struct Menu: View {
	var body: some View {
		VStack {
			Text("Your App Title")
				.font(.largeTitle)
				.padding()
			
			Text("Chicago")
				.font(.title)
				.padding()
			
			Text("A short description of the whole application.")
				.font(.body)
				.padding()
			
			List {
				// Menu items will go here
			}
		}
	}
}

struct Menu_Previews: PreviewProvider {
	static var previews: some View {
		Menu()
	}
}
