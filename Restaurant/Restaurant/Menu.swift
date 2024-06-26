import SwiftUI

struct Menu: View {
	@State private var menuItems: [MenuItem] = []
	
	var body: some View {
		VStack {
			Text("Menu")
				.font(.largeTitle)
				.padding()
			
			List(menuItems, id: \.title) { item in
				VStack(alignment: .leading) {
					Text(item.title)
						.font(.headline)
					Text(item.price)
						.font(.subheadline)
				}
			}
		}
		.onAppear {
			getMenuData()
		}
	}
	
	func getMenuData() {
		let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
		guard let url = URL(string: urlString) else { return }
		let request = URLRequest(url: url)
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("Error fetching data: \(error)")
				return
			}
			
			if let data = data {
				do {
					let decoder = JSONDecoder()
					let menuList = try decoder.decode(MenuList.self, from: data)
					DispatchQueue.main.async {
						self.menuItems = menuList.menu
					}
				} catch {
					print("Error decoding data: \(error)")
				}
			} else {
				print("No data received")
			}
		}
		
		task.resume()
	}
}

struct Menu_Previews: PreviewProvider {
	static var previews: some View {
		Menu()
	}
}
