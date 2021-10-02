//
//  ContentView.swift
//  Memorize
//
//  Created by Adithya KNG on 02/10/21.
//

import SwiftUI

struct ContentView: View {
    var fruitsEmojis = ["🍏","🍎","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍"]
    let objectsEmojis = ["⌚️","📱","💻","⌨️","🖥","🖨","🖲","🕹","🗜","💽","💾","💿","📷","☎️"]
    let natureEmojis = ["🌳", "🌲", "🌵", "🌷", "🌴", "🌻", "🌺", "⛰", "🗻", "🍄"]
    
    @State var currentEmojis: Array<String>
    @State var selectedColor: Color
    init(){
        currentEmojis = fruitsEmojis
        selectedColor = .red
    }
    @State var upperLimit = 7
    
    var body: some View {
        VStack {
//            Grid View for Cards with ScrollView as parent
            header
            cardGridView
            footer
            
        }
        .padding()
    }
    
    var header : some View {
        Text("Memorize!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(selectedColor)
    }
    
    var footer : some View {
        let subjects = [
            Topics(name: "Fruits", color: .red, symbol: "applelogo"),
            Topics(name: "Technology", color: .green, symbol: "tv.circle"),
            Topics(name: "Nature", color: .orange, symbol: "leaf.circle")
        ]
        return HStack{
            Spacer()
            ForEach(subjects,id:\.name){subject in
                VStack{
                    Image(systemName: subject.symbol)
                        .padding(.bottom, 2.0)
                    Text(subject.name)
                        .font(.subheadline)
                }
                .onTapGesture {
                    if (subject.name) == "Fruits"{
                        currentEmojis = fruitsEmojis.shuffled();
                        selectedColor = subject.color
                    }
                    else if (subject.name) == "Technology"{
                        currentEmojis = objectsEmojis.shuffled();
                        selectedColor = subject.color
                    }
                    else{
                        currentEmojis = natureEmojis.shuffled();
                        selectedColor = subject.color
                    }
                }
                Spacer()
            }
        }
        .font(.title)
        .foregroundColor(selectedColor)
    }
    
    var cardGridView : some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                ForEach(currentEmojis[0...upperLimit], id: \.self){ emoji in
                    CardView(content: emoji,selectedColor: selectedColor)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
}


struct CardView : View {
    var content: String
    @State var isEmojiVisible : Bool = true
    var selectedColor: Color
    var body: some View{
        if isEmojiVisible {
            ZStack {
                RoundedRectangle(cornerRadius: 25).fill(.white)
                RoundedRectangle(cornerRadius:25)
                    .strokeBorder(selectedColor,lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
                    
           }
            .onTapGesture {
                isEmojiVisible = !isEmojiVisible
            }
        }
        else {
            RoundedRectangle(cornerRadius: 25).fill(.red)
                .onTapGesture {
                    isEmojiVisible = !isEmojiVisible
                }
        }
    }
}


struct Topics : Identifiable {
    var id = UUID()
    var name: String
    var color: Color
    var symbol: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
