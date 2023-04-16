//
//  ContentView.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var selectedTab = 1
    @State var phoneNumber: [String] = [
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",
    "010-3327-9431",]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                Text("즐겨찾기")
                    .navigationTitle("즐겨찾기")
            }
            .tabItem{
                Image(systemName: "star.fill")
                    .foregroundColor(.gray)
                Text("즐겨찾기")
                    .foregroundColor(.gray)
            }
            
            NavigationView {
                List(phoneNumber, id:\.self) { item in
                    RecentlyCallListCell()
                }
                .navigationTitle("최근 통화")
                
            }
            .tabItem{
                Image(systemName: "clock.fill")
                    .foregroundColor(.gray)
                Text("최근 통화")
                    .foregroundColor(.gray)
            }

            
            NavigationView {
                ContactListView()
                    .navigationTitle("연락처")
            }
            .tabItem{
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.gray)
                Text("연락처")
                    .foregroundColor(.gray)
            }

            NavigationView {
                Text("키패드")
                    .navigationTitle("키패드")
            }
            .tabItem{
                Image(systemName: "circle.grid.3x3.fill")
                    .foregroundColor(.gray)
                Text("키패드")
                    .foregroundColor(.gray)
            }

            
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
