//
//  EmployeeCellContentView.swift
//  SqaureTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import SwiftUI

extension EmployeeCell {
    struct ContentView: View {
        let employee: Employee
        let sizes = CellSizes()
        
        var body: some View {

            VStack {
                ZStack {
                    AsyncImage(url: URL(string: employee.photoURLSmall)!) { phase in
                            switch phase {
                            case .failure:
                                    Image(systemName: "photo")
                                            .font(.largeTitle)
                            case .success(let image):
                                    image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                            default: ProgressView()
                            }
                    }
                    .cornerRadius(10)
                    .padding(.top)
                    
            }
            HStack{
                Text("employee.title")
                    .font(.system(size: 18))
                    .padding([.leading, .trailing])
                    .padding(.top)
                    .frame(height: 20)
            }
            Text("employee.overview")
                .lineLimit(3)
                .padding([.leading, .trailing, .bottom])
                .padding(.top, 2)
                .font(.system(size: 14))
                .foregroundColor(Color("Dark Gray"))
            }
            .frame(minWidth: sizes.width, maxWidth: sizes.width, minHeight: sizes.height, maxHeight: sizes.height)
            .background(Color("Background"))
            .ignoresSafeArea()
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct PopularMovieCellContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeCell.ContentView(employee: .example)
            .previewLayout(.fixed(width: 200, height: 350))
    }
}
