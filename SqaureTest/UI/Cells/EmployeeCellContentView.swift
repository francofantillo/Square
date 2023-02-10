//
//  EmployeeCellContentView.swift
//  SqaureTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import SwiftUI
import CachedAsyncImage

extension EmployeeCell {
    struct ContentView: View {
        
        let employee: Employee
        
        private let sizes = CellSizes()
        
        var body: some View {

            VStack {
                VStack {
                    ZStack {
                        CachedAsyncImage(url: URL(string: employee.photoURLSmall)!) { phase in
                                switch phase {
                                case .failure:
                                        Image(systemName: "photo")
                                                .font(.largeTitle)
                                                
                                    
                                case .success(let image):
                                        image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(minWidth: sizes.width - 20,
                                                       maxWidth: sizes.width - 20,
                                                       minHeight: sizes.width - 20,
                                                       maxHeight: sizes.width - 20)
                                                
                                                .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(.white, lineWidth: 2)
                                                    )
                                                
                                default: ProgressView()
                                }
                        }
                        .cornerRadius(10)
                        .padding(.top)
                        
                    }
                    Text(employee.fullName)
                        .font(.system(size: 15))
                        .padding([.leading, .trailing, .bottom])
                        .padding(.top)
                        .frame(height: 20)
                    HStack(alignment: .top) {
                        
                        Text("Team:")
                            .padding([.leading])
                            .padding(.top, 2)
                            .font(.system(size: 10))

                        Text(employee.team)
                            .lineLimit(2)
                            .padding([.trailing])
                            .padding(.top, 2)
                            .font(.system(size: 10))
                        Spacer()
                        
                    }
                    
                    Text(employee.bio)
                        .lineLimit(3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 10))
                        .padding([.leading, .trailing])
                        .padding(.top, 2)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(minWidth: sizes.width, maxWidth: sizes.width, minHeight: sizes.height, maxHeight: sizes.height)
                
                .background(Color("Background"))
                .ignoresSafeArea()
                .cornerRadius(10)
                
                
            }
            .shadow(color: .gray, radius: 6)
        }
    }
}

struct PopularMovieCellContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeCell.ContentView(employee: .example)
            .previewLayout(.fixed(width: 200, height: 350))
    }
}
