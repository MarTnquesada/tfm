import argparse
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
from sklearn.manifold import TSNE
from gensim.models import Word2Vec
from gensim.models import KeyedVectors


def tsne_plot_2d(embeddings, words=(), a=1, colors=('orange', 'blue'), path='test.pdf'):
    plt.figure(figsize=(16, 9))
    for i, emb in enumerate(embeddings):
        color = colors[i]# cm.rainbow(np.linspace(0, 1, 1))
        x = emb[:,0]
        y = emb[:,1]
        s = [480] * len(emb[:,0])
        plt.scatter(x, y, c=color, alpha=a, s=s)
        for i, word in enumerate(words[i]):
            plt.annotate(word, alpha=1, xy=(x[i], y[i]), xytext=(18, 8),
                         textcoords='offset points', ha='right', va='bottom', size=20)
    plt.grid(True)
    plt.xticks([])
    plt.yticks([])
    plt.savefig(path, format='pdf', dpi=150, bbox_inches='tight')
    plt.show()


def main():
    parser = argparse.ArgumentParser()
    # All results estimated
    parser.add_argument('--embedding1', default="../data/embeddings/de-en-muse/512/vectors-de.txt")
    parser.add_argument('--embedding2', default="../data/embeddings/de-en-muse/512/vectors-en.txt")
    parser.add_argument('--color1', default="orange")
    parser.add_argument('--color2', default="blue")
    parser.add_argument('--top_k', default=20000, type=int)
    parser.add_argument('--words1', default=['aspirin', 'baby', 'zeitgeist', 'polizei', 'zeitung','regierung','wissenschaft'])
    parser.add_argument('--words2', default=['aspirin', 'baby', 'zeitgeist', 'police', 'newspaper','government','science'])
    parser.add_argument('--path', default='TEST.pdf')
    args = parser.parse_args()

    tsne_ak_2d = TSNE(perplexity=30, n_components=2, init='pca', n_iter=3500, random_state=32)
    #emb.sort_by_descending_frequency()  -- the KeyedVectors object is already sorted by default
    if args.words1 or args.words2:
        emb1 = KeyedVectors.load_word2vec_format(args.embedding1, binary=False)
        vectors1 = tsne_ak_2d.fit_transform([emb1[w] for w in args.words1])
        del emb1
        emb2 = KeyedVectors.load_word2vec_format(args.embedding2, binary=False)
        vectors2 = tsne_ak_2d.fit_transform([emb2[w] for w in args.words2])
        del emb2
    else:
        emb1 = KeyedVectors.load_word2vec_format(args.embedding1, binary=False)
        vectors1 = tsne_ak_2d.fit_transform([emb1[n] for n in range(0, args.top_k)])
        del emb1
        emb2 = KeyedVectors.load_word2vec_format(args.embedding2, binary=False)
        vectors2 = tsne_ak_2d.fit_transform([emb2[n] for n in range(0, args.top_k)])
        del emb2

    tsne_plot_2d((vectors1, vectors2), a=1, colors=(args.color1, args.color2), words=(args.words1, args.words2), path=args.path)

if __name__ == '__main__':
    main()