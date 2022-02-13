//
//  Home.swift
//  DoubleSidedGallery
//
//  Created by M H on 31/01/2022.
//

import SwiftUI

struct Home: View {
	
	@State var posts: [Post] = []
	@State var currnetPost: String = ""
	@State var fullPreview: Bool = false
	
    var body: some View {
		TabView(selection: $currnetPost, content: {
			ForEach(posts) { post in
				GeometryReader { proxy in
					Image(post.postImage)
						.resizable()
						.scaledToFill()
						.frame(width: proxy.size.width, height: proxy.size.height)
						.cornerRadius(8)
				} // gr
				.tag(post.id)
				.ignoresSafeArea()
			} // loop
		}) //tv
			.tabViewStyle(.page(indexDisplayMode: .never))
			.ignoresSafeArea()
			.onTapGesture {
				withAnimation{
					fullPreview.toggle()
				}
			}
			.overlay(
				HStack {
					Text("Pictures")
						.font(.title2.bold())
					Spacer()
					Button(action: {
						
					}, label: {
						Image(systemName: "square.and.arrow.up.fill")
							.font(.title2)
							
					})
				} // h
					.foregroundColor(.white)
					.padding()
					.background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
					.offset(y: fullPreview ? -150 : 0)
				, alignment: .top
			)
			.overlay(
				ScrollViewReader { proxy in
					
					ScrollView(.horizontal, showsIndicators: false) {
						
						HStack(spacing: 15) {
							ForEach(posts) { post in
								Image(post.postImage)
									.resizable()
									.scaledToFill()
									.frame(width: 70, height: 60)
									.cornerRadius(12)
									.padding(2)
									.overlay(
									RoundedRectangle(cornerRadius: 12)
										.strokeBorder(Color.white, lineWidth: 2)
										.opacity(currnetPost == post.id ? 1 : 0)
									)
									.id(post.id)
									.onTapGesture {
										currnetPost = post.id
									}
							} // loop
						} // h
						.padding()
					} // scrv
					.frame(height: 80)
					.background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
					.onChange(of: currnetPost, perform: { _ in
						withAnimation{
							proxy.scrollTo(currnetPost, anchor: .bottom)
						} // an
					}) // change
				}
					.offset(y: fullPreview ? 150 : 0)
				, alignment: .bottom // scr
			)
			.onAppear{
				for index in 1...8 {
					posts.append(Post(postImage: "post\(index)"))
				} // f
				currnetPost = posts.first?.id ?? ""
			} // app
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
