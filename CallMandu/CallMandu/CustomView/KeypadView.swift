//
//  KeypadView.swift
//  CallMandu
//
//  Created by mandu on 2023/04/16.
//

import SwiftUI

struct KeypadView: View {
    
    @Binding var inputText: String

    var body: some View {
        HStack(alignment:.top) {
            VStack(spacing:20) {
                Button {
                    inputText = inputText + "1"
                } label: {
                    keypadImage(imgName: "1.circle", size: 70)
                }

                Button {
                    inputText = inputText + "4"
                } label: {
                    keypadImage(imgName: "4.circle", size: 70)
                }

                Button {
                    inputText = inputText + "7"
                } label: {
                    keypadImage(imgName: "7.circle", size: 70)
                }

                Button {
                    inputText = inputText + "*"
                } label: {
                    keypadImage(imgName: "staroflife.circle", size: 70)
                }
            }
            
            Spacer()
            
            VStack(spacing:20) {
                Button {
                    inputText = inputText + "2"
                } label: {
                    keypadImage(imgName: "2.circle", size: 70)
                }

                Button {
                    inputText = inputText + "5"
                } label: {
                    keypadImage(imgName: "5.circle", size: 70)
                }

                Button {
                    inputText = inputText + "8"
                } label: {
                    keypadImage(imgName: "8.circle", size: 70)
                }

                Button {
                    inputText = inputText + "0"
                } label: {
                    keypadImage(imgName: "0.circle", size: 70)
                }

                Button {
                    // TODO: 전화 고~~
                } label: {
                    keypadImage(imgName: "phone.circle.fill", size: 70)
                        .foregroundColor(.green)
                }
            }
            
            Spacer()

            VStack(spacing:20) {
                Button {
                    inputText = inputText + "3"
                } label: {
                    keypadImage(imgName: "3.circle", size: 70)
                }

                Button {
                    inputText = inputText + "6"
                } label: {
                    keypadImage(imgName: "6.circle", size: 70)
                }

                Button {
                    inputText = inputText + "9"
                } label: {
                    keypadImage(imgName: "9.circle", size: 70)
                }

                Button {
                    inputText = inputText + "#"
                } label: {
                    keypadImage(imgName: "number.circle", size: 70)
                }

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
                    .frame(width: 70, height: 70)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
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
