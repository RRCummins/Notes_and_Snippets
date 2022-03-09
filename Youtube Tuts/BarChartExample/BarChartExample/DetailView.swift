//
//  DetailView.swift
//  BarChartExample
//
//  Created by Ryan Cummins on 12/21/21.
//

import SwiftUI

enum ChartRanges: Int, CaseIterable, Hashable, Identifiable {
    case week = 0
    case month
    case quarter
    case year
    
    var name: String {
        return "\(self)".capitalized
    }
    
    var id: ChartRanges {self}
}

enum Days: CaseIterable, Hashable, Identifiable {
    
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var shortName: String {
        return String("\(self)".prefix(2)).capitalized
    }
    var id: Days {self}
}

struct BarChartDataEntry {
    let date: Date?
    let value: Double?
    var status: EntryType = .paid
}


    //MARK: - ViewModel
class DetailViewModel: ObservableObject {
    let initialData: [(Int, Double, EntryType)]
    var expenseCode: String?
//    @Published var expense: Expense?
    
    @Published var weekData: [BarChartDataEntry] = []
    @Published var monthData: [BarChartDataEntry] = []
    @Published var yearData: [BarChartDataEntry] = []
    @Published var quarterData: [BarChartDataEntry] = []
    
    @Published var combinedData: [[BarChartDataEntry]] = []
    
    @Published var name: String = "Expense"
    @Published var vendorName: String = "Vendor"
    
    @Published var maxAmount: Double = 0.00
//    @Published var maxValue: Double = 0
    @Published var lowValue: Double = 0.00
    @Published var averageValue: Double = 0.00
    @Published var lastValue: Double = 0.00
    
//    init(name: String, vendorName: String, dataSet: [(Int, Double, EntryType)]) {
//        self.name = name
//        self.vendorName = vendorName
//        self.initialData = dataSet
//
//        setArray()
//    }
    
    init(expenseCode: String?) {

        //Load Expense if not nil
        setArray()
    }
    
    private func loadData() -> [BarChartDataEntry] {
//        let  = testBarDataEntries
        var result = [BarChartDataEntry]()
        result = initialData.map({
            if $0.1 > self.maxAmount {
                self.maxAmount = $0.1
            }
            
            let date = Calendar.current.date(byAdding: .day, value: -$0.0, to: Date())
            return BarChartDataEntry(date: date, value: $0.1, status: $0.2)
        })
        return result
    }
    
    private func setDataDaysAmount(_ count: Int, data: [BarChartDataEntry]) -> [BarChartDataEntry] {
        var result = data.filter({
            Calendar.current.numberOfDaysBetween($0.date ?? Date(), and: Date()) <= count
        })
        for i in 0..<7 {
            if Calendar.current.numberOfDaysBetween(result[i].date ?? Date(), and: Date()) != i {
                result.insert(BarChartDataEntry(
                    date: Calendar.current.date(byAdding: .day, value: -i, to: Date()),
                    value: 0,
                    status: .paid), at: i)
            }
        }
        result.sort {
            $0.date! > $1.date!
        }
        return result.reversed()
    }
    
    private func setDataMonthsAmount(_ count: Int, data: [BarChartDataEntry]) -> [BarChartDataEntry] {
        var result = data.filter({
            Calendar.current.numberOfMonthsBetween($0.date ?? Date(), and: Date()) <= count
        })
        result.sort {
            $0.date! > $1.date!
        }
        return result
    }
    
    private func setDataQuartersAmount(_ count: Int, data: [BarChartDataEntry]) -> [BarChartDataEntry] {
        var result = data.filter({
            Calendar.current.numberOfQuartersBetween($0.date ?? Date(), and: Date()) <= count
        })
        result.sort {
            $0.date! < $1.date!
        }
        return result
    }
    
    private func setDataYearsAmount(_ count: Int, data: [BarChartDataEntry]) -> [BarChartDataEntry] {
        var result = data.filter({
            Calendar.current.numberOfYearsBetween($0.date ?? Date(), and: Date()) <= count
        })
        result.sort {
            $0.date! < $1.date!
        }
        return result
    }

    func setArray() {
        weekData = setDataDaysAmount(7, data: loadData())
        monthData = setDataMonthsAmount(1, data: loadData())
        yearData = setDataQuartersAmount(1, data: loadData())
        quarterData = setDataYearsAmount(1, data: loadData())
        combinedData = [
            setDataDaysAmount(7, data: loadData()),
            setDataMonthsAmount(1, data: loadData()),
            setDataQuartersAmount(1, data: loadData()),
            setDataYearsAmount(1, data: loadData())
        ]
    }
    
    func dateFormatterShort(date: Date?) -> String {
        guard let date = date else { return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"//this your string date format
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
//        dateFormatter.locale = Locale(identifier: "your_loc_id")
        return dateFormatter.string(from: date)
    }
    
}

// MARK: - Main View
struct DetailView: View {
    var expenseCode: String?
    @StateObject var vm = DetailViewModel(name:  "Electic Bill", vendorName: "DTE", dataSet: testBarDataEntries)
    @State var pickerSelectedItem = 3
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.init(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        header
                        subheader
                    }//Headers
//                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 8)
//                    .frame(height: 420)
                    .padding()
                    
