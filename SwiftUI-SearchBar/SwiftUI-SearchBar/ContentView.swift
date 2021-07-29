//
//  ContentView.swift
//  SwiftUI-SearchBar
//
//  Created by David Boyd on 6/7/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                HStack {
                    HStack {
                        TextField("Search terms here", text: $searchText)
                            .padding(.leading, 24)
                            .keyboardType(.default)
                    }
                    .padding()
                    .frame(height: 35)
                    .background(Color(.systemGray4))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .onTapGesture(perform: {
                        isSearching = true
                    })
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            
                            if isSearching {
                                Button(action: { searchText = "" }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .padding(.vertical)
                                })
                            }
                        }.padding(.horizontal, 32)
                        .foregroundColor(.gray)
                    )
                    if isSearching {
                        Button(action: {
                            isSearching = false
                            searchText = ""
                            hideKeyboard()
                        }, label: {
                            Text("Cancel")
                                .padding(.trailing)
                                .padding(.leading, -12)
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                    }
                }
                
                ForEach((0..<20).filter({"\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) { num in
                    
                    HStack {
                        Text("\(num)")
                        Spacer()
                    }.padding()
                    Divider()
                        .background(Color(.systemGray4))
                        .padding(.leading)
                }
            }.navigationTitle("Food")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
