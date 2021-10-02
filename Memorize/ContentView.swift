//
//  ContentView.swift
//  Memorize
//
//  Created by Adithya KNG on 02/10/21.
//

import SwiftUI

struct ContentView: View {
    let fruitsEmojis = ["🍏","🍎","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍"]
    let objectsEmojis = ["⌚️","📱","💻","⌨️","🖥","🖨","🖲","🕹","🗜","💽","💾","💿","📷","☎️"]
    let natureEmojis = ["🌳", "🌲", "🌵", "🌷", "🌴", "🌻", "🌺", "⛰", "🗻", "🍄"]
    
    @State var upperLimit = 7
    var body: some View {
        VStack {
//            Grid View for Cards with ScrollView as parent
            cardGridView
//            Footer containing + and - buttons
            footer
        }
        .padding()
    }
    
    var footer : some View {
        HStack{
            Image(systemName: "minus.circle")
                .onTapGesture {
                    if upperLimit >= 1 {
                        upperLimit -= 1
                    }
                }
            Spacer()
            Image(systemName: "plus.circle")
                .onTapGesture {
                    if upperLimit + 1 < fruitsEmojis.count {
                        upperLimit += 1
                    }
                }
        }
        .font(.largeTitle)
        .foregroundColor(.blue)
    }
    
    var cardGridView : some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                ForEach(fruitsEmojis[0...upperLimit], id: \.self){ emoji in
                    CardView(content: emoji)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
}


struct CardView : View {
    var content: String
    @State var isEmojiVisible : Bool = true
    var body: some View{
        if isEmojiVisible {
            ZStack {
                RoundedRectangle(cornerRadius: 25).fill(.white)
                RoundedRectangle(cornerRadius:25)
                    .strokeBorder(Color.red,lineWidth: 3)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
