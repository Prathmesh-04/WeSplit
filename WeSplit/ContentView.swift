import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberofpeople = 2
    @State private var tippercentage = 20
    @FocusState private var amtFocus : Bool
    let tipPercentages = [0,5,10,15,20]
    
    func totalPerPerson() -> Double{
        let peopleCount = Double(numberofpeople)
        let tipSelection = Double(tippercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 16){
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
                            .background(.gray.opacity(0.15), in: Circle())
                        TextField("Amount", value: $checkAmount , format: .number.precision(.fractionLength(2)))
                            .keyboardType(.decimalPad)
                            .focused($amtFocus)
                            .font(.system(size: 40, weight: .semibold))
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.3)))
                .padding(.horizontal)
                
                VStack(alignment: .leading){
                    Text("NUMBER OF PEOPLE")
                        .font(.caption)
                        .tracking(2)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 12){
                        Image(systemName: "person.2")
                            .frame(width: 44, height: 44)
                            .background(.gray.opacity(0.15), in: Circle())
                        Text("\(numberofpeople)")
                            .font(.system(size: 40, weight: .semibold))
                        Text("people")
                            .foregroundStyle(.secondary)
                        Spacer()
                        
                        Button{
                            numberofpeople = max(2,numberofpeople-1)
                        } label: {
                            Image(systemName: "minus")
                                .frame(width: 44, height: 44)
                                .background(.gray.opacity(0.15) , in: Circle())
                        }
                        
                        Button{
                            numberofpeople = min(10,numberofpeople+1)
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 44, height: 44)
                                .background(.gray.opacity(0.15) , in: Circle())
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.3)))
                .padding(.horizontal)
                
                VStack(alignment: .leading){
                    Text("HOW MUCH DO YOU WANT TO TIP?")
                        .font(.caption)
                        .tracking(2)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 8){
                        ForEach(tipPercentages , id: \.self){ percent in
                            Button{
                                tippercentage = percent
                            } label:{
                                Text(percent, format: .percent)
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        tippercentage == percent ? Color.primary : Color.gray.opacity(0.15) ,
                                        in: Capsule()
                                    )
                                    .foregroundStyle(tippercentage == percent ? Color(.systemBackground) : .primary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.3)))
                .padding(.horizontal)
                
                HStack{
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.3))
                    Text("SPLIT")
                        .font(.caption)
                        .tracking(2)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 8)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.3))
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                VStack(alignment: .leading){
                    Text("AMOUNT PER PERSON")
                        .font(.caption)
                        .tracking(2)
                        .foregroundStyle(.secondary)
                    
                    HStack{
                        Image(systemName: "creditcard")
                            .frame(width: 46, height: 46)
                            .background(.gray.opacity(0.15), in: Circle())
                            .padding(.vertical, 12)
                        Spacer()
                        Text(totalPerPerson(), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .font(.system(size: 32, weight: .semibold))
                               
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.3)))
                .padding(.horizontal)
                
                Spacer()
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

