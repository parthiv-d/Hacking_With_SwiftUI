//
//  Helper.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import Foundation
import SwiftUI
import Combine

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var url: URL?
    private var cancellable: AnyCancellable?

    init(url: URL?) {
        self.url = url
        loadImage()
    }

    func loadImage() {
        guard let url = url else { return }
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cached
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] img in
                guard let img = img else { return }
                ImageCache.shared.setObject(img, forKey: url as NSURL)
                self?.image = img
            }
    }
}

struct AsyncCachedImage: View {
    @StateObject private var loader: ImageLoader
    var placeholder: () -> AnyView

    init(url: URL?, @ViewBuilder placeholder: @escaping () -> AnyView = { AnyView(EmptyView()) }) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        if let img = loader.image {
            Image(uiImage: img)
                .resizable()
        } else {
            placeholder()
        }
    }
}

struct HCard: View {
    var section: InitialModel
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(section.caption)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Divider()
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .foregroundColor(.white)
        .background(section.color)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct GCard: View {
    var title: String
    var color: Color = randomPresetColor()
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity/2.5, maxHeight: 110)
        .foregroundColor(.white)
        .background(.linearGradient(colors: [color.opacity(1), color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
    
}

struct DrinkCard: View {
    var section: Drink
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                AsyncCachedImage(url: URL(string: section.strDrinkThumb ?? "")) {
                    AnyView(
                        ProgressView()
                            .frame(width: 80, height: 80)
                    )
                }
                .scaledToFill()
                .frame(width: 80, height: 80)
                .background(.black.opacity(0.5))
                .clipShape(Circle())
                
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    Text(section.strDrink)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(section.strCategory ?? "")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                    if (section.strIBA != nil) {
                        Text(section.strIBA ?? "")
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Text(section.strAlcoholic ?? "")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Text("Main Ingredients: \(section.strIngredient1 ?? ""), \(section.strIngredient2 ?? "")")
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .padding(30)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(randomPresetColor())
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

func randomPresetColor() -> Color {
    let hexColors = ["7850F0", "6792FF", "005FE7", "9CC5FF", "005FE7"]
    guard let randomHex = hexColors.randomElement() else {
        return .gray // fallback color
    }
    return Color(hex: randomHex)
}




struct VCard: View {
    var drink: Drink?
    var color: Color = randomPresetColor()

    var onAlternate: ((String) -> Void)?
    var onTags: ((String) -> Void)?
    var onVideo: ((String) -> Void)?
    var onCategory: ((String) -> Void)?
    var onIBA: ((String) -> Void)?
    var onAlcoholic: ((String) -> Void)?
    var onGlass: ((String) -> Void)?
    var onIngredient: ((String, String) -> Void)? // ingredient, measure

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                AsyncCachedImage(url: URL(string: drink?.strDrinkThumb ?? ""))
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.5))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            }
            .frame(maxWidth: .infinity)

            Text("Drink Name: \(drink?.strDrink ?? "Unknown Drink")")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .layoutPriority(1)

            if let alternate = drink?.strDrinkAlternate, !alternate.isEmpty {
                Button(action: { onAlternate?(alternate) }) {
                    Text("Drink Alternate: \(alternate)")
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if let tags = drink?.strTags, !tags.isEmpty {
                Button(action: { onTags?(tags) }) {
                    Text("Drink Tags: \(tags)")
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if let video = drink?.strVideo, !video.isEmpty {
                Button(action: { onVideo?(video) }) {
                    Text("Drink Video: \(video)")
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if let category = drink?.strCategory, !category.isEmpty {
                Button(action: { onCategory?(category) }) {
                    Text("Drink Category: \(category)")
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if let iba = drink?.strIBA, !iba.isEmpty {
                Button(action: { onIBA?(iba) }) {
                    Text("Drink IBA: \(iba)")
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if let alcoholic = drink?.strAlcoholic, !alcoholic.isEmpty {
                Button(action: { onAlcoholic?(alcoholic) }) {
                    Text("Drink Type: \(alcoholic)")
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if let glass = drink?.strGlass, !glass.isEmpty {
                Button(action: { onGlass?(glass) }) {
                    Text("Glass Type: \(glass)")
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if let drink = drink {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ingredients:")
                        .font(.headline)
                    ForEach(drink.ingredientsWithMeasures, id: \.ingredient) { pair in
                        Button(action: { onIngredient?(pair.ingredient, pair.measure) }) {
                            Text("\(pair.ingredient): \(pair.measure)")
                                .opacity(0.8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }

            if let instructions = drink?.strInstructions, !instructions.isEmpty {
                Text("Instructions:")
                    .font(.headline)
                Text("\(instructions)")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
        }
        .foregroundColor(.white)
        .padding(30)
        .background(.linearGradient(colors: [color.opacity(1), color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: color.opacity(0.3), radius: 2, x: 0, y: 1)
    }
}
