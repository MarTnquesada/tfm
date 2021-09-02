import argparse
import matplotlib.pyplot as plt
import numpy as np

LABEL_LOOKUP = {'baseline': 'Baseline', 'muse': 'MUSE', 'vecmap': 'VecMap', 'concat': 'Concatenation'}
METHODS = ['baseline', 'muse', 'vecmap', 'concat']
BAR_WIDTH = 0.25


def main():
    parser = argparse.ArgumentParser()
    # All results estimated
    parser.add_argument('--results', default={
        'fr':{
            'baseline': {'base': 0, 'bpe': 0},  #
            'muse': {'base': 55.12, 'bpe': 199},
            'vecmap': {'base': 58.22, 'bpe': 99},
            'concat': {'base': 47.71, 'bpe': 99}
        },

    })

    args = parser.parse_args()


    for lang in ['fr']:#, 'de', 'ru', 'hi']:
        r1 = np.arange(len(METHODS))
        r2 = [x + BAR_WIDTH for x in r1]
        plt.bar(r1, [args.results[lang][method]['base'] for method in METHODS], color='blue', width=BAR_WIDTH, edgecolor='white', label='Base')
        plt.bar(r2, [args.results[lang][method]['bpe'] for method in METHODS], color='firebrick', width=BAR_WIDTH, edgecolor='white', label='BPE')

        plt.xticks([r + BAR_WIDTH/2 for r in range(len(METHODS))], LABEL_LOOKUP.values(), fontsize=15)
        #plt.grid()
        plt.gca().set_ylim(top=100, bottom=0)
        plt.ylabel('Accuracy', fontsize=16)
        plt.legend(fontsize=16)
        plt.show()
        plt.clf()

if __name__ == '__main__':
    main()