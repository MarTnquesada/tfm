import argparse
import matplotlib.pyplot as plt
import numpy as np

LABEL_LOOKUP = {'muse': 'MUSE', 'vecmap': 'VecMap', 'concat': 'Concatenation'}
METHODS = ['muse', 'vecmap', 'concat']
BAR_WIDTH = 0.25


def main():
    parser = argparse.ArgumentParser()
    # All results estimated
    parser.add_argument('--results', default={
        'fr':{
            'muse': {'base': 56.16, 'bpe': 62.20},
            'vecmap': {'base': 58.22, 'bpe': 65.01},
            'concat': {'base': 47.71, 'bpe': 46.58}
        },
        'de':{
            'muse': {'base': 38.06, 'bpe': 41.39},
            'vecmap': {'base': 38.77, 'bpe': 46.24},
            'concat': {'base': 53.84, 'bpe': 45.28}
        },
        'ru': {
            'muse': {'base': 44.34, 'bpe': 0.14},
            'vecmap': {'base': 46.21, 'bpe': 59.98},
            'concat': {'base': 0, 'bpe': 0}
        },
        'hi': {
            'muse': {'base': 0.08, 'bpe': 42.27},
            'vecmap': {'base': 29.17, 'bpe': 44.76},
            'concat': {'base': 0, 'bpe': 0}
        },

    })

    args = parser.parse_args()


    for lang in ['fr', 'de', 'ru', 'hi']:
        r1 = np.arange(len(METHODS))
        r2 = [x + BAR_WIDTH for x in r1]
        plt.bar(r1, [args.results[lang][method]['base'] for method in METHODS], color='blue', width=BAR_WIDTH, edgecolor='white', label='Baseline')
        plt.bar(r2, [args.results[lang][method]['bpe'] for method in METHODS], color='firebrick', width=BAR_WIDTH, edgecolor='white', label='BPE')

        plt.xticks([r + BAR_WIDTH/2 for r in range(len(METHODS))], LABEL_LOOKUP.values(), fontsize=15)
        #plt.grid()
        plt.gca().set_ylim(top=100, bottom=0)
        plt.ylabel('Accuracy', fontsize=16)
        plt.legend(fontsize=16)
        plt.savefig(f'{lang}-en_bpe.png')
        plt.clf()

if __name__ == '__main__':
    main()