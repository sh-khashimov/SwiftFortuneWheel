//
//  ContentView.swift
//  Shared
//
//  Created by Sherzod Khashimov on 07/01/22.
//

import SwiftUI
import SwiftFortuneWheel

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    HStack {
                        Text("Rotate To Index:")
                        TextField("Index", value: $viewModel.finishIndex, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Rotate") {
                            UIApplication.shared.endEditing()
                            viewModel.rotateToIndex.send(self.viewModel.finishIndex)
                        }
                        .buttonStyle(CyanButton())
                    }
                    Picker("Colors", selection: $viewModel.colorIndex) {
                        Text("Black-Cyan").tag(0)
                        Text("Rainbow").tag(1)
                    }
                    .pickerStyle(.segmented)
                    ControlGroup {
                        Button("Add Prize") {
                            viewModel.increasePrize()
                        }
                        Button("Remove Prize") {
                            viewModel.decreasePrize()
                        }
                    }
                    HStack {
                        Toggle("Draw Curved Line:", isOn: $viewModel.drawCurvedLine)
                            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    }
                    SFWView(prizes: $viewModel.prizes, configuration: $viewModel.wheelConfiguration, isMonochrome: $viewModel.isMonochrome, isWithLine: $viewModel.drawCurvedLine, onSpinButtonTap: $viewModel.onRotateTap, rotateToIndex: viewModel.rotateToIndex.eraseToAnyPublisher(), shouldRedraw: viewModel.shouldRedraw.eraseToAnyPublisher())
                        .frame(minWidth: 50, idealWidth: 500, maxWidth: .infinity, minHeight: 50, idealHeight: 500, maxHeight: .infinity, alignment: .center)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(10)
                }
                .padding()
            }
            .navigationTitle("SwiftFortuneWheel")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
