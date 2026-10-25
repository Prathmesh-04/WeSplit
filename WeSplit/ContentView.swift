import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberofpeople = 2
    @State private var tippercentage = 20
    @FocusState private var amtFocus : Bool
    let tipPercentages = [0,5,10,15,20]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberofpeople+2)
        let tipSelection = Double(tippercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amtFocus)
                    
                    Picker("Number of People", selection: $numberofpeople){
                        ForEach(2..<11){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip ?"){
                    Picker("Tip percentage", selection: $tippercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amtFocus {
                    Button("Done") {
                        amtFocus = false
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}

