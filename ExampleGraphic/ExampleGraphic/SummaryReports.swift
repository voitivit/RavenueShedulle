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
    let incomeReporst = IncomeReports()
    let consuptionReports = ConsuptionReports()
    var summaryArrayIncome: [Int] = []
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
                
                self.summaryArrayIncome.append(contentsOf: consuptionReports.arrayConsumption)// = self.incomeReporst.incomeArray
                self.summaryArrayConsuption.append(contentsOf: consuptionReports.arrayConsumption) //= self.consuptionReports.arrayConsumption
                
                for element in summaryArrayConsuption {
                    if let index = summaryArrayIncome.firstIndex(of: element) {
                        summaryArrayIncome.remove(at: index)
                        
                        
                        
                    }
                }
                summaryArrayIncome.append(contentsOf: consuptionReports.arrayConsumption)
                print("Массив разности поступлений и расходов: \(summaryArrayIncome) ")
                
        }

    }
}
