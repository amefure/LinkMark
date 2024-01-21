//
//  AppLockInputView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/20.
//

import SwiftUI

/// 設定ページからモーダルとして呼び出される
struct AppLockInputView: View {
    // MARK: - Receive

    @Binding var isLock: Bool

    // MARK: - View

    @State private var password: [String] = []

    @StateObject private var viewModel = AppLockInputViewModel()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Text(L10n.appLockInputTitle)
                .fontWeight(.bold)
                .foregroundStyle(.exText)

            Spacer()

            DisplayPasswordView(password: password)

            Spacer()

            Button {
                if password.count == 4 {
                    viewModel.entryPassword(password: password)
                    dismiss()
                }
            } label: {
                Text(L10n.appLockInputEntryButton)
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width: 100)
                    .background(password.count != 4 ? .exLightGray : .exGreen)
                    .foregroundStyle(password.count != 4 ? .gray : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 2))
                            .frame(width: 100)
                            .foregroundStyle(password.count != 4 ? .exLightGray : .exGreen)
                    }.padding(.vertical, 20)
                    .shadow(color: password.count != 4 ? .clear : .gray, radius: 3, x: 4, y: 4)

            }.disabled(password.count != 4)

            Spacer()

            NumberKeyboardView(password: $password)
                .ignoresSafeArea(.all)
        }.onDisappear {
            if viewModel.entryFlag {
                isLock = true
            } else {
                isLock = false
            }
        }.background(.exThema)
    }
}

#Preview {
    AppLockInputView(isLock: Binding.constant(true))
}

