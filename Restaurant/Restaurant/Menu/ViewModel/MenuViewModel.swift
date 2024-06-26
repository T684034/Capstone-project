import CoreData

class MenuViewModel: ObservableObject {
	@Published var menuItems: [MenuItem] = []
	@Published var dishes: [Dish] = []
	
	private let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
	
	func getMenuData(context: NSManagedObjectContext) {
		let persistenceController = PersistenceController.shared
		persistenceController.clear()
		
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
						self.saveMenuItemsToCoreData(context: context, menuItems: menuList.menu)
						self.fetchMenuItemsFromCoreData(context: context)
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
	
	private func saveMenuItemsToCoreData(context: NSManagedObjectContext, menuItems: [MenuItem]) {
		for menuItem in menuItems {
			let dish = Dish(context: context)
			dish.title = menuItem.title
			dish.price = menuItem.price
			dish.itemDescription = menuItem.itemDescription
			dish.image = menuItem.image
			
			do {
				try context.save()
			} catch {
				print("Error saving to Core Data: \(error)")
			}
		}
	}
	
	private func fetchMenuItemsFromCoreData(context: NSManagedObjectContext) {
		let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
		fetchRequest.sortDescriptors = buildSortDescriptors()
		
		do {
			dishes = try context.fetch(fetchRequest)
			print("Fetched \(dishes.count) dishes from Core Data")
			self.menuItems = dishes.map { dish in
				MenuItem(
					title: dish.title ?? "",
					image: dish.image ?? "",
					price: dish.price ?? "",
					itemDescription: dish.itemDescription
				)
			}
		} catch {
			print("Error fetching from Core Data: \(error)")
		}
	}
	
	private func buildSortDescriptors() -> [NSSortDescriptor] {
		return [
			NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
		]
	}
	
	/*
	func buildPredicate(searchText: String) -> NSPredicate {
		return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[cd] %@", searchText)
	}*/
}
