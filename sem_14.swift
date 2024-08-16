// архитектурный паттерн MVVM

import SwiftUI

// Модель для друзей
struct Friend {
    var name: String
    var age: Int
    var address: String
    var phoneNumber: String
}

// Модель для групп
struct Group {
    var name: String
    var category: String
    var membersCount: Int
}

// Модель для фото
struct Photo {
    var name: String
    var imageUrl: String
}

// ViewModel для друзей
class FriendsViewModel: ObservableObject {
    @Published var friends: [Friend] = []
    
    func loadFriends() {
        // Загрузка друзей из сети или Core Data
        // Пример загрузки из сети: friends = APIService.shared.fetchFriends()
    }
}

// ViewModel для групп
class GroupsViewModel: ObservableObject {
    @Published var groups: [Group] = []
    
    func loadGroups() {
        // Загрузка групп из сети или Core Data
        // Пример загрузки из сети: groups = APIService.shared.fetchGroups()
    }
}

// ViewModel для фото
class PhotosViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    
    func loadPhotos() {
        // Загрузка фото из сети или Core Data
        // Пример загрузки из сети: photos = APIService.shared.fetchPhotos()
    }
}

// View для друзей
struct FriendsView: View {
    @ObservedObject var friendsViewModel: FriendsViewModel
    
    var body: some View {
        List(friendsViewModel.friends, id: \.name) { friend in
            Text(friend.name)
        }
        .onAppear {
            friendsViewModel.loadFriends()
        }
    }
}

// View для групп
struct GroupsView: View {
    @ObservedObject var groupsViewModel: GroupsViewModel
    
    var body: some View {
        List(groupsViewModel.groups, id: \.name) { group in
            Text(group.name)
        }
        .onAppear {
            groupsViewModel.loadGroups()
        }
    }
}

// View для фото
struct PhotosView: View {
    @ObservedObject var photosViewModel: PhotosViewModel
    
    var body: some View {
        List(photosViewModel.photos, id: \.name) { photo in
            Text(photo.name)
        }
        .onAppear {
            photosViewModel.loadPhotos()
        }
    }
}

//Unit-тесты для ViewModel:

import XCTest
@testable import CreateApp

class ViewModelTests: XCTestCase {
    
    func testLoadFriends() {
        let viewModel = FriendsViewModel()
        
        // Проверяем, что friends пустой до загрузки
        XCTAssertTrue(viewModel.friends.isEmpty)
        
        // Вызываем метод загрузки друзей
        viewModel.loadFriends()
        
        // Проверяем, что friends не пустой после загрузки
        XCTAssertFalse(viewModel.friends.isEmpty)
    }
    
    func testLoadGroups() {
        let viewModel = GroupsViewModel()
        
        // Проверяем, что groups пустой до загрузки
        XCTAssertTrue(viewModel.groups.isEmpty)
        
        // Вызываем метод загрузки групп
        viewModel.loadGroups()
        
        // Проверяем, что groups не пустой после загрузки
        XCTAssertFalse(viewModel.groups.isEmpty)
    }
    
    func testLoadPhotos() {
        let viewModel = PhotosViewModel()
        
        // Проверяем, что photos пустой до загрузки
        XCTAssertTrue(viewModel.photos.isEmpty)
        
        // Вызываем метод загрузки фото
        viewModel.loadPhotos()
        
        // Проверяем, что photos не пустой после загрузки
        XCTAssertFalse(viewModel.photos.isEmpty)
    }
}

//UI-тесты для взаимодействия между компонентами приложения: Пример UI-теста для проверки отображения списка друзей в FriendsView

import XCTest
import SwiftUI
import ViewInspector 

@testable import CreateApp

class FriendsViewUITests: XCTestCase {
    
    func testFriendsView() throws {
        let viewModel = FriendsViewModel()
        viewModel.friends = [Friend(name: "Anastasia", age: 25, address: "Moscow Tverskaya St", phoneNumber: "777-1234"),
                             Friend(name: "Igor", age: 61, address: "Novorossiysk Tolstoy St", phoneNumber: "777-5678")]
        
        let view = FriendsView(friendsViewModel: viewModel)
        
        let sut = try view.inspect().list().forEach(0)
        
        XCTAssertEqual(try sut.find(ViewType.Text.self).text(), "Anastasia")
        XCTAssertEqual(try sut.find(ViewType.Text.self).text(), "Igor")
    }
}