//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by 하다현 on 6/3/25.
//

import UIKit

class ToDoCell: UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var toDoDateLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    // ToDoData를 전달받을 변수 ( 전달 받으면 표시하는 메서드 실행)
    var toDoData: ToDoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // 델리게이트 대신 클로저 방식 사용
    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀(자신)을 전달)
    var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    // 기본 UI 설정
    func configureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        
        updateButton.clipsToBounds = true
        backView.layer.cornerRadius = 10
    }
    
    // 데이터 가지고 UI 표시
    func configureUIwithData() {
        toDoTextLabel.text = toDoData?.memoText
        toDoDateLabel.text = toDoData?.dateString
        guard let colorNum = toDoData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        updateButton.backgroundColor = color.buttonColor
        backView.backgroundColor = color.backgoundColor
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        // 뷰컨트롤러에서 전달받은 클로저를 실행 ( 내 자신 ToDoCell을 전달하며 )
        updateButtonPressed(self)
    }
    
}
