//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by 하다현 on 6/3/25.
//

import UIKit
import CoreData

//MARK: - To Do 관리 매니저 ( 코어데이터 관리)

final class CoreDataManager {
    // 싱글톤 객체 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시 저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티 이름
    let modelName: String = "ToDoData"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getToDoListFromCoreData() -> [ToDoData] {
        var toDoList: [ToDoData] = []
        // 임시 저장소 있는지 확인
        if let context = context {
            // 저장된 데이터 역순으로 가져오기
            // 요청서
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "createdDate", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시 저장소에서 요청서를 통해 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("가져오기 실패❌")
            }
        }
        return toDoList
    }
    
    //MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveToDoData(toDoText: String?, colorInt: Int64, completion: @escaping () ->
        Void) {
        // 임시 저장소 있는지 확인
            if let context = context {
                // 그려줄 데이터 형태 파악
                if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                    
                    if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
                        
                        // MARK: - ToDoData에 실제 데이터 할당
                        toDoData.memoText = toDoText
                        toDoData.color = colorInt
                        toDoData.date = Date()
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
            }
            completion()
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    func deleteToDo(data: ToDoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩 ( 날짜가 nil이면 삭제 불가능)
        guard let date = data.date else { completion(); return }
        
        // 임시 저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            // 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date == %@", date as CVarArg)
            
            do {
                // 임시 저장소에서 요청서를 통해 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetToDo = fetchedToDoList.first {
                        context.delete(targetToDo)
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우기 실패❌")
                completion()
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateToDo(newToDoData: ToDoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩 ( 날짜가 nil이면 삭제 불가능)
        guard let date = newToDoData.date else {
            completion()
            return
        }
        
        // 임시 저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            // 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date == %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    if var targetToDo = fetchedToDoList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기)
                        targetToDo = newToDoData
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("수정 실패❌")
                completion()
            }
        }
    }
}
