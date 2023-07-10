//
//  KeypadView.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

let KeySpacing: CGFloat = 20
let KeySize: CGFloat = 70

struct KeypadView: View {

    @Binding var inputText: String

    var body: some View {
        HStack(alignment:.top) {
            VStack(spacing:KeySpacing) {
                keyButton(key: "1", imageName: "1.circle")
                keyButton(key: "4", imageName: "4.circle")
                keyButton(key: "7", imageName: "7.circle")
                keyButton(key: "*", imageName: "staroflife.circle")
            }
            Spacer()
            
            VStack(spacing:KeySpacing) {
                keyButton(key: "2", imageName: "2.circle")
                keyButton(key: "5", imageName: "5.circle")
                keyButton(key: "8", imageName: "8.circle")
                keyButton(key: "0", imageName: "0.circle")

                Button {
                    let telephone = "tel://"
                    let formattedString = telephone + inputText
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    keypadImage(imgName: "phone.circle.fill", size: KeySize)
                        .foregroundColor(.green)
                }
            }
            
            Spacer()

            VStack(spacing:KeySpacing) {
                keyButton(key: "3", imageName: "3.circle")
                keyButton(key: "6", imageName: "6.circle")
                keyButton(key: "9", imageName: "9.circle")
                keyButton(key: "#", imageName: "number.circle")

                if inputText.isEmpty == false {
                    ZStack {
                        Button {
                            inputText.removeLast()
                        } label: {
                            Image(systemName: "delete.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .frame(width: KeySize, height: KeySize)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
    }
    
    private func keyButton(key: String, imageName: String, size: CGFloat = KeySize) -> some View {
        return Button {
            inputText = inputText + key
        } label: {
            keypadImage(imgName: imageName, size: size)
        }
    }
    
    private func keypadImage(imgName: String, size: CGFloat) -> some View {
        return Image(systemName: imgName)
            .resizable()
            .frame(width: size, height: size)
    }
}

struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView(inputText: .constant("1")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
