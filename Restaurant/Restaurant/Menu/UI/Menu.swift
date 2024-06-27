import SwiftUI

struct Menu: View {
	@ObservedObject private var viewModel = MenuViewModel()
	@Environment(\.managedObjectContext) private var viewContext
	@State private var searchText = ""
	
	private enum Constants {
		static let imageLength: CGFloat = 100
		static let imageCornerRadius: CGFloat = 8
	}
	
	var body: some View {
		NavigationView {
			VStack {
				SearchBar(searchText: $searchText, onSearchButtonClicked: {
					viewModel.applySearchFilter(searchText)
				})
				
				List(viewModel.filteredDishes, id: \.title) { item in
					NavigationLink(destination: MenuItemDetailView(dish: item)) {
						HStack {
							Text("\(item.title ?? "") - \(item.price ?? "")")
								.font(.headline)
							
							Spacer()
							
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
			.onChange(of: searchText) {
				viewModel.applySearchFilter(searchText)
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

struct SearchBar: View {
	@Binding var searchText: String
	var onSearchButtonClicked: () -> Void
	
	var body: some View {
		HStack {
			TextField("Search", text: $searchText, onCommit: {
				onSearchButtonClicked()
			})
			.textFieldStyle(RoundedBorderTextFieldStyle())
			.padding(.horizontal)
			
			Button(action: {
				searchText = ""
				onSearchButtonClicked()
			}) {
				Image(systemName: "xmark.circle.fill")
					.foregroundColor(.gray)
					.padding(.trailing)
			}
		}
	}
}
