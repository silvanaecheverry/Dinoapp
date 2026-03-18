import SwiftUI

struct SponsoredBanner: View {
    let style: BannerStyle

    enum BannerStyle {
        case compact(
            sponsorName: String,
            title: String,
            description: String,
            ctaText: String,
            imageName: String
        )
        case large(
            title: String,
            subtitle: String,
            ctaText: String,
            imageName: String
        )
    }

    var body: some View {
        switch style {
        case let .compact(sponsorName, title, description, ctaText, imageName):
            compactBanner(
                sponsorName: sponsorName,
                title: title,
                description: description,
                ctaText: ctaText,
                imageName: imageName
            )
        case let .large(title, subtitle, ctaText, imageName):
            largeBanner(
                title: title,
                subtitle: subtitle,
                ctaText: ctaText,
                imageName: imageName
            )
        }
    }

    // MARK: - Compact Banner

    private func compactBanner(
        sponsorName: String,
        title: String,
        description: String,
        ctaText: String,
        imageName: String
    ) -> some View {
        HStack(spacing: 12) {
            // Image placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(DinoColors.lightGray)
                .frame(width: 80, height: 80)
                .overlay {
                    Image(systemName: imageName)
                        .font(.system(size: 28))
                        .foregroundStyle(DinoColors.mediumGray)
                }

            VStack(alignment: .leading, spacing: 4) {
                sponsoredPill

                Text(sponsorName)
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.mediumGray)

                Text(title)
                    .font(DinoFonts.subheadline)
                    .foregroundStyle(DinoColors.darkText)
                    .lineLimit(1)

                Text(description)
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.bodyText)
                    .lineLimit(1)
            }

            Spacer()

            Button {} label: {
                Text(ctaText)
                    .font(DinoFonts.callout)
                    .foregroundStyle(DinoColors.darkText)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(DinoColors.yellow)
                    .clipShape(Capsule())
            }
        }
        .padding(12)
        .dinoCard()
    }

    // MARK: - Large Banner

    private func largeBanner(
        title: String,
        subtitle: String,
        ctaText: String,
        imageName: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image area
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 0)
                    .fill(DinoColors.lightGray)
                    .frame(height: 160)
                    .overlay {
                        Image(systemName: imageName)
                            .font(.system(size: 48))
                            .foregroundStyle(DinoColors.mediumGray)
                    }

                sponsoredPill
                    .padding(10)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(DinoFonts.headline)
                    .foregroundStyle(DinoColors.darkText)

                Text(subtitle)
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.bodyText)

                Button {} label: {
                    Text(ctaText)
                        .font(DinoFonts.subheadline)
                        .foregroundStyle(DinoColors.darkText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(DinoColors.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(12)
        }
        .dinoCard()
    }

    // MARK: - Common

    private var sponsoredPill: some View {
        Text("Sponsored")
            .font(DinoFonts.small)
            .foregroundStyle(DinoColors.bodyText)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(DinoColors.lightGray)
            .clipShape(Capsule())
    }
}