                    VStack {
                        HStack {
                            InfoItemView(label: "Average", value: "$\(vm.averageValue)", tintColor: .mint, backgroundColor: .gray)
                            InfoItemView(label: "Last", value: "$\(vm.lastValue)", tintColor: .mint, backgroundColor: .gray)
                        }
                        HStack {
                            InfoItemView(label: "Low", value: "$\(vm.lowValue)", tintColor: .mint, backgroundColor: .gray)
                            InfoItemView(label: "Max", value: "$\(vm.maxAmount)", tintColor: .mint, backgroundColor: .gray)
                        }
                    }// Info Cells
//                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 8)
//                    .frame(height: 420)
                    .padding()

                    VStack {
                        ZStack {
                            Color.init(UIColor.label)
                            VStack {
                                picker
                                chart
                            }
                            .padding()
                        }
                    }// Chart+Picker
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 8)
                    .frame(height: 420)
                    .padding()
                }// MainVStack
                .padding()
                
            }// MainZStack
        }// MainScrollView
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

//MARK: - Extensions
extension DetailView {
    
    private var header: some View {
        Text(vm.name)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
//                    .foregroundColor(Color.init(UIColor.systemBackground))
    }
    
    private var subheader: some View {
        Text(vm.vendorName)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
    }
    
    private var picker: some View {
        Picker("", selection: $pickerSelectedItem) {
            ForEach(ChartRanges.allCases) { dp in
                Text(dp.name).tag(dp.rawValue)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 24)
            .animation(.default, value: pickerSelectedItem)
            .onAppear {
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.systemGray6
                UISegmentedControl.appearance().backgroundColor = UIColor.systemGray
                }
    }
    
    private var chart: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<self.vm.combinedData[pickerSelectedItem].count, id: \.self) { i in
                        BarView(value: self.vm.combinedData[pickerSelectedItem][i].value ?? 0,
                                xLabel: self.vm.dateFormatterShort(date: self.vm.combinedData[pickerSelectedItem][i].date),
                                maxAmount: self.vm.maxAmount)
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        
                    }
                }
                    .animation(.default, value: pickerSelectedItem)
                    .onChange(of: pickerSelectedItem, perform: { value in
                                    proxy.scrollTo(99)
                                })
            }
            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
            .padding()
            .onAppear(perform: {
                proxy.scrollTo(99)
                
            })
        }
    }
    
//    private var list: some View {
//        List {
//
//        }
//    }
    
}

//MARK: - Structs


struct InfoItemView: View {
    var label = ""
    var value = ""
    var tintColor: Color = Color.init(UIColor.systemBackground)
    var backgroundColor: Color = .gray.opacity(0.8)
    
    var body: some View {
        ZStack {
            backgroundColor
            VStack {
                backgroundColor
                
                Text(value)
                    .foregroundColor(tintColor)
                    .fontWeight(.bold)
                Text(label.localizedCapitalized)
                    .foregroundColor(Color.init(UIColor.systemBackground))
                    .fontWeight(.light)
            }
            .padding()
        }.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 8)

    }
}

struct BarView: View {
    var value: CGFloat = 0
    var xLabel: String = "D"
    var maxAmount: Double = 0
    var height: CGFloat = 200
    
    func valueToDisplay() -> String {
        if value > 0 {
            return "$\(value)"
        } else {
            return "  "
        }
    }
    
    var body: some View {
        HStack {
            VStack {
//                Text(valueToDisplay())
//                    .font(.system(size: 12))
//                    .foregroundColor(Color.init(UIColor.systemBackground))
                ZStack(alignment: .bottom) {
//                    Capsule().frame(width: 30, height: height)
//                        .foregroundColor(.gray.opacity(0.2))
                    RoundedRectangle(cornerRadius: 25, style: .continuous).frame(width: 30, height: height)
                        .foregroundColor(.gray.opacity(0.8))
                    Capsule().frame(width: 30, height: (value / (maxAmount * 1.1)) * 200)
                        .foregroundColor(Color.init(UIColor.systemBackground))
                    Text(valueToDisplay())
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: 270))
                        .padding(.bottom, 30)
//                    RoundedRectangle().frame(width: 30, height: height)
//                        .foregroundColor(.gray.opacity(0.2))
                }
                Text(xLabel).padding(.top, 8)
                    .font(.system(size: 12))
                    .foregroundColor(Color.init(UIColor.systemBackground))
            }
            
        }.padding(.top, 24)
    }
}

enum EntryType {
    case paid, unpaid
}

var testBarDataEntries = [
    (1, 448.18, EntryType.unpaid),
    (2, 427.98, EntryType.paid),
    (6, 444.44, EntryType.paid),
    (12, 481.92, EntryType.paid),
    (18, 480.82, EntryType.paid),
    (19, 420.69, EntryType.paid),
    (22, 427.27, EntryType.paid),
    (56, 401.38, EntryType.paid),
    (62, 490.11, EntryType.paid),
    (71, 403.88, EntryType.paid),
    (108, 450.82, EntryType.paid),
    (205, 440.87, EntryType.paid),
    (301, 429.56, EntryType.paid),
]


extension Calendar {
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let numberOfDays = dateComponents([.day], from: from, to: to)
        
        return numberOfDays.day!
    }
    
    func numberOfMonthsBetween(_ from: Date, and to: Date) -> Int {
        let numberOfMonths = dateComponents([.month], from: from, to: to)
        
        return numberOfMonths.month!
    }
    
    func numberOfYearsBetween(_ from: Date, and to: Date) -> Int {
        let numberOfYears = dateComponents([.year], from: from, to: to)
        
        return numberOfYears.year!
    }
    
    func numberOfQuartersBetween(_ from: Date, and to: Date) -> Int {
        let numberOfQuarters = dateComponents([.quarter], from: from, to: to)
        
        return numberOfQuarters.quarter!
    }
}
