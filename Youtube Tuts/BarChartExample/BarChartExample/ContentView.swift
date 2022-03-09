////
////  ContentView.swift
////  BarChartExample
////
////  Created by Ryan Cummins on 12/20/21.
////
//
//import SwiftUI
//
//enum DayParts: Int, CaseIterable, Hashable, Identifiable {
//    case morning = 0
//    case afternoon
//    case evening
//
//    var name: String {
//        return "\(self)".capitalized
//    }
//
//    var id: DayParts {self}
//}
//
////enum Days: CaseIterable, Hashable, Identifiable {
////
////    case sunday
////    case monday
////    case tuesday
////    case wednesday
////    case thursday
////    case friday
////    case saturday
////
////    var shortName: String {
////        return String("\(self)".prefix(2)).capitalized
////    }
////    var id: Days {self}
////}
//
//struct ContentView: View {
//
//    @State var pickerSelectedItem = 0
//
//    @State var data: [(dayPart: DayParts, calorieByDay: [(day: Days, calories: Int)])] = [
//        (
//            DayParts.morning, [
//                (Days.sunday, 10),
//                (Days.monday, 20),
//                (Days.tuesday, 30),
//                (Days.wednesday, 40),
//                (Days.thursday, 50),
//                (Days.friday, 60),
//                (Days.saturday, 70),
//            ]
//        ),
//        (
//            DayParts.afternoon, [
//                (Days.sunday, 110),
//                (Days.monday, 80),
//                (Days.tuesday, 120),
//                (Days.wednesday, 200),
//                (Days.thursday, 150),
//                (Days.friday, 65),
//                (Days.saturday, 70),
//            ]
//        ),
//        (
//            DayParts.evening, [
//                (Days.sunday, 120),
//                (Days.monday, 20),
//                (Days.tuesday, 25),
//                (Days.wednesday, 90),
//                (Days.thursday, 110),
//                (Days.friday, 60),
//                (Days.saturday, 10),
//            ]
//        )
//    ]
//
//
//    var body: some View {
//        ZStack {
//            Color.mint.edgesIgnoringSafeArea(.all)
//
//            VStack {
//                header
//                
//                picker
//
////                BarChart()
//
//
//                HStack {
//                    ForEach(0..<self.data[pickerSelectedItem].calorieByDay.count, id: \.self) { i in
//                        BarView(value: self.data[self.pickerSelectedItem].calorieByDay[i].calories,
//                                xLabel: self.data[self.pickerSelectedItem].calorieByDay[i].day.shortName)
//                    }
//                }.padding(.top, 24)
//                    .animation(.default, value: pickerSelectedItem)
////                ForEach(Array(dataPoints[pickerSelectedItem].enumerated()), id: \.offset) {( _, data in
////                                                                                            BarView(value: data)
////
////                )}
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//extension ContentView {
//
//    private var header: some View {
//        Text("Calorie Intake")
//                    .font(.system(size: 34))
//                    .fontWeight(.heavy)
//    }
//
//    private var picker: some View {
//        Picker("", selection: $pickerSelectedItem) {
//            ForEach(DayParts.allCases) { dp in
//                Text(dp.name).tag(dp.rawValue)
//            }
//        }.pickerStyle(SegmentedPickerStyle())
//            .padding(.horizontal, 24)
//            .animation(.default, value: pickerSelectedItem)
//    }
//
//}
//
////struct BarChart: View {
////    var body: some View {
////        HStack(spacing: 16) {
////                BarView(value: dataPoints[pickerSelectedItem][0])
////                BarView(value: dataPoints[pickerSelectedItem][1])
////                BarView(value: dataPoints[pickerSelectedItem][2])
////                BarView(value: dataPoints[pickerSelectedItem][3])
////                BarView(value: dataPoints[pickerSelectedItem][4])
////            }.padding(.top, 24)
////                .animation(.default)
////    }
////}
//
////struct BarView: View {
////    var value: Int = 0
////    var valueDisplay: String = ""
////    var xLabel: String = "D"
////    var height: CGFloat = 200
////
////    var body: some View {
////        HStack {
////            VStack {
////                Text("\(Int(value))")
////                ZStack(alignment: .bottom) {
////                    Capsule().frame(width: 30, height: height)
////                        .foregroundColor(.gray.opacity(0.2))
////                    Capsule().frame(width: 30, height: CGFloat(value))
////                        .foregroundColor(.white)
////                }
////                Text(xLabel).padding(.top, 8)
////            }
////
////        }.padding(.top, 24)
////    }
////}
