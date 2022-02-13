//
//  Post.swift
//  DoubleSidedGallery
//
//  Created by M H on 31/01/2022.
//

import SwiftUI

struct Post: Identifiable, Hashable {
	var id = UUID().uuidString
	var postImage: String
}
