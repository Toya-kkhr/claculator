//
//  ViewController.swift
//  calculatorApp
//
//  Created by 加古原　冬弥 on 2020/06/10.
//  Copyright © 2020 加古原　冬弥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum calculatorStatus {
        case none, plus, minus, multiplication, division
    }
    
    var firstNumver = ""
    var secondNumber = ""
    var calculateStatus: calculatorStatus = .none
    
    let numbers = [
        
        ["C","%","$","÷"],
        ["7","8","9","×"],
        ["4","5","6","+"],
        ["1","2","3","-"],
        ["0",".","="],
    
    ]
    
    let cellId = "cellId"
    

    @IBOutlet weak var numberLavel: UILabel!
    @IBOutlet weak var calculatorCollectionView: UICollectionView!
    @IBOutlet weak var calculatorHightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
      
    }
    
    func setupViews(){
        
        calculatorCollectionView.delegate = self
              calculatorCollectionView.dataSource = self
              calculatorCollectionView.register(CalculatorViewCell.self,forCellWithReuseIdentifier:cellId)
              calculatorHightConstraint.constant = view.frame.width * 1.4
              calculatorCollectionView.backgroundColor = .clear
              
              calculatorCollectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
              
              view.backgroundColor = .black
              numberLavel.text = ""
        
    }
    
    func clear(){
        
        firstNumver = ""
        secondNumber = ""
        
        numberLavel.text = "0"
        calculateStatus = .none
    }
    



}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 0
        width = ((collectionView.frame.width - 10) - 14 * 5 ) / 4
        let height = width
        
        if indexPath.section == 4 && indexPath.row == 0 {
            width = width * 2 + 14 + 9
        }

        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calculatorCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CalculatorViewCell
        
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row ]
        
        numbers[indexPath.section][indexPath.row].forEach { (numberString) in
            
            if "0"..."9" ~= numberString || numberString.description == "." {
                cell.numberLabel.backgroundColor = .darkGray
            }else if numberString == "C" || numberString == "%" || numberString == "$" {
                
                cell.numberLabel.backgroundColor = UIColor.init(white: 1, alpha: 0.7 )
                cell.numberLabel.textColor = .black
            }
            
            
        }
        
        //cell.backgroundColor = .blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbers[indexPath.section][indexPath.row]
        
        switch calculateStatus {
        case .none:
            handleFirstNumberSelected(number: number )
        case .plus, .minus, .multiplication, .division:
            handleSecondNumberSelected(number: number)
        }
    }
    
    private func handleSecondNumberSelected(number: String){
        
        switch number {
                       case "0"..."9":
                        secondNumber += number
                        numberLavel.text = secondNumber
            
        case ".":
            if !confirmIncludeDecimalPiont(numberString: secondNumber ){
                
                secondNumber += number
                numberLavel.text = secondNumber
            }
        case "=":
            calculateResultNumber()
            
        case"C":
            clear()
            
        default:
            break
        }
        
    }
    
    private func handleFirstNumberSelected(number: String){
        
        switch number {
        case "0"..."9":
            firstNumver += number
            numberLavel.text = firstNumver
            
            if firstNumver.hasPrefix("0"){
                firstNumver = ""
            }
            
            
        case ".":
            if !confirmIncludeDecimalPiont(numberString: firstNumver ) {
                
                firstNumver += number
                numberLavel.text = firstNumver
                
                if secondNumber.hasPrefix("0"){
                    secondNumber = ""
                }
                
            }
            
        case "+":
            calculateStatus = .plus
            
        case "-":
            calculateStatus = .minus
            
        case "×":
            calculateStatus = .multiplication
            
        case "÷":
            calculateStatus = .division
            
        case"C":
            clear()
            
            
        default:
            break
        }
        
    }
    
    private func calculateResultNumber(){
        
        let firstNum = Double(firstNumver) ?? 0
                 let secondNum = Double(secondNumber) ?? 0
                 
                 var resultString: String?
                 
                 switch calculateStatus {
                 case .plus:
                     resultString = String (firstNum + secondNum)
                 case .minus:
                     resultString = String (firstNum - secondNum)
                 case .multiplication:
                     resultString = String (firstNum * secondNum)
                 case .division:
                     resultString = String (firstNum / secondNum)
                 default:
                     break
                 }
                 
                 if let result = resultString, result.hasSuffix(".0") {
                     resultString = result.replacingOccurrences(of: ".0", with: "")
                 }
                 
                 numberLavel.text = resultString
                 
                 firstNumver = ""
                 secondNumber = ""
                 
                 firstNumver += resultString ?? ""
                 calculateStatus = .none
                 
        
    }
    
    private func confirmIncludeDecimalPiont(numberString: String) -> Bool {
        
        if numberString.range(of: ".") != nil || numberString.count == 0 {
            return true
        }else{
            return false
            //firstNumver += number
            //numberLavel.text = firstNumver
        }
        
    }
    
}


