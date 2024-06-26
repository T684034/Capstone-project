import SwiftUI

struct Menu: View {
	@ObservedObject private var viewModel = MenuViewModel()
	@Environment(\.managedObjectContext) private var viewContext
	
	private enum Constants {
		static let imageLength: CGFloat = 100
		static let imageCornerRadius: CGFloat = 8
	}
	
	var body: some View {
		NavigationView {
			VStack {
				//List(viewModel.menuItems, id: \.title) { item in
				List(viewModel.dishes, id: \.title) { item in
					NavigationLink(destination: MenuItemDetailView(dish: item)) {
						HStack {
							//Text("\(item.title) - \(item.price)")
							Text("\(item.title ?? "") - \(item.price  ?? "")")
								.font(.headline)
							
							Spacer()
							
							//let imageUrl = item.image
							//if let url = URL(string: imageUrl) {
							if let imageUrl = item.image, let url = URL(string: imageUrl) {
								AsyncImage(
									url: url,
									content: { image in
										image.resizable()
											.aspectRatio(contentMode: .fit)
									},
									placeholder: {
										ProgressView()
									}
								)
								.cornerRadius(Constants.imageCornerRadius)
								.frame(width: Constants.imageLength, height: Constants.imageLength)
							}
						}
					}
				}
				.listStyle(.plain)
				.padding()
			}
			.onAppear {
				viewModel.getMenuData(context: viewContext)
			}
			.navigationTitle("Menu")
		}
	}
}

struct Menu_Previews: PreviewProvider {
	static var previews: some View {
		Menu()
	}
}
