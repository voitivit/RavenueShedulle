//
//  ViewController2.swift
//  ExampleGraphic
//
//  Created by sot on 20.04.2023.
//

import UIKit
import AAInfographics

class ViewController2: UIViewController, UITextFieldDelegate {
	
	let chartView = AAChartView()
	var arrayConsumption: [Int] = []
	let imageBackground:  UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "backgroundColor"))
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	
	let save: UIButton = {
		let button = UIButton(type: .system)
		//button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Сохранить", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 5.0
		button.addTarget(self, action: #selector(saveConsumptionAction), for: .touchUpInside)
		return button
	}()
	let reset: UIButton = {
		let button = UIButton(type: .system)
		//button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Очистить", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 5.0
		button.addTarget(self, action: #selector(cleanConsumptionAction), for: .touchUpInside)
		return button
	}()
	
	let consumption: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Расход"
		textField.layer.borderWidth = 2.0
		textField.layer.borderColor = UIColor.systemPink.cgColor // UIColor.systemMint.cgColor
		textField.layer.cornerRadius = 5.0
		textField.textAlignment = .center
		return textField
	}()
	let consumptionGraphs: UIButton = {
		let button = UIButton(type: .system)
		//button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("График", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .systemPink // .systemMint
		button.layer.cornerRadius = 5.0
		button.addTarget(self, action: #selector(actionConsuptionGraph), for: .touchUpInside)
		return button
	}()
	
	let stackconsumption: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = 80
		return stack
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		//view.addSubview(chartView)
		//chartView.backgroundColor =  UIColor(named: "#ffc069")
		consumption.delegate = self
		if let savedNumbers = UserDefaults.standard.array(forKey: "arrayConsuption") as? [Int] {
			arrayConsumption = savedNumbers
			
		}
		view.addSubview(stackconsumption)
		//view.addSubview(stackconsumption)
		view.addSubview(imageBackground)
		view.sendSubviewToBack(imageBackground)
		view.addSubview(save)
		view.addSubview(reset)
		

		func loadArray() {
		if let loadedArray = UserDefaults.standard.array(forKey: "arrayConsuption") as? [Int] {
			arrayConsumption = loadedArray
			print("Новый сохраненный массив: \(arrayConsumption)")
		}
		}
		/*if let savedNumbers = UserDefaults.standard.array(forKey: "numbers") as? [Int] {
			array = savedNumbers
		}*/
	}
	
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
			super.viewDidLayoutSubviews()
		//view.addSubview(chartView)
		
			stackconsumption.addArrangedSubview(consumption)
			stackconsumption.addArrangedSubview(consumptionGraphs)
			//stackconsumption.addArrangedSubview(consumption)
			//stackconsumption.addArrangedSubview(consumptionGraphs)
		
		
		
//		chartView.snp.makeConstraints { make in
//			//make.top.equalTo(view.snp.top)
//			make.left.equalTo(view.snp.left)
//			make.right.equalTo(view.snp.right)
//			//make.bottom.equalTo(stackconsumption.snp.top)
//			make.height.equalTo(view.snp.height).multipliedBy(0.5)
//			make.width.equalTo(view.snp.width)
//		}
			stackconsumption.snp.makeConstraints { make in
				make.top.equalTo(view.snp.top).offset(450)
				make.left.equalTo(view.snp.left).offset(30)
				make.right.equalTo(view.snp.right).offset(-30)
				
				consumptionGraphs.snp.makeConstraints { make in
					make.width.equalTo(130)
					make.height.equalTo(50)
				}
				consumption.snp.makeConstraints { make in
					make.width.equalTo(130)
					make.height.equalTo(50)
				}
				
				
			}
		save.snp.makeConstraints { make in
			make.top.equalTo(stackconsumption.snp.top).offset(100)
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

	@objc func actionConsuptionGraph() {
		 load()
	 }
	 @objc func saveConsumptionAction() {
	 
		 let defaults = UserDefaults.standard
		   defaults.set(arrayConsumption, forKey: "arrayConsuption")
		 
		 
	 }
	 @objc func cleanConsumptionAction() {
		 
		 arrayConsumption.removeAll()
				UserDefaults.standard.removeObject(forKey: "arrayConsuption")
	 }
	 
	 func load() {
		 //let chartView = AAChartView()
			chartView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)
		 
		   // chartView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
		 
			view.addSubview(chartView)
		 chartView.snp.makeConstraints { make in
			 make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			 make.left.equalTo(view.snp.left)
			 make.right.equalTo(view.snp.right)
			 make.bottom.equalTo(stackconsumption.snp.top).offset(-80)
		 }
		 
		 
		   // let chartView2 = AAChartView()
		 let seriesElement = AASeriesElement()
			 .name("Мои данные") // наименование серии данных
			 .data(arrayConsumption)
		 print("Сохраненный массив: \(arrayConsumption)")
		 
			let options1 = AAChartModel()
				.chartType(.line)//график типа столбцы
				.title("Доходы")//заголовок графика
				.subtitle("2023 год")//подзаголовок графика
				.colorsTheme(["#fe117c", "#ffc069", "#06caf4", "#7dffc0"])//цветовая палитра
				.backgroundColor("#ffc069")
				.legendEnabled(false)//отключить легенду
				.xAxisLabelsEnabled(true)//включить метки на оси X
				.yAxisLabelsEnabled(true)//включить метки на оси Y
				.xAxisTitle("Месяц")//название оси X
				.yAxisTitle("Расходы")//название оси Y
				.series([seriesElement])
				/*.series([
					AASeriesElement()
						.name("Продажи")
						.data([seriesElement])
				])*/
		 
			chartView.aa_drawChartWithChartModel(options1)
		 
		}

	 }

 /*
   Очистка массива при нажатии на очистить
  numbers.removeAll()
		 UserDefaults.standard.removeObject(forKey: "numbers")
  
  */
 extension ViewController2 {
	 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
		 
		 // Добавляем введенную цифру в массив
		 if let number = Int(string) {
			 arrayConsumption.append(number)
		 }
		 return true
	 }
	 
	 
	 
	 
	 
	 /*
	 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		 // Сохраняем введенные цифры в UserDefaults
		 UserDefaults.standard.set(array, forKey: "numbers")
		 return true
	 }*/
	 
	 /*func textFieldShouldClear(_ textField: UITextField) -> Bool {
		 // Очищаем массив при очистке текстового поля
		 array.removeAll()
		 return true
	 }*/

	}



