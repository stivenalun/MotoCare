//
//  TextTextFieldView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 01/11/23.
//

import SwiftUI

struct TextTextFieldView: View {
    
    @State var title: String = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        TextField("Say something", text: $title)
            .keyboardType(.numberPad)
    }
}

#Preview {
    TextTextFieldView()
}
