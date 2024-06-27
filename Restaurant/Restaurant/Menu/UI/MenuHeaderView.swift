import SwiftUI

struct MenuHeaderView: View {
	var body: some View {
		ZStack {
			Color.darkGreenLittleLemon
				.frame(height: 250)
			
			HStack{
				VStack(alignment: .leading, spacing: 0) {
					VStack(alignment: .leading) {
						Text("Little Lemon")
							.font(.system(size: 30, weight: .medium))
							.foregroundColor(.yellowLittleLemon)
							
						Text("Chicago")
							.font(.subheadline)
							.foregroundColor(.white)
					}
					.padding()
					.padding(.top, 50)
					
					
					Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
						.font(.body)
						.foregroundColor(.white)
						.padding()
						.padding(.bottom, 50)
				}

				Spacer()
				
				Image("MenuHeaderImage")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 150, height: 150)
					.cornerRadius(10)
					.clipped()
					.padding(.trailing, 10)
					
			}
			
		}
	}
}

struct MenuHeaderView_Previews: PreviewProvider {
	static var previews: some View {
		MenuHeaderView()
	}
}
