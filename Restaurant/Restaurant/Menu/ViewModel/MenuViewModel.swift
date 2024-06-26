import Foundation

class MenuViewModel: ObservableObject {
	@Published var menuItems: [MenuItem] = []
	
	private let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
	
	func getMenuData() {
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
