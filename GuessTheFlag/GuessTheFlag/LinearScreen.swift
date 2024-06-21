//
//  LinearScreen.swift
//  GuessTheFlag
//
//  Created by Günseli Ünsal on 19.06.2024.
//

import SwiftUI

struct LinearScreen: View {
    @State private var showAlert = false
    var body: some View {
        ZStack{
            Button(action: {showAlert = true}, label: {
                Text("Hesabımı Sil")
            })
            .alert("Hesabınızı silmek istediğinize emin misiniz?", isPresented: $showAlert) {
                Button("Delete", role: .destructive){}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("‼️ Silinen hesap geri yüklenemez.")
            }
        }
    }
}

#Preview {
    LinearScreen()
}
