//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Anthony You on 15/07/2021.
//

import SwiftUI

enum ActionSheetType {
    case sort, filter
}

enum SortingOption {
    case none, alphabetical, country
}

enum FilterOption {
    case none, country, size, price
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()

    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    var sortedResorts: [Resort] {
        switch sortingOption {
        case .alphabetical:
            return resorts.sorted(by: { $0.name < $1.name })
        case .country:
            return resorts.sorted(by: { $0.country < $1.country })
        default:
            return resorts
        }
    }

    var filteredResorts: [Resort] {
        switch filterOption {
        case .country:
            return sortedResorts.filter({ $0.country == "France" })
        case .price:
            return sortedResorts.filter({ $0.price == 2 })
        case .size:
            return sortedResorts.filter({ $0.size == 2 })
        default:
            return sortedResorts
        }
    }

    let countries: [String] = ["Canada", "France", "Italy", "United States"]

    @State private var showingActionSheet = false
    @State private var actionSheetType: ActionSheetType = .sort
    @State private var sortingOption: SortingOption = .none
    @State private var filterOption: FilterOption = .none

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)

                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.actionSheetType = .sort
                        self.showingActionSheet = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                        Text("Sort")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.actionSheetType = .filter
                        self.showingActionSheet = true
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                        Text("Filter")
                    }
                }
            }
            .actionSheet(isPresented: $showingActionSheet) {
                if self.actionSheetType == .sort {
                    return ActionSheet(title: Text("Sort resorts by"), message: Text("Select a sorting type"), buttons: [
                        .default(Text("Default")) { self.sortingOption = .none },
                        .default(Text("Alphabetical")) { self.sortingOption = .alphabetical },
                        .default(Text("Country")) { self.sortingOption = .country },
                        .cancel()
                    ])
                } else {
                    return ActionSheet(title: Text("Filter resort by"), message: Text("Select a filter"), buttons: [
                        .default(Text("Default")) { self.filterOption = .none },
                        .default(Text("Country")) { self.filterOption = .country },
                        .default(Text("Size")) { self.filterOption = .size },
                        .default(Text("Price")) { self.filterOption = .price },
                        .cancel()
                    ])
                }
            }

            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
    }
}

// With this extension, only iPhones use Stack Navigation (without, Pro Max iPhones use two sides nav)
extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
