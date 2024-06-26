import Foundation

struct MenuItem: Decodable {
	let title: String
	let image: String
	let price: String
	
	// Optional
	let description: String?
}
