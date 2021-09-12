import argparse
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
from sklearn.manifold import TSNE
from gensim.models import Word2Vec
from gensim.models import KeyedVectors



def tsne_plot_2d(embeddings, words=[], a=1, color='red', path='test.pdf'):
    plt.figure(figsize=(16, 9))
    colors = [color]# cm.rainbow(np.linspace(0, 1, 1))
    x = embeddings[:,0]
    y = embeddings[:,1]
    plt.scatter(x, y, c=colors, alpha=a)
    for i, word in enumerate(words):
        plt.annotate(word, alpha=0.3, xy=(x[i], y[i]), xytext=(5, 2),
                     textcoords='offset points', ha='right', va='bottom', size=10)
    plt.grid(True)
    plt.xticks([])
    plt.yticks([])
    plt.savefig(path, format='pdf', dpi=150, bbox_inches='tight')
    plt.show()


def main():
    parser = argparse.ArgumentParser()
    # All results estimated
    parser.add_argument('--embedding', default="../data/embeddings/de-en-muse/512-bpe/vectors-de.txt")
    parser.add_argument('--color', default="blue")
    parser.add_argument('--top_k', default=20000, type=int)
    parser.add_argument('--words', default=['animal','newspaper','government','science','residents','police','economy'])
    parser.add_argument('--path', default='muse-de-en-bpe.de.pdf')
    args = parser.parse_args()

    emb = KeyedVectors.load_word2vec_format(args.embedding, binary=False)

    tsne_ak_2d = TSNE(perplexity=30, n_components=2, init='pca', n_iter=3500, random_state=32)
    #emb.sort_by_descending_frequency()  -- the KeyedVectors object is already sorted by default
    if args.words:
        vectors = tsne_ak_2d.fit_transform([emb[w] for w in args.words])
    else:
        vectors = tsne_ak_2d.fit_transform([emb[n] for n in range(0, args.top_k)])

    tsne_plot_2d(vectors, a=0.1, color=args.color, words=args.words, path=args.path)

if __name__ == '__main__':
    main()