import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberofpeople = 2
    @State private var tippercentage = 20
    @FocusState private var amtFocus : Bool
    let tipPercentages = [0,5,10,15,20]
    
    func totalPerPerson() -> Double{
        let peopleCount = Double(numberofpeople+2)
        let tipSelection = Double(tippercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    @State private var amtPerPerson = 0.0
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("WeSplit")
                    .font(.system(size: 48, weight: .bold))
                    .padding(.horizontal)
                Text("Good food tastes better when shared.")
                    .font(.caption)
                    .tracking(2)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                    .padding(.horizontal)
                VStack(alignment: .leading){
                    Text("TOTAL BILL")
                        .font(.caption)
                        .tracking(2)
                        .foregroundStyle(.secondary)
                    HStack{
                        Text("₹")
                            .font(.title2)
                            .frame(width: 44, height: 44)
                            .background(.gray.opacity(0.15), in:Circle())
                        Text("0.00")
                            .font(.system(size: 40, weight: .semibold))
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.3)))
                }
                
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
                        Text(amtPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                    Section{
                        Button("Split Bill"){
                            amtPerPerson = totalPerPerson()
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard ){
                    Spacer()
                    Button("Done"){
                        amtFocus = false
                    }
                }
            }
            .toolbar(.hidden, for:.navigationBar)

        }
    }
}

#Preview {
    ContentView()
}

