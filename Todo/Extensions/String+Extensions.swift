//
//  String+Extensions.swift
//  Todo
//
//  Created by Jean on 09/11/24.
//
extension String {
    var isEmptyOrWhitespace: Bool
    {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
