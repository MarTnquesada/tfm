import argparse
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
from sklearn.manifold import TSNE
from gensim.models import Word2Vec
from gensim.models import KeyedVectors



def tsne_plot_2d(label, embeddings, words=[], a=1):
    plt.figure(figsize=(16, 9))
    colors = cm.rainbow(np.linspace(0, 1, 1))
    x = embeddings[:,0]
    y = embeddings[:,1]
    plt.scatter(x, y, c=colors, alpha=a, label=label)
    for i, word in enumerate(words):
        plt.annotate(word, alpha=0.3, xy=(x[i], y[i]), xytext=(5, 2),
                     textcoords='offset points', ha='right', va='bottom', size=10)
    plt.legend(loc=4)
    plt.grid(True)
    plt.savefig("hhh.png", format='png', dpi=150, bbox_inches='tight')
    plt.show()


def main():
    parser = argparse.ArgumentParser()
    # All results estimated
    parser.add_argument('--embedding', default="../data/embeddings/monolingual-fr-3-6-50.vec")
    args = parser.parse_args()

    emb = KeyedVectors.load_word2vec_format(args.embedding, binary=False)

    tsne_ak_2d = TSNE(perplexity=30, n_components=2, init='pca', n_iter=3500, random_state=32)
    #emb.sort_by_descending_frequency()  -- the KeyedVectors object is already sorted by default
    vectors = tsne_ak_2d.fit_transform([emb[n] for n in range(0, 9999)])

    tsne_plot_2d('Oiseau', vectors, a=0.1)

if __name__ == '__main__':
    main()