import argparse
import matplotlib.pyplot as plt

COLOR_LOOKUP = {'muse': 'mediumblue', 'vecmap': 'orange','concat': 'grey'}
LABEL_LOOKUP = {'muse': 'MUSE', 'vecmap': 'VecMap', 'concat': 'Concatenation'}
LINESTYLE_LOOKUP = {'muse': '-', 'vecmap': '--', 'concat': '-.'}


def main():
    parser = argparse.ArgumentParser()
    # All results estimated
    parser.add_argument('--results', default={
        'fr':{
            'muse': {'base': 55.12, 'bpe': 0}, # 400, 500 and 1000 are estimated
            'vecmap': {'base': 58.22, 'bpe': 0},
            'concat': {'base': 47.71, 'bpe': 0}
        },

    })

    args = parser.parse_args()

    for lang in ['fr']:#, 'de', 'ru', 'hi']:
        for method in ['muse', 'vecmap', 'concat']:
        plt.bar(LABEL_LOOKUP.values(), args.results)
        plt.plot([dim for dim in results.keys()],
                 [acc for dim, acc in results.items()],
                 label=LABEL_LOOKUP[method], linestyle=LINESTYLE_LOOKUP[method], color=COLOR_LOOKUP[method],
                 linewidth=3)#marker='o', markersize=5)

        plt.grid()
        plt.gca().set_ylim(top=100, bottom=0)
        plt.xlabel('Embedding dimension')
        plt.ylabel('Accuracy')
        plt.legend()
        plt.show()


if __name__ == '__main__':
    main()