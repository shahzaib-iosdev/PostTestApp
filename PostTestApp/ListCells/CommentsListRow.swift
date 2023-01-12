//
//  CommentsListRow.swift
//  PostTestApp
//
//  Created by CrownSDS on 11/01/2023.
//

import SwiftUI

struct CommentsListRow: View {
    
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Color.gray.opacity(0.05)
        VStack(alignment: .leading,spacing: 10)
        {
            VStack(alignment: .leading,spacing: 10)
            {
                HStack
                {
                    Text("\(viewModel.comments.name)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                    
                }
                HStack
                {
                    Text("\(viewModel.comments.body)")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
            
        }
        .frame(width: UIScreen.main.bounds.size.width - 30,alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.40), radius: 3, x: 0, y: 3)
        )
        //.frame(height: 40)
        //.padding()
        
    }
}
