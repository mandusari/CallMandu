//
//  NumberInputView.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

struct NumberInputView: View {
    
    @State private var inputText = ""
    
    var body: some View {
        VStack {
            TextField("", text: $inputText)
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 50, trailing: 50))
            KeypadView(inputText: $inputText)
        }
        
    }
}


struct NumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        NumberInputView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
