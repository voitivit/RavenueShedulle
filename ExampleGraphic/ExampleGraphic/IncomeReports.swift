//
//  IncomeReports.swift
//  ExampleGraphic
//
//  Created by sot on 19.04.2023.
//

import UIKit
import AAInfographics
import SpreadsheetView
import SnapKit

class IncomeReports: UIViewController, UITextFieldDelegate {
	let chartView = AAChartView()
	//var array: [Int] = []
	var array = UserDefaults.standard.array(forKey: "numbers") as? [Int] ?? []
//	lazy var spreadsheetView = SpreadsheetView()
	let imageBackground:  UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "backgroundColor"))
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
		
		 // = UIImageView(image: UIImage(named: "backgroundColor"))
	let save: UIButton = {
		let button = UIButton(type: .system)
		//button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Сохранить", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 5.0
		button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
		return button
	}()
	let reset: UIButton = {
		let button = UIButton(type: .system)
		//button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Очистить", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 5.0
		button.addTarget(self, action: #selector(action3), for: .touchUpInside)
		return button
	}()
	let income: UITextField = {
		let textField = UITextField()
		textField.layer.borderWidth = 2.0
		textField.layer.borderColor = UIColor.systemMint.cgColor
		textField.layer.cornerRadius = 5.0
		textField.placeholder = "Приход"
		textField.textAlignment = .center
		return textField
	}()
	

	let incomeGraphs: UIButton = {
		let button = UIButton(type: .system)
		//button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("График ", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .systemMint
		button.layer.cornerRadius = 5.0
		button.addTarget(self, action: #selector(actionGraphs), for: .touchUpInside)
		return button
	}()
	

	let stackIncome: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = 80
		return stack
	}()
	let stackconsumption: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = 10
		return stack
	}()
	let options1 = AAChartModel()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		income.delegate = self
	
		if let savedNumbers = UserDefaults.standard.array(forKey: "numbers") as? [Int] {
			array = savedNumbers
            chartView.reload()
		}
		view.addSubview(imageBackground)
		view.sendSubviewToBack(imageBackground)
		view.addSubview(stackIncome)
		//view.addSubview(stackconsumption)
		view.addSubview(save)
		view.addSubview(reset)
		//view.backgroundColor = .green
		func loadArray() {
		if let loadedArray = UserDefaults.standard.array(forKey: "numbers") as? [Int] {
		array = loadedArray
			print("Новый сохраненный массив: \(array)")
		}
		}
	}
	
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		stackIncome.addArrangedSubview(income)
		stackIncome.addArrangedSubview(incomeGraphs)
		stackIncome.snp.makeConstraints { make in
			make.top.equalTo(view.snp.top).offset(450)
			make.left.equalTo(view.snp.left).offset(30)
			make.right.equalTo(view.snp.right).offset(-30)
			
			income.snp.makeConstraints { make in
				make.width.equalTo(130)
				make.height.equalTo(50)
			}
			incomeGraphs.snp.makeConstraints { make in
				make.width.equalTo(130)
				make.height.equalTo(50)
			}
			
		}
		save.snp.makeConstraints { make in
			make.top.equalTo(stackIncome.snp.top).offset(100)
			make.left.equalTo(view.snp.left).offset(100)
			make.right.equalTo(view.snp.right).offset(-100)
			make.height.equalTo(30)

	}
		reset.snp.makeConstraints { make in
			make.top.equalTo(save.snp.bottom).offset(20)
			make.left.equalTo(view.snp.left).offset(100)
			make.right.equalTo(view.snp.right).offset(-100)
			
			
		}

	}

	@objc func actionGraphs() {
		load()
	}
	@objc func saveAction() {
		
		let defaults = UserDefaults.standard
		  defaults.set(array, forKey: "numbers")
		chartView.aa_drawChartWithChartModel(options1)
		
	}
	@objc func action3() {
		
				array.removeAll()
			   UserDefaults.standard.removeObject(forKey: "numbers")
	}
	
	func load() {
        
		   chartView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)

		   view.addSubview(chartView)
			chartView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.left.equalTo(view.snp.left)
			make.right.equalTo(view.snp.right)
			make.bottom.equalTo(stackIncome.snp.top).offset(-80)
		}
        if let numberString = income.text, let number = Int(numberString) {
            array.append(number)
                   print("Массив с числами: \(array)")
               } else {
                   print("Введите целое число")
               }
               
               // Очистить текстовое поле после добавления числа в массив
        income.text = ""
//		let newArrat = array.reduce(0) { $0 * 10 + $1 }
//		var newArray: [Int] = []
//		newArray.append(newArrat)
		
		let seriesElement = AASeriesElement()
		
			.name("Мои данные") // наименование серии данных
			.data(array)
		print("Сохраненный массив: \(array)")
		
		options1
			   .chartType(.line)//график типа столбцы
			   .title("Доходы")//заголовок графика
			   .subtitle("2023 год")//подзаголовок графика
			   .colorsTheme(["#fe117c", "#ffc069", "#06caf4", "#7dffc0"])//цветовая палитра
			   .legendEnabled(false)//отключить легенду
			   .xAxisLabelsEnabled(true)//включить метки на оси X
			   .yAxisLabelsEnabled(true)//включить метки на оси Y
			   .backgroundColor("#ffc069")
			   .xAxisTitle("Месяц")//название оси X
			   .yAxisTitle("Поступления")//название оси Y
			   .series([seriesElement])
			   /*.series([
				   AASeriesElement()
					   .name("Продажи")
					   .data([seriesElement])
			   ])*/
		
		   chartView.aa_drawChartWithChartModel(options1)
		
	   }

	}
extension IncomeReports {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Сохраняем введенные цифры в UserDefaults
            UserDefaults.standard.set(array, forKey: "numbers")
            return true
            
           
        }
        // Проверяем, что вводится только цифра
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        if !allowedCharacterSet.isSuperset(of: typedCharacterSet) {
            let alert = UIAlertController(title: "Введите число", message: "Пожалуйста, введите число", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
}
