//
//  SummaryReports.swift
//  ExampleGraphic
//
//  Created by emil kurbanov on 14.06.2023.
//

import UIKit
import AAInfographics
import SpreadsheetView
import SnapKit

class SummaryReports: UIViewController {
    let chartView = AAChartView()
    var incomeReporst: [Int] = []
    var consuptionReports: [Int] = []
   var summaryArrayIncome = UserDefaults.standard.array(forKey: "numbers") as? [Int] ?? []
   // var summaryArrayIncome: [Int] = []
    let chartSummaryReports = AAChartModel()
    var summaryArrayConsuption: [Int] = []
    let imageBackground:  UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundColor"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var summaryReportsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Анализ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(analysisAction), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupLayout()
        

      
        
    }
    
    func setupLayout() {
        view.addSubview(imageBackground)
        view.sendSubviewToBack(imageBackground)
        view.addSubview(summaryReportsButton)
        summaryReportsButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(600)
            make.left.equalTo(view.snp.left).offset(100)
            make.right.equalTo(view.snp.right).offset(-100)
        }
        
    }
    @objc func analysisAction() {
           chartView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)
            view.addSubview(chartView)
            chartView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(summaryReportsButton.snp.top).offset(-15)
                

              
        }
        // Получаем заполненный массив из UserDefaults или используем пустой массив, если нет значения
        if let storedArray = UserDefaults.standard.array(forKey: "numbers") as? [Int] {
            incomeReporst = storedArray
        }
        if let storedArray = UserDefaults.standard.array(forKey: "consuptionNumbers") as? [Int] {
            consuptionReports = storedArray
        }
        let count = max(incomeReporst.count, consuptionReports.count)

        var resultArray: [Int] = []

        for index in 0..<count {
            let incomeValue = index < incomeReporst.count ? incomeReporst[index] : 0
            let consumptionValue = index < consuptionReports.count ? consuptionReports[index] : 0
            let difference = incomeValue - consumptionValue
            resultArray.append(difference)
        }
        print("Итоговоый массив: \(resultArray)")
        print("Массив приходов: \(incomeReporst)")
        print("Массив расходов: \(consuptionReports)")
        
        let seriesElement = AASeriesElement()
        
            .name("Мои данные") // наименование серии данных
            .data(resultArray)
        print("Сохраненный массив: \(resultArray)")
        
         chartSummaryReports
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
        
           chartView.aa_drawChartWithChartModel(chartSummaryReports)

        
    }
}
