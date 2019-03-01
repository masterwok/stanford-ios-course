//
//  EmojiArtViewController.swift
//  Emoji Art
//
//  Created by Jonathan Trowbridge on 1/15/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController
    , UIDropInteractionDelegate
    , UIScrollViewDelegate
    , UICollectionViewDataSource
    , UICollectionViewDelegate
    , UICollectionViewDelegateFlowLayout
    , UICollectionViewDragDelegate
    , UICollectionViewDropDelegate {

        private var emojis = "👻🚴🏻‍♂️🦚🦞🦜🦘🕊🦒🦕🐍🐡🐈🦡☄️".map { String($0) }

        private var emojiFont: UIFont {
            return UIFontMetrics(forTextStyle: .body)
                .scaledFont(for: UIFont.preferredFont(forTextStyle: .body))
                .withSize(64)
        }

        private var viewEmojiArt = EmojiArtView()

        @IBOutlet weak var constraintScrollViewHeight: NSLayoutConstraint!
        @IBOutlet weak var constraintScrollViewWidth: NSLayoutConstraint!
        @IBOutlet weak var collectionViewEmojis: UICollectionView! {
            didSet {
                collectionViewEmojis.dropDelegate = self
                collectionViewEmojis.dragDelegate = self
                collectionViewEmojis.dataSource = self
                collectionViewEmojis.delegate = self
            }
        }

        @IBOutlet weak var viewDropZone: UIView! {
            didSet {
                viewDropZone.addInteraction(UIDropInteraction(delegate: self))
            }
        }

        @IBOutlet weak var scrollViewDropZone: UIScrollView! {
            didSet {
                scrollViewDropZone.delegate = self
                scrollViewDropZone.minimumZoomScale = 0.1
                scrollViewDropZone.maximumZoomScale = 5.0
                scrollViewDropZone.addSubview(viewEmojiArt)
            }
        }

        private var emojiArtBackgroundImage: UIImage? {
            get {
                return self.viewEmojiArt.backgroundImage
            }
            set {
                DispatchQueue.main.async {
                    self.viewEmojiArt.backgroundImage = newValue
                    let size = newValue?.size ?? CGSize.zero

                    self.viewEmojiArt.frame = CGRect(origin: CGPoint.zero, size: size)
                    self.scrollViewDropZone?.contentSize = size

                    self.constraintScrollViewWidth?.constant = size.width
                    self.constraintScrollViewHeight?.constant = size.height

                    if let dropZone = self.viewDropZone, size.width > 0, size.height > 0 {
                        self.scrollViewDropZone?.zoomScale = max(dropZone.bounds.size.width / size.width, dropZone.bounds.size.height / size.height)
                    }
                }
            }
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return viewEmojiArt
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            constraintScrollViewWidth.constant = scrollView.contentSize.width
            constraintScrollViewHeight.constant = scrollView.contentSize.height

            print("Width: \(constraintScrollViewWidth.constant), Height: \(constraintScrollViewHeight.constant)")
        }

        func dropInteraction(
            _ interaction: UIDropInteraction
            , canHandle session: UIDropSession
        ) -> Bool {
            return session.canLoadObjects(ofClass: NSURL.self)
                && session.canLoadObjects(ofClass: UIImage.self)
        }

        func dropInteraction(
            _ interaction: UIDropInteraction
            , sessionDidUpdate session: UIDropSession
        ) -> UIDropProposal {
            return UIDropProposal(operation: .copy)
        }

        func dropInteraction(
            _ interaction: UIDropInteraction
            , performDrop session: UIDropSession
        ) {
            session.loadObjects(ofClass: NSURL.self) { urls in
                if let url = urls.first as? URL {
                    ImageFetcher.fetch(url: url) { (url, image) in
                        self.emojiArtBackgroundImage = image
                    }
                }
            }

            session.loadObjects(ofClass: UIImage.self) { images in
                if let image = images.first as? UIImage {
                    self.emojiArtBackgroundImage = image
                }
            }
        }

        //MARK: - UICollectionViewDataSource Implmentation

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return emojis.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "Emoji Cell"
                , for: indexPath
            )

            (cell as? EmojiCollectionViewCell)?.labelEmoji.attributedText = NSAttributedString(
                string: emojis[indexPath.row]
                , attributes: [.font: emojiFont]
            )

            return cell
        }

        //MARK: - UICollectionViewDropDelegate Implementation

        func collectionView(
            _ collectionView: UICollectionView
            , performDropWith coordinator: UICollectionViewDropCoordinator
        ) {
            let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)

            for item in coordinator.items {
                if let sourceIndexPath = item.sourceIndexPath {
                    if let attributedString = item.dragItem.localObject as? NSAttributedString {
                        collectionView.performBatchUpdates({
                            emojis.remove(at: sourceIndexPath.item)
                            emojis.insert(attributedString.string, at: destinationIndexPath.item)

                            collectionView.deleteItems(at: [sourceIndexPath])
                            collectionView.insertItems(at: [destinationIndexPath])
                        })

                        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                    }
                } else {
                    coordinator.drop(
                        item.dragItem
                        , to: UICollectionViewDropPlaceholder(
                            insertionIndexPath: destinationIndexPath
                            , reuseIdentifier: "Drop Placeholder Cell"
                        )
                    )
                }
            }
        }

        func collectionView(
            _ collectionView: UICollectionView
            , canHandle session: UIDropSession
        ) -> Bool {
            return session.canLoadObjects(ofClass: NSAttributedString.self)
        }

        func collectionView(
            _ collectionView: UICollectionView
            , dropSessionDidUpdate session: UIDropSession
            , withDestinationIndexPath destinationIndexPath: IndexPath?
        ) -> UICollectionViewDropProposal {
            let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView

            if isSelf {
                return UICollectionViewDropProposal(
                    operation: .move
                    , intent: .insertAtDestinationIndexPath
                )
            }

            return UICollectionViewDropProposal(
                operation: .copy
                , intent: .insertAtDestinationIndexPath
            )
        }

        //MARK: - UICollectionViewDragDelegate Implementation

        func collectionView(
            _ collectionView: UICollectionView
            , itemsForBeginning session: UIDragSession
            , at indexPath: IndexPath
        ) -> [UIDragItem] {
            session.localContext = collectionView

            return dragItems(at: indexPath)
        }

        private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
            if let attributedText = (collectionViewEmojis.cellForItem(at: indexPath)
                as? EmojiCollectionViewCell)?.labelEmoji?.attributedText {

                let dragItem = UIDragItem(itemProvider: NSItemProvider(object: attributedText))

                dragItem.localObject = attributedText

                return [dragItem]
            }

            return []
        }

        func collectionView(
            _ collectionView: UICollectionView
            , itemsForAddingTo session: UIDragSession
            , at indexPath: IndexPath
            , point: CGPoint
        ) -> [UIDragItem] {
            return dragItems(at: indexPath)
        }


}
